#!/bin/zsh

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brew bundle install --file=${BASEDIR}/Brewfile

pyenv install 3.10.5
pyenv global 3.10.5

pip install codespell

# Linking dotfiles.
ln -sfv ${BASEDIR}/inputrc ~/.inputrc

# vim
ln -sfv ${BASEDIR}/vimrc ~/.vimrc
ln -sfv ${BASEDIR}/vimrc ~/.ideavimrc

# zsh
ln -sfv ${BASEDIR}/zshrc ~/.zshrc
# ln -sfv ${BASEDIR}/zprofile ~/.zprofile

# git
ln -sfv ${BASEDIR}/gitconfig ~/.gitconfig
ln -sfv ${BASEDIR}/gitignore ~/.gitignore

