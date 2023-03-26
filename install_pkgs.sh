#!/bin/bash

text="${txtgrn}[Core]${txtblk}"

echo -e "${text} Updating packages"

sudo apt update
sudo apt upgrade -y

text="${txtgrn}[Additional libraries]${txtblk}"

echo -e "${text} Installing bat"
sudo apt install bat -y

echo -e "${text} Installing ripgrep"
sudo apt install ripgrep

echo -e "${text} Installing rtx"
curl https://rtx.pub/install.sh | sh

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
