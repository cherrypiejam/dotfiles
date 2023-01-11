#!/bin/bash

UPATH=$HOME/.myutils

# Yabai
function yabai_conf() {
    ln -s $UPATH/config/yabai/yabairc ~/.yabairc
}

# Skhd
function skhd_conf() {
    ln -s $UPATH/config/skhd/skhdrc ~/.skhdrc
}

# Neovim
function nvim_conf() {
    mkdir -p ~/.config/nvim
    ln -s $UPATH/config/nvim/init.vim ~/.config/nvim/init.vim
    # I also want it to be shared with fallback vim
    ln -s $UPATH/config/nvim/init.vim ~/.vimrc
    # Install vim-plugged, need to run `nvim +PlugInstall` manually
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

# Tmux
function tmux_conf() {
    ln -s $UPATH/config/tmux/tmux.conf ~/.tmux.conf
}

function zsh_conf() {
    ln -s $UPATH/config/zsh/zshrc ~/.zshrc
}

function kitty_conf() {
    ln -s $UPATH/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
}

# Install
function main() {
    if [ "$(uname)" == "Darwin" ]; then
        yabai_conf
        skhd_conf
        kitty_conf
    fi
    nvim_conf
    tmux_conf
    zsh_conf
}

if [ "$1" == "nvim" ]; then
    nvim_conf
else
    # Gimme all
    main
fi
