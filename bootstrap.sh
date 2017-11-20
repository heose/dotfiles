#!/usr/bin/env bash

if test ! $(which brew); then
    /usr/bin/ruby -e "$(curl -fsSLhttps://raw.githubusercontent.com/Homebrew/install/master/install)”
fi

brew update
brew tap homebrew/bundle
brew bundle --file=$HOME/dotfiles/Brewfile
brew cleanup
brew cask cleanup

# git global config setting
git config --global user.name heose
git config --global user.email goddnrl@gmail.com

# Download dracula theme
mkdir $HOME/.dracula-theme 
cd $HOME/.dracula-theme
git clone git clone https://github.com/dracula/zsh.git
git clone https://github.com/dracula/iterm.git
git clone https://github.com/dracula/jetbrains.git

ln -s $HOME/dotfiles/.emacs.d/init.el $HOME/.emacs.d/init.el
