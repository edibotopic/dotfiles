if status is-interactive
    # Commands to run in interactive sessions can go here
end

# text editing
set -x EDITOR /usr/local/bin/nvim
set -x VISUAL /usr/local/bin/nvim
fish_vi_key_bindings
# don't show vim mode indicators
function fish_mode_prompt
end

# env vars
if test -f "$HOME/.odin"
    source "$HOME/.odin"
end

# go
set -x GOPATH $HOME/.go
set -x GOBIN $GOPATH/bin
set -x LOCALBIN $HOME/.local/bin

# dict
set -x STARDICT_DATA_DIR $HOME/opt/dict

# emacs
set -x EMACSPATH $HOME/.config/emacs/bin

# path
set -x CARGOBIN $HOME/.cargo/bin
set -x DRENVBIN $HOME/.drenv/bin
set -x PATH $PATH $LOCALBIN $GOBIN $EMACSPATH $STARDICT_DATA_DIR $CARGOBIN $DRENVBIN

# starship
# starship init fish | source

# ruby (user-installed gem executables, e.g. rubocop)
if command -q ruby
    set -x PATH $PATH (ruby -e 'print Gem.user_dir')/bin
end

# node via n
set -x N_PREFIX $HOME/n
if not contains $N_PREFIX/bin $PATH
    set -x PATH $PATH $N_PREFIX/bin
end

# opencode
fish_add_path /home/shane/.opencode/bin

# direnv
direnv hook fish | source


# pnpm
set -gx PNPM_HOME "/home/shane/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
