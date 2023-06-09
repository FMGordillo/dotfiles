#!/bin/bash

text="${txtgrn}[Core]${txtblk}"

echo -e "${text} Updating packages"

sudo apt update
sudo apt upgrade -y

text="${txtgrn}[Additional libraries]${txtblk}"

echo -e "${text} Installing kitty (terminal)"
sudo apt install kitty -y

echo -e "${text} Installing tmux"
sudo apt install tmux -y

echo -e "${text} Installing snap"
sudo apt install snapd -y
sudo snap install core

echo -e "${text} Installing bat"
sudo apt install bat -y

echo -e "${text} Installing flameshot"
sudo apt install flameshot -y

echo -e "${text} Installing ripgrep"
sudo apt install ripgrep


text="${txtgrn}[i3]${txtblk}"

echo -e "${text} Installing rufi"
sudo apt install -y i3

echo -e "${text} Installing rufi (i3 search bar)"
sudo apt install -y rufi

echo -e "${text} Installing rtx"
curl https://rtx.pub/install.sh | sh

echo -e "${text} Installing necessary packages for Python install"
sudo apt install zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev libedit-dev

text="${txtgrn}[Shell]${txtblk}"

echo -e "${text} Installing zsh"
sudo apt install zsh

echo -e "${text} Moving plugins to .bak folder (for now)"
mv ~/.oh-my-zsh/custom ~/ohmyzshcustom.bak

echo -e "${text} Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "${text} Moving back plugins to oh-my-zsh"
rm -rf ~/.oh-my-zsh/custom
mv ~/ohmyzshcustom.bak ~/.oh-my-zsh

text="${txtgrn}[GPG]${txtblk}"

echo -e "${text} Downloading Keybase"
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb -O /tmp/keybase_amd64.deb 

echo -e "${text} Installing Keybase"
sudo apt install /tmp/keybase_amd64.deb

echo -e "${text} Running Keybase"
run_keybase

echo -e "${text} Logging in..."
keybase login fmgordillo

echo -e "${text} Configuring Keybase"
keybase pgp export -q 7CFA49CEF8267772 | gpg --import

export GPG_TTY=$(tty)

keybase pgp export -q 7CFA49CEF8267772 --secret | gpg --import --allow-secret-key-import --import
