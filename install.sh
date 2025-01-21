#!/bin/bash
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brew bundle install --file=${BASEDIR}/Brewfile

pyenv install 3.13
pyenv global 3.13

ln -sfv ${BASEDIR}/inputrc ~/.inputrc

# vim
ln -sfv ${BASEDIR}/vimrc ~/.ideavimrc

# nvim
ln -sfv ${BASEDIR}/init.lua ~/.config/nvim/init.lua

# git
ln -sfv ${BASEDIR}/gitconfig ~/.gitconfig
ln -sfv ${BASEDIR}/gitignore ~/.gitignore

# ghostty
ln -sfv ${BASEDIR}/ghostty/config ~/.config/ghostty/config

# fish
ln -sfv ${BASEDIR}/fish/config.fish ~/.config/fish/config.fish
ln -sfv ${BASEDIR}/fish/functions/* ~/.config/fish/functions

