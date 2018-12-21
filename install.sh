#! /bin/bash
touch ~/.bash_profile ~/.bashrc

brew install neovim
export XDG_CONFIG_HOME=~/.config
mkdir -p $XDG_CONFIG_HOME/nvim
curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=php&langs=html&langs=ruby&langs=python&langs=golang&langs=rust&editor=nvim' > $XDG_CONFIG_HOME/nvim/init.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

[ -f ~/.vim ] && rsync -ahb ~/.tmux.conf ~/.tmux.conf.bak
ln -svf $PWD/.tmux.conf ~/.tmux.conf

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
. ./.ssh-find-agent.sh
set_ssh_agent_socket
if ! ssh-add -l > /dev/null; then
  echo 'Adding your SSH keys to SSH agent for the first and last time'
  ssh-add
fi
END)

  echo "$ONE_AGENT_TO_RULE_THEM_ALL" >> ~/.bashrc
fi
