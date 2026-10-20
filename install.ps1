# Installs canvas-review from a GitHub release.
#
#   irm https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.ps1 | iex
#
# Options, set as environment variables:
#   CANVAS_REVIEW_VERSION      a release tag like v0.1.0 (default: latest)
#   CANVAS_REVIEW_INSTALL_DIR  where to put the binary
#                              (default: %LOCALAPPDATA%\Programs\canvas-review)
#   CANVAS_REVIEW_NO_UPDATE    set to 1 to turn off self-updates
#
# canvas-review updates itself once a day. Pinning a version turns that off.

$ErrorActionPreference = 'Stop'
# Windows PowerShell 5.1 needs TLS 1.2 turned on, and its progress bar
# makes downloads very slow.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

$repo = 'Stjerna/canvas-review'
$version = if ($env:CANVAS_REVIEW_VERSION) { $env:CANVAS_REVIEW_VERSION } else { 'latest' }
$dir = if ($env:CANVAS_REVIEW_INSTALL_DIR) {
    $env:CANVAS_REVIEW_INSTALL_DIR
} else {
    Join-Path $env:LOCALAPPDATA 'Programs\canvas-review'
}

if (-not [Environment]::Is64BitOperatingSystem) {
    Write-Error 'canvas-review needs 64-bit Windows.'
    return
}

$base = if ($version -eq 'latest') {
    "https://github.com/$repo/releases/latest/download"
} else {
    "https://github.com/$repo/releases/download/$version"
}

$file = 'canvas-review-x86_64-pc-windows-msvc.zip'
$tmp = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null

try {
    Write-Host "Downloading $file ($version)"
    $zip = Join-Path $tmp $file
    $sums = Join-Path $tmp 'SHA256SUMS'
    Invoke-WebRequest "$base/$file" -OutFile $zip -UseBasicParsing
    Invoke-WebRequest "$base/SHA256SUMS" -OutFile $sums -UseBasicParsing

    $line = Get-Content $sums | Where-Object { ($_ -split '\s+')[1] -eq $file }
    $expected = ($line -split '\s+')[0]
    $actual = (Get-FileHash -Algorithm SHA256 $zip).Hash.ToLower()
    if ($expected -ne $actual) {
        Write-Error "Checksum mismatch for $file. Try again, or download it by hand."
        return
    }

    Expand-Archive $zip -DestinationPath $tmp -Force
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $exe = Join-Path $dir 'canvas-review.exe'
    Move-Item -Force (Join-Path $tmp 'canvas-review.exe') $exe
} finally {
    Remove-Item -Recurse -Force $tmp
}

Write-Host "Installed $(& $exe --version) to $exe"

# The binary skips its daily update check while this file exists.
$config = Join-Path $env:APPDATA 'canvas-review'
$noUpdate = Join-Path $config 'no-update'
if ($version -ne 'latest' -or ($env:CANVAS_REVIEW_NO_UPDATE -and $env:CANVAS_REVIEW_NO_UPDATE -ne '0')) {
    New-Item -ItemType Directory -Force -Path $config | Out-Null
    New-Item -ItemType File -Force -Path $noUpdate | Out-Null
    Write-Host 'Self-updates are off. Run this script again without options to turn them on.'
} else {
    Remove-Item -Force -ErrorAction SilentlyContinue $noUpdate
    Write-Host 'canvas-review updates itself once a day.'
}

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($userPath -split ';') -notcontains $dir) {
    $newPath = if ($userPath) { "$userPath;$dir" } else { $dir }
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    $env:Path = "$env:Path;$dir"
    Write-Host "Added $dir to your PATH. Open a new terminal to use it everywhere."
}
