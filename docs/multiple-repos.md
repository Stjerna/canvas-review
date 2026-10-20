# Several repos

[← Back to the README](../README.md)

## Open another repo

Click the repo name at the top left, press **O**, or pick **Open another
repo** in the menu. Pick a recent repo, or browse your folders. Repos are
shown in bold.

- **Open here** swaps the repo in this tab.
- **Open in new tab** keeps this one too. Both tabs run at the same time,
  each with its own live mode and language servers.
- **Add to this canvas** shows the repo next to the ones open now.

## Several repos on one canvas

Useful when one change spans services, like a frontend, a BFF and a core
service. Add a repo with **+ Add repo** in the top bar, or **Add to this
canvas** in the repo picker.

Each repo gets its own box on the canvas, and a chip in the top bar, in
the same color.

- Each repo has its own range. Click its chip, or the name on top of its
  box, to pick it. **G** does it for the repo of the open file.
- Point at a chip to light up its repo on the canvas.
- The **✕** on a chip's corner takes the repo off the canvas.
- Live mode watches every repo, and reloads only the one that changed.

Once a canvas shows several repos, **Open here** is replaced by **Add to
this canvas**, so one click can't throw the set away. **Open in new tab**
still works.

Good to know:

- Files are linked within a repo, not across repos.
- Stepping through commits only works with one repo, since commits in
  different repos don't line up.

## Saved in the URL

The repos and their ranges are part of the page URL. So each tab
remembers its own, and a bookmark brings the same set back.

Recent repos are kept in:

- Linux: `~/.local/state/canvas-review/recent.json`
- macOS: `~/Library/Application Support/canvas-review`
- Windows: `%LOCALAPPDATA%`
