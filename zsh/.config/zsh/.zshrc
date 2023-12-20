# Theming
zsh_add_file "zsh-prompt"
ZSH_THEME=jbergantine

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git z vi-mode)

VI_MODE_SET_CURSOR=false

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

# Manually set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Graphical neovim
alias nvde="neovide --neovim-bin /usr/bin/nvim.appimage"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Append image on opening terminal 
# colorscript -e elfman

# Remap CAPS just-in-case
/usr/bin/setxkbmap -option "caps:escape"

# Print a trippy looping gif
# kitty +kitten icat --align left ~/Dropbox/Notes_vault/Loops/double150.gif

alias luamake=/home/edibotopic/.config/lsp/lua-language-server/3rd/luamake/luamake
