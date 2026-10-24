# Terminal dotfiles

Personal tmux and Neovim configuration, using TokyoNight Moon with lavender accents.

## Files

- `tmux/tmux.conf`: mouse support, navigation between tmux panes and Neovim splits, and tmux colors.
- `nvim/`: LazyVim configuration, custom terminal management, and C++, Python, and Rust extras.
- `nvim/lazy-lock.json`: pinned Neovim plugin commits. Keep this file when updating the repository.

Installed locations are symlinks:

```text
~/.tmux.conf   -> ~/dotfiles/tmux/tmux.conf
~/.config/nvim -> ~/dotfiles/nvim
```

Edit either the installed paths or files in this folder; they refer to the same files after installation.

## Environment

The source machine used macOS, Neovim 0.12.6, tmux 3.6b, zsh, and iTerm2.
Its iTerm2 profile selected JetBrainsMono Nerd Font Mono Regular at 14 pt
(`JetBrainsMonoNFM-Regular`). Install the font separately for matching icons.

Install Neovim, tmux, Git, ripgrep (`rg`), and `fd` before setting up another machine.
Language features also need the appropriate runtimes and tools: a C/C++ toolchain,
Python, and Rust/Cargo. LazyVim's Mason integration manages many language servers
and formatters. Use `:checkhealth` and `:Mason` to inspect missing dependencies.

Downloaded plugins, language servers, caches, and terminal application preferences
are not included in this repository.

## Install on another machine

Place this folder at `~/dotfiles`. Back up any existing `~/.tmux.conf` and
`~/.config/nvim` before linking. Run the following only when both destinations
are absent:

```sh
mkdir -p ~/.config
ln -s "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
```

Open Neovim to bootstrap lazy.nvim, then run `:Lazy restore` to restore the plugin
commits recorded in `lazy-lock.json`. Restart Neovim afterward. On first launch,
plugin installation requires network access. Keep the recorded lockfile if the
initial bootstrap changes it before restoring.

Start tmux, or reload an existing session from a shell inside tmux:

```sh
tmux source-file ~/.tmux.conf
```

## Shortcuts

The tmux prefix is the default **Ctrl+b**. Neovim's leader is **Space**.

| Context | Shortcut | Action |
| --- | --- | --- |
| tmux / Neovim | Ctrl+h/j/k/l | Navigate left/down/up/right across panes and splits |
| Shell directly in tmux | Prefix, then Ctrl+l | Send the shell's clear-screen shortcut |
| Neovim normal mode | Space t n | Create a terminal |
| Neovim normal mode | Space t t | Pick a terminal |
| Neovim normal mode | Space t ] / Space t [ | Next / previous terminal |
| Neovim normal mode | Space f t | Open terminal at the project root; accepts a numeric count |
| Neovim normal or terminal mode | Ctrl+/ (or Ctrl+_) | Toggle a terminal |
| Snacks terminal | Escape twice | Leave terminal input mode |

Terminal selection and visibility are currently shared across Neovim tabs.
Ctrl+h/j/k/l are reserved for navigation, including in terminal input mode.

The tmux configuration does not explicitly select vi copy-mode keys. To use
Ctrl+u/d for half-page scrolling, add `setw -g mode-keys vi`, reload tmux, then
press prefix followed by `[` to enter copy mode. Use `q` to exit copy mode.

## iTerm2 and shell settings

These files do not include an exported iTerm2 profile or `.zshrc`.
To reproduce the terminal font and application settings, export the desired
profile from iTerm2 separately and review it before adding it to this repository.
Global key mappings may need separate configuration.

For the macOS deletion shortcuts discussed with this setup, configure the
following iTerm2 profile key mappings using **Send Hex Code**:

| Shortcut | Hex code | Expected zsh action |
| --- | --- | --- |
| Cmd+Backspace | `0x15` | Ctrl+u: delete the whole input line |
| Option+Backspace | `0x17` | Ctrl+w: delete the previous word |

Those actions rely on zsh's bindings and apply at a shell prompt. In a Neovim
editing buffer, the same bytes follow Neovim's key bindings instead.

## Updating

Review configuration changes and plugin lockfile changes together. Avoid adding
plugin downloads, logs, shell history, credentials, or machine-specific secrets.
No Git repository initialization or other Git actions are part of this setup.
