# Language servers

[← Back to the README](../README.md)

## How links are found

1. **Name matching** links names between files. This is fast and always
   works, but it can be wrong. These links are drawn **dashed**.
2. **Language servers**, if installed, check each link. Confirmed links
   are drawn **solid**, wrong ones are removed, and missed ones are added.
   They also show where changed code is used outside the diff.

The canvas shows the name links first and upgrades them when the servers
finish. The first run in a repo can take a while, because the servers
index the project.

## The pill in the top bar

It reads **Checking links…** while the servers work, then which servers
checked the links. Click it to see each language's server, and how to
install a missing one.

## Servers

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
| HCL (Terraform, OpenTofu) | terraform-ls or tofu-ls | your package manager or releases.hashicorp.com |

Other HCL files, like Packer or Nomad files, keep their name links: the
servers only read Terraform and OpenTofu files.

## Limits

- Servers read files from disk. For a commit range whose files differ
  from your working tree, links in those files stay unconfirmed.
- `--no-lsp` skips servers. `--lsp-timeout SECS` sets how long to wait
  for indexing (default 120).
