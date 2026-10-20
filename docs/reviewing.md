# Reviewing a change

[← Back to the README](../README.md)

## The canvas

- Each changed file is a card, grouped by folder.
- An arrow from A to B means A uses names that B defines.
- Click a file to see its changed functions and types, its links, and its
  diff.
- Dashed cards are files outside the diff that use changed code. Click
  one to see the code around each use. Toggle them with **Outside users**
  in the [filters](filters.md). If there are more than 30, they start
  hidden.
- Lock files and other generated files are hidden. Show them with
  **Generated** in the [filters](filters.md). Mark your own with
  `linguist-generated` in `.gitattributes`.

To see only some files, like one folder or the files near one file, use
the [filters](filters.md).

Links are first found by matching names, which can be wrong. These are
drawn **dashed**. Install a [language server](language-servers.md) to
check them.

Supported languages, with colors and links: Rust, Python, JavaScript,
TypeScript, Go, Java, C, C++, Ruby, C#, PHP, Kotlin, Swift, Scala, Lua,
Bash, Elixir, Zig and Haskell. CSS, HTML and JSON get colors only. Other
files still show up, without colors or links.

## Reading order

Each file card has a number. Files come after the files they use, so you
meet the building blocks first. Files with no links, like docs and
config, come last.

- Click **0 of N reviewed** in the top bar to open the next file to read.
- In a file, tick **Reviewed**, or use **Prev** and **Next**.
- Keys: **N** next file, **P** previous file, **R** mark reviewed,
  **Esc** close the file.

Ticks are kept in your browser. If a reviewed file changes again, it
counts as unreviewed until you look at it again.

## Function view

Click the **▸ 3** button on a file card to show its changed functions,
classes and other symbols inside it. Links then run between functions,
not whole files.

- **Functions** in the [filters](filters.md) opens or closes every file.
- Click a function to jump to it in the diff.

## Jump along links

In a file's **Uses** and **Used by** lists, click a name to open the
other file right at it:

- **Used by:** where that file uses the name.
- **Uses:** where that file defines the name, even if it didn't change.

The code shows at the top of the panel, with a **Back** button.

## Step through commits

When a range has more than one commit, a bar under the top bar lets you
walk them in order. Each step shows the range up to that commit, and the files
it touched glow.

- Use the **◀ ▶** buttons, the dots, or the **[** and **]** keys.
- **All N commits** goes back to the whole range.

Language servers don't check links while stepping, since they read the
files on disk. Stepping only works with one repo on the canvas.

## Live mode

Live mode is on by default. While an agent works, the canvas follows
along when files change or commits land.

- Changed files glow for a moment.
- A note at the bottom names them: new, changed, or no longer changed.
- The camera stays where you left it.

Click **Live** in the top bar to pause.
