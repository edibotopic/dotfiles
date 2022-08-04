export PATH=$HOME/edibotopic/.local/bin/:$PATH
export ZDOTDIR=$HOME/.config/zsh
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-kitty
export EDITOR=$HOME/edibotopic/.local/kitty.app/bin

source "$ZDOTDIR/zsh-functions"

zsh_add_file "zsh-prompt"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git z vi-mode)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Manually set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export PATH="$HOME/scripts/:$PATH"

# Software to path
export PATH="$HOME/Software/pico-8:$PATH"
export PATH="$HOME/Software/reaper/REAPER:$PATH"
export PATH="$HOME/Software/blender/:$PATH"
export PATH="$HOME/Software/Graph-Easy-0.76/bin/:$PATH"
export PATH="$HOME/Software/tweego-2.1.1-linux-x64/:$PATH"
export PATH="$HOME/.local/kitty.app/bin/:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# Load custom Ranger config
export RANGER_LOAD_DEFAULT_RC=false

# Append image on opening terminal 
# colorscript -e elfman

# Remap CAPS just-in-case
/usr/bin/setxkbmap -option "caps:escape"

# Print a trippy looping gif
# kitty +kitten icat --align left ~/Dropbox/Notes_vault/Loops/double150.gif
