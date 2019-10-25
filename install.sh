#!/usr/bin/env bash
#
# From: https://gist.github.com/codeinthehole/26b37efa67041e1307db
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install gnu-sed
brew install gnu-tar
brew install gnu-indent
brew install gnu-which

if ! grep "/gnubin:" ~/.bashrc > /dev/null; then
  echo "# Installed by https://github.com/coryvirok/dotfiles/blob/master/install.sh" >> ~/.bashrc
  echo PATH="/usr/local/opt/coreutils/libexec/gnubin:\$PATH" >> ~/.bashrc
fi

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    ansible
    autoconf
    automake
    git
    jq
    mysql
    npm
    pkg-config
    python
    python3
    rename
    ssh-copy-id
    the_silver_searcher
    tmux
    tree
    vim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}
brew postinstall python3

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew tap caskroom/cask
brew tap homebrew/cask-versions

CASKS=(
    1password
    docker
    dropbox
    google-chrome-beta
    iterm2
    macvim
    pycharm
    slack
    spectacle
    vlc
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
)
sudo gem install ${RUBY_GEMS[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Configuring OSX..."

# Disable press and hold
defaults write -g ApplePressAndHoldEnabled -bool false

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password 5 seconds after screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Creating folder structure..."
[[ ! -d Developer ]] && mkdir Developer

echo "Installing tmux config..."
[ -f ~/.tmux.conf ] && rsync -ahb ~/.tmux.conf ~/.tmux.conf.bak
ln -svf $PWD/.tmux.conf ~/.tmux.conf

echo "Installing bash configs..."
touch ~/.bash_profile ~/.bashrc

ADD_BASH_ALIASES='[ -f ~/.bash_aliases ] && . ~/.bash_aliases'
if [ -f ~/.bash_aliases ]; then
  rsync -ahb ~/.bash_aliases ~/.bash_aliases.bak
fi
ln -svf $PWD/.bash_aliases ~/.bash_aliases
grep -q "$ADD_BASH_ALIASES" ~/.bashrc || (echo "$ADD_BASH_ALIASES" >> ~/.bashrc)

ADD_BASH_RC='[ -f ~/.bashrc ] && . ~/.bashrc'
grep -q "$ADD_BASH_RC" ~/.bash_profile || (echo "$ADD_BASH_RC" >> ~/.bash_profile)

git submodule update --init
cp ./ssh-find-agent/ssh-find-agent.sh ~/.ssh-find-agent.sh

FIND_AGENT_CMD='. ./.ssh-find-agent.sh'
if ! grep "$FIND_AGENT_CMD" ~/.bashrc > /dev/null; then
  ONE_AGENT_TO_RULE_THEM_ALL=$(cat <<-END

# Added by https://github.com/coryvirok/dotfiles/blob/master/install.sh
# Looks for a running ssh-agent to add SSH keys to or starts up a new
# one.
. ~/.ssh-find-agent.sh
set_ssh_agent_socket
if ! ssh-add -l > /dev/null; then
  echo 'Adding your SSH keys to SSH agent for the first and last time'
  ssh-add
fi
END)

  echo "$ONE_AGENT_TO_RULE_THEM_ALL" >> ~/.bashrc
fi


echo "Bootstrapping complete"
