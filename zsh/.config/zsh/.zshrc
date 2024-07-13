DISABLE_AUTO_UPDATE=true

# Theming
# zsh_add_file "zsh-prompt"
# ZSH_THEME=jbergantine

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# plugins=(git vi-mode zsh-autosuggestions)

# VI_MODE_SET_CURSOR=false

# source $ZSH/oh-my-zsh.sh
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
# alias nvde="neovide --neovim-bin /usr/bin/nvim.appimage"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Remap CAPS just-in-case
/usr/bin/setxkbmap -option "caps:escape"

alias luamake=/home/edibotopic/.config/lsp/lua-language-server/3rd/luamake/luamake
