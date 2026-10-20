# Install

[← Back to the README](../README.md)

## With the install script

**Linux and macOS**

```sh
curl -fsSL https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.sh | sh
```

**Windows** (PowerShell, not tested)

```powershell
irm https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.ps1 | iex
```

The script picks the right build for your system, checks it against
`SHA256SUMS`, and installs it without needing admin rights:

- Linux and macOS: `~/.local/bin`
- Windows: `%LOCALAPPDATA%\Programs\canvas-review`, added to your `PATH`

You can read [install.sh](../install.sh) and [install.ps1](../install.ps1)
before running them.

## Updates

canvas-review updates itself. Once a day it checks for a new release in
the background. If there is one, it downloads it, checks it against
`SHA256SUMS`, and uses it the next time you run it.

To turn this off, install with `CANVAS_REVIEW_NO_UPDATE=1`, or set
`CANVAS_REVIEW_NO_UPDATE=1` in your shell. Pinning a version turns it off
too. Run the script again without options to turn it back on.

## A version or folder of your choice

Set `CANVAS_REVIEW_VERSION` (like `v0.2.0`) or `CANVAS_REVIEW_INSTALL_DIR`
first:

```sh
curl -fsSL https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.sh | CANVAS_REVIEW_VERSION=v0.2.0 sh
```

## By hand

Download the file for your system from
[Releases](https://github.com/Stjerna/canvas-review/releases/latest),
unpack it, and put `canvas-review` somewhere on your `PATH`.

| System | File |
|---|---|
| Linux x86_64 | `canvas-review-x86_64-unknown-linux-gnu.tar.gz` |
| macOS Apple Silicon | `canvas-review-aarch64-apple-darwin.tar.gz` |
| macOS Intel | `canvas-review-x86_64-apple-darwin.tar.gz` |
| Windows x86_64 | `canvas-review-x86_64-pc-windows-msvc.zip` |

The binary isn't signed. If macOS blocks it, run:

```sh
xattr -d com.apple.quarantine /path/to/canvas-review
```
