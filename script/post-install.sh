#!/bin/bash

# proxy setting
#proxy=http://iproxy-jpn.snapon.com:8080


## apt-get proxy setting
if [ ! -z ${proxy+x} ]; then
  sudo echo -e "\n\nAcquire::http::Proxy \"$proxy/\";\
    \nAcquire::https::Proxy \"$proxy/\";\
    \nAcquire::ftp::Proxy \"$proxy/\";">>/etc/apt/apt.conf
fi

# TODO: source list configuration

sudo apt-get install


## wget proxy
if [ ! -z ${proxy+x} ]; then
  sudo echo -e "\n\nhttp_proxy=$proxy/\
    \nhttps_proxy=$proxy/\
    \nftp_proxy=$proxy/">>/etc/wgetrc
  
  ## TODO: uncomment 'use_proxy = on'

fi

# Install and configure curl and git
sudo apt install curl git -y

## git proxy
if [ ! -z ${proxy+x} ]; then
  git config --global http.proxy $proxy
  git config --global https.proxy $proxy
  echo proxy=$proxy>>~/.curlrc
fi

# TODO: Install and configure oh-my-zsh
sudo apt-get install zsh -y
chsh -s $(which zsh)
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

if [ ! -z ${proxy+x} ]; then
echo -e "\n\nexport http_proxy $proxy\
  \nexport https_proxy $proxy\
  \nexport ftp_proxy $proxy">>~/.zshrc
fi

# Install repo
mkdir ~/bin
PATH=~/bin:$PATH
## From google
#curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
## From tsinghua
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o repo > ~/bin/repo

chmod a+x ~/bin/repo
echo export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'>>~/.zshrc

# Install docker via script
curl -fsSL https://get.daocloud.io/docker | sh
#wget -qO- https://get.daocloud.io/docker | sh
#curl -fsSL https://get.docker.com/ | sh
#wget -qO- https://get.docker.com/ | sh


# Install and configure spf13-vim, custom plugin install
curl https://raw.githubusercontent.com/mkitby/stuff/master/script/vim.sh -fsSL -o - | sh
curl https://raw.githubusercontent.com/mkitby/stuff/master/script/spf13-vim.sh -fsSL -o - | sh
#wget -qO- https://raw.githubusercontent.com/mkitby/stuff/master/script/spf13-vim.sh | sh

