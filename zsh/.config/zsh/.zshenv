export PATH=$HOME/.local/bin/:$PATH
# export ZDOTDIR=$HOME/.config/zsh
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-kitty
export EDITOR=/usr/bin/nvim.appimage
export PATH="$HOME/scripts/:$PATH"
source "$ZDOTDIR/zsh-functions"
source $HOME/.aliases

# Software to path
export PATH="$HOME/go/bin/:$PATH"
export PATH="$HOME/Software/pico-8:$PATH"
export PATH="$HOME/Software/reaper/REAPER:$PATH"
export PATH="$HOME/Software/BlenderLauncher:$PATH"
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
 
export PATH="$HOME/.config/lsp/lua-language-server/bin/:$PATH"
export PATH="$HOME/.config/lsp/zls/zig-out/bin:$PATH"
export PATH="$HOME/.config/lsp/ols/:$PATH"
export PATH="$HOME/.config/emacs/bin/:$PATH"
export DENO_INSTALL="/home/edibotopic/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Opam configuration
[[ ! -r /home/edibotopic/.opam/opam-init/init.zsh ]] || source /home/edibotopic/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
