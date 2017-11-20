#!/bin/sh

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
git clone https://github.com/dracula/zsh.git $HOME/.dracula-theme/zsh
git clone https://github.com/dracula/iterm.git $HOME/.dracula-theme/iterm
git clone https://github.com/dracula/jetbrains.git $HOME/.dracula-theme/jetbrains

mkdir $HOME/.emacs.d
ln -s $HOME/dotfiles/.emacs.d/init.el $HOME/.emacs.d/init.el
