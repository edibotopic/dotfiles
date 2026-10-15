# Doom Emacs config

Managed with [chezmoi](https://www.chezmoi.io/) (source:
`github.com/edibotopic/dotfiles`, stored under
`private_dot_config/doom/`). Doom core lives at `~/.config/emacs`
(git clone of doomemacs/doomemacs); this directory (`$DOOMDIR`,
`~/.config/doom`) holds only the private config.

## Everyday use

- Daemon autostarts on login via systemd (see below) and stays warm,
  so opening Emacs is instant.
- `ec` — open a new GUI frame on the running daemon
  (`emacsclient -c -n`).
- `et` — open a terminal/TTY frame on the running daemon
  (`emacsclient -t`).
- `SPC t n` — toggle between `doom-nano-light` / `doom-nano-dark`
  manually.
- Theme also auto-switches with Ubuntu/GNOME's light/dark setting
  via `auto-dark-mode` (reads `org.gnome.desktop.interface
  color-scheme`), so manual toggling is rarely needed.

## Making changes

- Edit `config.el` for most settings (fonts, theme, keybindings,
  per-package config). No `doom sync` needed — just `M-x
  doom/reload` or restart the daemon.
- Edit `init.el` to enable/disable Doom modules (langs, tools, UI,
  etc). **Requires `doom sync`** afterwards.
- Edit `packages.el` to add/remove packages. **Requires `doom
  sync`** afterwards.

After any `init.el`/`packages.el` change:

```sh
~/.config/emacs/bin/doom sync
systemctl --user restart emacs.service
```

(`doom sync` rebuilds the package profile; the daemon restart is
needed because the running daemon process doesn't pick up new
modules/packages on its own.)

Useful diagnostics:

```sh
~/.config/emacs/bin/doom doctor   # sanity-check env/config
~/.config/emacs/bin/doom gc       # purge orphaned packages (housekeeping)
journalctl --user -u emacs.service -n 50   # daemon boot logs
```

If the daemon ever hangs on startup (e.g. a package errors during
`--fg-daemon` boot with no TTY to show a debugger), check
`journalctl --user -u emacs.service` for a timeout, and debug with:

```sh
emacs28 --fg-daemon --debug-init
```

run directly in a terminal (not via systemd) so errors surface
instead of silently hanging.

## Daemon service

Custom systemd user unit at
`~/.config/systemd/user/emacs.service` (not chezmoi-managed, no
auto-enable hook — set up manually, see "New machine" below). Runs
`/usr/bin/emacs28 --fg-daemon`. Debian's packaged `emacs28.service`
isn't used because it hardcodes the versioned binary name; this
unit is named generically so plain `emacsclient` finds it.

```sh
systemctl --user status emacs.service
systemctl --user restart emacs.service
systemctl --user stop emacs.service
```

## Fonts

N Λ N O–style setup needs these installed:

- **Roboto Mono** — `doom-font` (fixed-pitch/code)
- **Roboto** — `doom-variable-pitch-font` (prose)
- **Roboto Slab** — `doom-serif-font`

Roboto / Roboto Slab usually ship with Ubuntu already; Roboto Mono
often doesn't and may need manual install from
[google/fonts](https://github.com/google/fonts) (`ofl/robotomono/`)
into `~/.local/share/fonts/`, then `fc-cache -f`.

## Setting up on a new machine

### Linux (this machine)

1. Install Emacs 28+ (`sudo apt install emacs28` or similar).
2. Clone Doom core: `git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs`
3. `chezmoi init --apply edibotopic` (or `chezmoi apply` if already
   initialised) to lay down this `$DOOMDIR`.
4. `~/.config/emacs/bin/doom install` (first-time setup; answer
   prompts).
5. `~/.config/emacs/bin/doom sync`
6. Install fonts (see above), then `fc-cache -f`.
7. Create `~/.config/systemd/user/emacs.service` (see contents
   above — not chezmoi-managed on purpose) then:
   ```sh
   systemctl --user daemon-reload
   systemctl --user enable --now emacs.service
   ```
8. Confirm `ec`/`et` aliases are present (from `~/.aliases`, also
   chezmoi-managed).

### Windows

Config itself (`init.el`/`config.el`/`packages.el`) is written to be
portable (the Fish/bash shell fix is guarded with `IS-WINDOWS`,
`auto-dark` supports Windows natively via the registry, the nano
theme is pure elisp). What differs is install/daemon mechanics:

1. Install Emacs for Windows (29+ recommended for best native
   compatibility) and Git for Windows.
2. Clone Doom core to `%APPDATA%\.config\emacs` (or wherever
   `$DOOMDIR`/`$EMACSDIR` resolve on Windows — check
   `doomemacs/doomemacs` docs for the current Windows path
   convention, it's moved around across Doom versions).
3. `chezmoi init --apply edibotopic` (chezmoi runs natively on
   Windows and handles path differences).
4. `doom install`, then `doom sync` as above (run from Git Bash or
   PowerShell).
5. Install fonts normally (right-click `.ttf` → "Install"), no
   `fc-cache` step needed.
6. **No systemd on Windows.** For daemon autostart, options:
   - Simplest: a shortcut to `runemacs.exe --daemon` in the
     `shell:startup` folder.
   - More robust: a Task Scheduler task ("At log on", action
     `runemacs.exe --fg-daemon`) — closer to how the Linux unit
     behaves (restart-on-failure etc. need to be configured in the
     task's settings instead of systemd's).
   - This unit is **not chezmoi-managed** on Linux either, so you'll
     set up the Windows equivalent manually the same way.
7. `emacsclientw.exe -c -n` / `emacsclient.exe -t` replace the
   `ec`/`et` aliases — add equivalents to your PowerShell profile if
   you want the same shorthand.
8. **vterm caveat**: vterm's native module needs a C compiler
   (MSYS2/clang) on Windows and is generally flakier there; if it's
   troublesome, it's safe to leave that module enabled and just not
   rely on it, or disable `vterm` in `init.el` on that machine.

## Known gaps / external deps

- **vterm**: needs `libvterm-dev` + `libtool-bin` (+ `cmake`)
  installed *before* `doom sync` builds it, otherwise its native
  module silently fails to compile and needs a rebuild (`rm -rf
  ~/.config/emacs/.local/straight/build-*/vterm && doom sync`).
- **clojure +lsp**: needs the external `clojure-lsp` binary
  installed separately (not an Emacs package) — see
  clojure-lsp.github.io.
- **gdscript +lsp**: needs a running Godot editor instance to
  connect to; not a standalone LSP binary.
- **janet module**: present in Doom but currently an empty stub
  (no packages/config) — enabling it does nothing functionally yet.
