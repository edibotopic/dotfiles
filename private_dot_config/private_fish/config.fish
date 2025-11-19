if status is-interactive
    # Commands to run in interactive sessions can go here
end

# text editing
set -x EDITOR hx
set -x VISUAL hx
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
set -x PATH $PATH $LOCALBIN $GOBIN

# starship
# starship init fish | source

# node via n
set -x N_PREFIX $HOME/n
if not contains $N_PREFIX/bin $PATH
    set -x PATH $PATH $N_PREFIX/bin
end
