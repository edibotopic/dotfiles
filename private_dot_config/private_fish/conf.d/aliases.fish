# Basics
alias cls="clear"
# alias cl="journalctl --vacuum-time=10d"
# alias cat="batcat"

function d
    sdcv "$1" | less
end

alias fd="fdfind"

# Git
alias lg="lazygit"
function gr
    cd (git rev-parse --show-toplevel)
end

# Files
alias yz="yazi"

# Editing
function hf
    hx (fzf)
end

alias nv="/usr/local/bin/nvim"

function nf
    nv (fzf)
end

# Utils
alias ls="eza --icons"

# Dev
alias z="zellij"
alias zj="zellij"
alias zw="zellij --layout welcome"
alias nrepl="bb nrepl-server 41123"

# Python
alias py="python3"
alias python="python3"
alias envmk="py -m venv env"
alias envac="source ./env/bin/activate.fish"
alias deac="deactivate"

# Notes
alias work="$EDITOR $HOME/Dropbox/vaults/work/"
alias write="$EDITOR $HOME/Dropbox/vaults/write/"

# Journal
alias daily="$EDITOR $HOME/Dropbox/vaults/write/habits/journal/$(date +%Y-%m-%d).md"

# Terminal
alias opaque='gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$PTYXIS_PROFILE/ opacity 1'
alias nopaque='gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$PTYXIS_PROFILE/ opacity .94'

# Apps
alias zen="$HOME/opt/zen.linux-x86_64/zen/zen"
