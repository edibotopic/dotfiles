export PATH=$HOME/edibotopic/.local/bin/:$PATH
export ZDOTDIR=$HOME/.config/zsh
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-kitty
# export EDITOR=$HOME/.local/kitty.app/bin
export EDITOR=/usr/bin/nvim.appimage
source "$ZDOTDIR/zsh-functions"

zsh_add_file "zsh-prompt"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git z vi-mode)

VI_MODE_SET_CURSOR=false

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
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

export PATH="$HOME/scripts/:$PATH"

# Software to path
export PATH="$HOME/go/bin/:$PATH"
export PATH="$HOME/Software/pico-8:$PATH"
export PATH="$HOME/Software/reaper/REAPER:$PATH"
export PATH="$HOME/Software/blender/:$PATH"
export PATH="$HOME/Software/Graph-Easy-0.76/bin/:$PATH"
export PATH="$HOME/Software/tweego-2.1.1-linux-x64/:$PATH"
export PATH="$HOME/Software/julia-1.8.5/bin:$PATH"
export PATH="$HOME/Software/Odin:$PATH"
export PATH="$HOME/Software/zig:$PATH"
export PATH="$HOME/Software/w4-linux/:$PATH"
export PATH="$HOME/Software/idea-IC-231.9011.34/bin:$PATH"
export PATH="$HOME/.local/kitty.app/bin/:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin/x86_64-linux":$PATH

# Load custom Ranger config
export RANGER_LOAD_DEFAULT_RC=false

# Append image on opening terminal 
# colorscript -e elfman

# Remap CAPS just-in-case
/usr/bin/setxkbmap -option "caps:escape"

# Print a trippy looping gif
# kitty +kitten icat --align left ~/Dropbox/Notes_vault/Loops/double150.gif
 
alias luamake=/home/edibotopic/.config/lsp/lua-language-server/3rd/luamake/luamake
export PATH="$HOME/.config/lsp/lua-language-server/bin/:$PATH"
export PATH="$HOME/.config/lsp/zls/zig-out/bin:$PATH"
export PATH="$HOME/.config/lsp/ols/:$PATH"
