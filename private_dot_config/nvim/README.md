# Neovim config (chezmoi-managed)

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim).

## Version pinning

Two layers keep plugin versions stable and reproducible:

1. **`lazy-lock.json`** — auto-generated lockfile recording the exact commit
   of every installed plugin (like `package-lock.json`/`Cargo.lock`). This
   file is tracked in chezmoi and is what makes a fresh install reproducible.
2. **Per-plugin `version`/`branch` fields** in `lua/plugins/*.lua` — constrain
   which commits `:Lazy update` is even allowed to pull for that plugin (e.g.
   `version = "1.*"` pins to a semver major, `branch = "main"` pins to a
   branch instead of a tag). The lockfile still records the exact commit on
   top of this.

### Day to day — just use what's installed

Nothing to do. Plugins run at the exact commits in `lazy-lock.json`.

### Updating plugins (deliberate, reviewed)

```vim
:Lazy update       " pulls newer commits, respecting each plugin's version/branch constraint
```

Then test your setup actually still works, and sync the new lockfile to
chezmoi:

```bash
cp ~/.config/nvim/lazy-lock.json ~/.local/share/chezmoi/private_dot_config/nvim/lazy-lock.json
cd ~/.local/share/chezmoi
git add private_dot_config/nvim/lazy-lock.json
git commit -m "Update nvim plugin lockfile"
```

If an update breaks something, `git diff`/`git checkout` the previous
`lazy-lock.json` and run `:Lazy restore` to roll back to the last-known-good
commits.

### New machine setup

```bash
chezmoi apply
nvim   # lazy.nvim bootstraps itself and installs plugins
:Lazy restore   # forces every plugin to the exact commit in lazy-lock.json
```

`:Lazy restore` matters here — a plain fresh install without it may grab the
latest commit on each plugin's branch instead of the pinned one, especially
for plugins without a `version` constraint.
