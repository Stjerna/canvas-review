# canvas-review

See what changed in a git repo, and how the changes connect, on a canvas
in your browser. Made for reviewing work done by coding agents.

- Each changed file is a card, grouped by folder.
- An arrow from A to B means A uses names that B defines.
- Click a file to see its changed functions and types, its links, and its diff.
- Files are numbered in reading order, so you meet the building blocks first.
- Live mode follows along while an agent works.

This repo holds release binaries only.

## Install

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

Run it again to update. To pick a version or folder, set
`CANVAS_REVIEW_VERSION` (like `v0.1.0`) or `CANVAS_REVIEW_INSTALL_DIR`
first:

```sh
curl -fsSL https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.sh | CANVAS_REVIEW_VERSION=v0.1.0 sh
```

You can read [install.sh](install.sh) and [install.ps1](install.ps1)
before running them.

**By hand**

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

## Use

Run it inside a git repo:

```sh
canvas-review            # open the canvas on the likely range
canvas-review -u         # uncommitted changes
canvas-review -l 3       # last 3 commits, bundled
canvas-review -b main    # current branch vs main
canvas-review --from A --to B
canvas-review -r ../other-repo   # a repo other than the one you are in
```

With no range flag it opens on uncommitted changes. If there are none, it
shows your branch's work since it left `main`, else the last commit.

In the browser:

- Press **G** to pick another range from a branch graph.
- **N** and **P** step through files in reading order. **R** marks one
  reviewed. **Esc** closes it.
- **[** and **]** step through the commits in a range.
- Click **Live** in the top bar to pause live updates.

Run `canvas-review --help` for all flags.

## Better links with language servers

Links are first found by matching names, which can be wrong. These are
drawn **dashed**. If a language server is installed, it checks each link.
Confirmed links are drawn **solid**, and it also finds where changed code
is used outside the diff.

| Language | Server | Install |
|---|---|---|
| Rust | rust-analyzer | `rustup component add rust-analyzer` |
| TypeScript, JavaScript | `tsc --lsp` (TypeScript 7+, from the project) or typescript-language-server | `npm install -g typescript-language-server typescript` |
| Python | basedpyright, pyright or pylsp | `npm install -g pyright` |
| Go | gopls | `go install golang.org/x/tools/gopls@latest` |
| C, C++ | clangd | your package manager |
| Java | jdtls | Eclipse JDT Language Server |
| Ruby | ruby-lsp or solargraph | `gem install ruby-lsp` |
| C# | csharp-ls | `dotnet tool install --global csharp-ls` |
| PHP | intelephense | `npm install -g intelephense` |
| Kotlin | kotlin-lsp or kotlin-language-server | github.com/Kotlin/kotlin-lsp |
| Swift | sourcekit-lsp | comes with the Swift toolchain |
| Scala | metals | `cs install metals` |
| Lua | lua-language-server | your package manager |
| Bash | bash-language-server | `npm install -g bash-language-server` |
| Elixir | expert, elixir-ls, lexical or nextls | github.com/elixir-lang/expert |
| Zig | zls | your package manager |
| Haskell | haskell-language-server | `ghcup install hls` |

The pill in the top bar shows which servers checked the links. Click it
to see how to install a missing one.

## Privacy

Everything runs on your machine. The local server only answers requests
that carry the secret token in the link it prints, so other websites
can't read your code through it.
