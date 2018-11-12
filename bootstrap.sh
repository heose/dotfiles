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

# zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "Exist $HOME/.oh-my-zsh"
fi

echo "Finish"
