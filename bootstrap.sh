#!/bin/sh

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#brew update
#brew tap homebrew/bundle
#brew bundle --file=$HOME/dotfiles/Brewfile
#brew cleanup
#brew cask cleanup

# git global config setting
# git config --global user.name heose
# git config --global user.email goddnrl@gmail.com

# zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "Exist $HOME/.oh-my-zsh"
fi

# nvm
if [ -z ${NVM_DIR+x} ]; then
  echo "Set NVM_DIR"
  echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
  echo '. "/usr/local/opt/nvm/nvm.sh"' >> $HOME/.zshrc
else
  echo "Already set NVM_DIR"
fi

# install node
NODE_VERSION=8.11.3
echo 'node version' ${NODE_VERSION}
nvm install --lts $NODE_VERSION

echo "Finish"
