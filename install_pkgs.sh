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

text="${txtgrn}[GPG]${txtblk}"

echo -e "${text} Installing Keybase"
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb -O /tmp/keybase_amd64.deb && sudo apt install /tmp/keybase_amd64.deb && run_keybase

echo -e "${text} Configuring Keybase"
keybase pgp export -q 7CFA49CEF8267772 | gpg --import

export GPG_TTY=$(tty)

keybase pgp export -q 7CFA49CEF8267772 --secret | gpg --import --allow-secret-key-import --import
