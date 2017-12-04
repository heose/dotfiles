#!/bin/sh

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap homebrew/bundle
brew bundle --file=$HOME/dotfiles/Brewfile
brew cleanup
brew cask cleanup

yarn global add tern

# git global config setting
git config --global user.name heose
git config --global user.email goddnrl@gmail.com

# Download dracula theme
if [ ! -d "$HOME/.dracula-theme" ]; then
  mkdir $HOME/.dracula-theme 
  git clone https://github.com/dracula/zsh.git $HOME/.dracula-theme/zsh
  git clone https://github.com/dracula/iterm.git $HOME/.dracula-theme/iterm
  git clone https://github.com/dracula/jetbrains.git $HOME/.dracula-theme/jetbrains
else
  echo "Exist $HOME/.dracula-theme"
fi

#zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ln -s $HOME/.dracula-theme/zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme
  [ ! -f $HOME/.zshrc ] && ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
  source $HOME/.zshrc
else
  echo "Exist $HOME/.oh-my-zsh"
fi

#emacs
if [ ! -d "$HOME/.emacs.d" ]; then
  mkdir $HOME/.emacs.d
  ln -s $HOME/dotfiles/.emacs.d/init.el $HOME/.emacs.d/init.el
else
  echo "Exist $HOME/.emacs.d"
fi

echo "Finish"
