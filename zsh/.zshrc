#
# TODO: MAYBE THIS IS NOT NEEDED ANYMORE!!!
#

#export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

#source $ZSH/oh-my-zsh.sh

#alias update="sudo apt update && sudo apt autoremove && sudo apt upgrade"
#alias helix="~/.local/share/helix/helix"
#alias ls="exa --icons"
#alias df="duf"
#alias cat="batcat"
#alias less="most"
#alias tree="tre"

# Playground aliases
alias playground_postgres="docker run --rm --name postgres-playground -e POSTGRES_DB=admin -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -d postgres && docker exec -it postgres-playground psql -U admin -W admin"

#export FLYCTL_INSTALL="/home/$USER/.fly"
#export PATH="$FLYCTL_INSTALL/bin:$PATH"
#export PATH=/home/$USER/.local/bin:$PATH
#export PATH=/snap/bin:$PATH
export PNPM_HOME="/home/fmgordillo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


#alias vim="sh ~/bin/squashfs-root/AppRun"
#alias tesseract="/home/$USER/Downloads/tesseract.AppImage"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#eval "$(/home/$USER/.local/share/rtx/bin/rtx activate -s zsh)"
#eval "$(configu autocomplete script zsh)"

# Colors
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White

# To configure dual screen play with these values
# xrandr --output DP1 --auto --left-of eDP1

# To handle screen brightness, deal with these
# xbacklight
