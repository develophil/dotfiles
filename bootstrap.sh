#!/bin/sh

#-------------------------------------------------------------------------------
# 참고 : https://github.com/appkr/dotfiles/blob/master/bootstrap.sh
#-------------------------------------------------------------------------------

DOTFILES = $HOME/Dropbox/dotfiles

#-------------------------------------------------------------------------------
echo "Install Command Line Tool"
#-------------------------------------------------------------------------------
sudo xcodebuild -license # 콘솔에서 라이선스 동의하기
xcode-select --install   # Command Line Tool 설치

#-------------------------------------------------------------------------------
echo "Check for Homebrew and install if we don't have it"
#-------------------------------------------------------------------------------
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#-------------------------------------------------------------------------------
echo "Update Homebrew recipes"
#-------------------------------------------------------------------------------
brew update

#-------------------------------------------------------------------------------
echo "Install all our dependencies with bundle (See Brewfile)"
#-------------------------------------------------------------------------------
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

#-------------------------------------------------------------------------------
echo "Execute installers downloaded with Homebrew Cask"
#-------------------------------------------------------------------------------
echo "Opening Installer: Adobe Creative Cloud"
open /usr/local/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app/

#-------------------------------------------------------------------------------
echo "cleanup brew to keep disk space"
#-------------------------------------------------------------------------------
brew cleanup
brew cask cleanup

#-------------------------------------------------------------------------------
echo "Make ZSH the default shell environment"
#-------------------------------------------------------------------------------
chsh -s $(which zsh)

#-------------------------------------------------------------------------------
echo "Install Oh-my-zsh"
#-------------------------------------------------------------------------------
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerline theme
# Neet to set font in iterm2 preferences
# wget https://raw.githubusercontent.com/jeremyFreeAgent/oh-my-zsh-powerline-theme/master/powerline.zsh-theme -O $HOME/.oh-my-zsh/themes/powerline.zsh-theme
# git clone git@github.com:powerline/fonts.git && bash fonts/install.sh
# sleep 3
# rm -rf fonts
# git clone https://github.com/jhipster/jhipster-oh-my-zsh-plugin.git $HOME/.oh-my-zsh/custom/plugins/jhipster

#-------------------------------------------------------------------------------
echo "Restore config file to the home directory with mackup"
#-------------------------------------------------------------------------------
mackup restore

#-------------------------------------------------------------------------------
echo "Vim setting"
#-------------------------------------------------------------------------------
# ln -nfs $DOTFILES/.vimrc $HOME/.vimrc
vim +PluginInstall +qall
# mkdir $HOME/.vim/colors
# wget https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim -O $HOME/.vim/colors/atom-dark-256.vim

#-------------------------------------------------------------------------------
echo "Source profile"
#-------------------------------------------------------------------------------
source $HOME/.zshrc

#-------------------------------------------------------------------------------
# Enable jenv and rbenv
#-------------------------------------------------------------------------------
jenv add $(javahome 1.8)
jenv add $(javahome 11)

#-------------------------------------------------------------------------------
echo "Set OS X preferences"
#-------------------------------------------------------------------------------
source $DOTFILES/.osx
