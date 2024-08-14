# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=$PATH:/usr/local/go/bin

if [ -n "$WSL_DISTRO_NAME" ]; then
    TERM=default
else
    TERM=xterm-kitty
fi

export TERM

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export PATH=$HOME/.local/bin/:$PATH
export PATH="$HOME/scripts/:$PATH"
export PATH="$HOME/.go/bin/:$PATH"
export GOPATH=$HOME/.go
export PATH="$HOME/software/BlenderLauncher:$PATH"
export PATH="$HOME/software/Odin:$PATH"
export PATH="$HOME/software/zig:$PATH"
export PATH="$HOME/software/idea-IC-231.9011.34/bin:$PATH"
export PATH="$HOME/software/openjdk-21.0.2_linux-x64_bin/jdk-21.0.2/bin:$PATH"
export PATH="$HOME/software/flutter:$PATH"
export PATH="$HOME/.local/bin/zed:$PATH"

# Load custom Ranger config
export RANGER_LOAD_DEFAULT_RC=false

export PATH="$HOME/opt/ols/:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"

# Opam configuration
# [[ ! -r /home/edibotopic/.opam/opam-init/init.zsh ]] || source /home/edibotopic/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. "$HOME/.cargo/env"
