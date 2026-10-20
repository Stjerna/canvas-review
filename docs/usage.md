# Usage

[← Back to the README](../README.md)

## Run it

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

Outside a git repo, it opens on a repo picker instead.

## Pick a range in the browser

Click the branch icon at the top left, or press **G**. It opens a branch
graph, like `git log --graph`. An orange dot on the icon means there are
uncommitted changes.

- Click a commit to see just that one.
- Shift-click a second commit to see everything between them. Commits on
  different branches are compared directly.
- Click a branch name to see its work since it split off from `main`.
- Click **Uncommitted changes** at the top for work not committed yet.
- Tick **Remote branches** to show branches like `origin/main` too.
- Or type any two refs at the bottom.

The range is kept in the page URL, so Back, Forward and reload work.

## Keyboard shortcuts

| Key | Does |
|---|---|
| **G** | Pick a range |
| **N** / **P** | Next / previous file in reading order |
| **R** | Mark the open file reviewed |
| **Esc** | Close the open file |
| **[** / **]** | Step through the commits in a range |
| **O** | Open or add another repo |
| **?** | Show all shortcuts |

## Menu

The **☰** button at the top right has **Refresh**, **Open another repo**
and **Keyboard shortcuts**.

## Stop it

Press Ctrl+C in the terminal. Tabs opened with **Open in new tab** close
by themselves. Browsers don't let a page close the first tab, so it shows
**Canvas stopped** instead.

## Other flags

- `--print` lists changed files in the terminal instead.
- `--json` prints the raw change data.
- `--port N` and `--no-open` control the local server.
- `--no-lsp` skips language servers. `--lsp-timeout SECS` sets how long
  to wait for indexing (default 120).

Run `canvas-review --help` for all flags.
