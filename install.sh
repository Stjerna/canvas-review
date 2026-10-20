#!/bin/sh
# Installs canvas-review from a GitHub release.
#
#   curl -fsSL https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.sh | sh
#
# Options, set as environment variables:
#   CANVAS_REVIEW_VERSION      a release tag like v0.1.0 (default: latest)
#   CANVAS_REVIEW_INSTALL_DIR  where to put the binary (default: ~/.local/bin)
#   CANVAS_REVIEW_NO_UPDATE    set to 1 to turn off self-updates
#
# canvas-review updates itself once a day. Pinning a version turns that off.

set -eu

repo=Stjerna/canvas-review
version=${CANVAS_REVIEW_VERSION:-latest}
dir=${CANVAS_REVIEW_INSTALL_DIR:-$HOME/.local/bin}
no_update=${CANVAS_REVIEW_NO_UPDATE:-}
config=${XDG_CONFIG_HOME:-$HOME/.config}/canvas-review

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

case "$(uname -s)" in
  Linux) os=unknown-linux-gnu ;;
  Darwin) os=apple-darwin ;;
  *) fail "no build for $(uname -s). On Windows, use install.ps1." ;;
esac

case "$(uname -m)" in
  x86_64 | amd64) arch=x86_64 ;;
  arm64 | aarch64) arch=aarch64 ;;
  *) fail "no build for $(uname -m)." ;;
esac

# A shell running under Rosetta reports x86_64 on an Apple Silicon Mac.
# The native build is faster there.
if [ "$os" = apple-darwin ] && [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = 1 ]; then
  arch=aarch64
fi

target=$arch-$os
if [ "$target" = aarch64-unknown-linux-gnu ]; then
  fail "no build for Linux on ARM yet."
fi

if [ "$version" = latest ]; then
  base=https://github.com/$repo/releases/latest/download
else
  base=https://github.com/$repo/releases/download/$version
fi

fetch() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -o "$2" "$1"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$2" "$1"
  else
    fail "needs curl or wget."
  fi
}

sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | cut -d' ' -f1
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | cut -d' ' -f1
  fi
}

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

file=canvas-review-$target.tar.gz
printf 'Downloading %s (%s)\n' "$file" "$version"
fetch "$base/$file" "$tmp/$file" || fail "download failed: $base/$file"
fetch "$base/SHA256SUMS" "$tmp/SHA256SUMS" || fail "download failed: $base/SHA256SUMS"

expected=$(awk -v f="$file" '$2 == f { print $1 }' "$tmp/SHA256SUMS")
actual=$(sha256 "$tmp/$file")
if [ -z "$actual" ]; then
  printf 'warning: no sha256sum or shasum found, so the download was not checked\n' >&2
elif [ "$expected" != "$actual" ]; then
  fail "checksum mismatch for $file. Try again, or download it by hand."
fi

tar -xzf "$tmp/$file" -C "$tmp"
mkdir -p "$dir"
mv "$tmp/canvas-review" "$dir/canvas-review"
chmod 755 "$dir/canvas-review"

# The binary isn't signed. Clear the flag macOS uses to block it.
if [ "$os" = apple-darwin ]; then
  xattr -d com.apple.quarantine "$dir/canvas-review" 2>/dev/null || true
fi

printf 'Installed %s to %s\n' "$("$dir/canvas-review" --version)" "$dir/canvas-review"

# The binary skips its daily update check while this file exists.
if [ "$version" != latest ] || { [ -n "$no_update" ] && [ "$no_update" != 0 ]; }; then
  mkdir -p "$config"
  : > "$config/no-update"
  printf 'Self-updates are off. Run this script again without options to turn them on.\n'
else
  rm -f "$config/no-update"
  printf 'canvas-review updates itself once a day.\n'
fi

case ":$PATH:" in
  *":$dir:"*) ;;
  *)
    printf '\n%s is not on your PATH. Add this line to your shell config:\n' "$dir"
    printf '  export PATH="%s:$PATH"\n' "$dir"
    ;;
esac
