#!/bin/zsh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brew bundle install --file=${BASEDIR}/Brewfile

pyenv install 3.13
pyenv global 3.13

# Linking dotfiles.
ln -sfv ${BASEDIR}/inputrc ~/.inputrc

# vim
ln -sfv ${BASEDIR}/vimrc ~/.vimrc
ln -sfv ${BASEDIR}/vimrc ~/.ideavimrc

# git
ln -sfv ${BASEDIR}/gitconfig ~/.gitconfig
ln -sfv ${BASEDIR}/gitignore ~/.gitignore

