if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  direnv
	asdf
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias update="sudo apt update && sudo apt autoremove && sudo apt upgrade"
alias helix="~/.local/share/helix/helix"
alias ls="exa --icons"
alias df="duf"
alias cat="batcat"
alias less="most"
alias tree="tre"

# FIXME: Not working!!
alias start_hear_my_mic="pactl unload-module module-loopback"
alias stop_hear_my_mic="pactl unload-module module-loopback"

# Playground aliases
alias playground_postgres="docker run --rm --name postgres-playground -e POSTGRES_DB=admin -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -d postgres && docker exec -it postgres-playground psql -U admin -W admin"

export FLYCTL_INSTALL="/home/fmgordillo/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

alias vim="sh ~/bin/squashfs-root/AppRun"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


eval "$(/home/laspark/.local/share/rtx/bin/rtx activate -s zsh)"
