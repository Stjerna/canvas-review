# canvas-review

See what changed in a git repo, and how the changes connect, on a canvas
in your browser. Made for reviewing work done by coding agents.

- Each changed file is a card, grouped by folder.
- An arrow from A to B means A uses names that B defines.
- Click a file to see its changed functions and types, its links, and its diff.
- Files are numbered in reading order, so you meet the building blocks first.
- Filters narrow the canvas: by folder, language, impact, unused code and more.
- Live mode follows along while an agent works.
- Put several repos on one canvas, when one change spans services.

This repo holds release binaries and docs only.

## Install

**Linux and macOS**

```sh
curl -fsSL https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.sh | sh
```

**Windows** (PowerShell, not tested)

```powershell
irm https://raw.githubusercontent.com/Stjerna/canvas-review/main/install.ps1 | iex
```

It updates itself once a day. See [Install](docs/install.md) for
versions, updates and installing by hand.

## Quick start

Run it inside a git repo:

```sh
canvas-review
```

It opens the canvas in your browser, on your uncommitted changes. If
there are none, on your branch's work since it left `main`, else on the
last commit.

## Docs

- [Install](docs/install.md): install scripts, updates, versions, by hand
- [Usage](docs/usage.md): ranges, flags, keyboard shortcuts
- [Reviewing a change](docs/reviewing.md): the canvas, reading order,
  functions, live mode
- [Filters](docs/filters.md): narrow the canvas to the files you care about
- [Several repos](docs/multiple-repos.md): other repos, and several on one canvas
- [Language servers](docs/language-servers.md): better links

## Privacy

Everything runs on your machine. The local server only answers requests
that carry the secret token in the link it prints, so other websites
can't read your code through it.
