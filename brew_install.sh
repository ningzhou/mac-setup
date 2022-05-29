#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew if we don't have it
if test ! $(which brew); then
  echo "------------------------------"
  echo "Installing homebrew..."
  echo "------------------------------"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/ningzho/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"


# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade 

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH` if we want to use the gnu utils as default options.
echo "------------------------------"
echo "Installing gnu coreuitls, moreutils, findutils, gnu-sed..."
echo "------------------------------"
# Insall coreuitls
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed


echo "------------------------------"
echo "Installing wget"
echo "------------------------------"
# Install `wget` with IRI support.
# Options has been removed for homebrew core formulaes
# brew install wget  --with-iri 
brew install wget 

# Install zsh and set it as the default  
echo "------------------------------"
echo "Installing Zsh and change it to default shell"
echo "------------------------------"
brew install zsh
# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;


echo "------------------------------"
echo "Installing must-have apps via brew cask"
echo "------------------------------"

# Core casks
brew install --cask --appdir="/Applications" alfred
brew install --cask --appdir="/Applications" iterm2
brew install --cask --appdir="/Applications" scroll-reverser
brew install --cask --appdir="/Applications" emacs
brew install --cask --appdir="~/Applications" xquartz
brew install --cask --appdir="~/Applications" karabiner-elements

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-dejavu

# Remove outdated versions from the cellar.
brew cleanup
