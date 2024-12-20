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

export PATH=$PATH:/usr/local/go/bin

if [ -n "$WSL_DISTRO_NAME" ]; then
    TERM=default
else
    TERM=wezterm
fi

export TERM

# TODO: clean this up
export PATH=$HOME/.local/bin/:$PATH
export PATH="$HOME/scripts/:$PATH"
export PATH="$HOME/.go/bin/:$PATH"
export GOPATH=$HOME/.go
export PATH="$HOME/opt/BlenderLauncher:$PATH"
export PATH="$HOME/opt/Odin:$PATH"
export PATH="$HOME/opt/zig:$PATH"
export PATH="$HOME/opt/idea-IC-231.9011.34/bin:$PATH"
export PATH="$HOME/opt/openjdk-21.0.2_linux-x64_bin/jdk-21.0.2/bin:$PATH"
export PATH="$HOME/opt/flutter:$PATH"
export PATH="$HOME/.local/bin/zed:$PATH"
export PATH="$HOME/opt/ols/:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"

# Load custom Ranger config
export RANGER_LOAD_DEFAULT_RC=false

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. "$HOME/.cargo/env"

[ -f "/home/edibotopic/.ghcup/env" ] && . "/home/edibotopic/.ghcup/env" # ghcup-env
