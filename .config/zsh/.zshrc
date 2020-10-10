# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long
zstyle ':completion:*' prompt '2'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/arnaldur/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install

zle -N history-substring-search-up
zle -N history-substring-search-down

bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

autoload -U promptinit; promptinit
#prompt adam
#prompt spaceship

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# spaceship configuration
export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_PROMPT_SEPARATE_LINE=false
export SPACESHIP_DIR_TRUNC=3
export SPACESHIP_DIR_TRUNC_REPO=false
export SPACESHIP_DIR_TRUNC_PREFIX="…/"

export SPACESHIP_GIT_SHOW=true
export SPACESHIP_GIT_PREFIX="깉"
#export SPACESHIP_GIT_PREFIX="on "
export SPACESHIP_GIT_BRANCH_SHOW=true
export SPACESHIP_GIT_STATUS_SHOW=true
export SPACESHIP_GIT_BRANCH_MASTER_SUBSTITUTE="𝌎" #"ᛘ"

export SPACESHIP_EXEC_TIME_PREFIX="⏱ "

# aliases
alias l="ls -a --color=auto"
alias ll="ls -l --color=auto"
alias la="ls -la --color=auto"
alias ls="ls --color=auto"
alias em="emacs -nw"
alias wem="emacs"
alias guimacs="emacs"

alias reload="source ~/.config/zsh/.zshrc"

# pacman utils
alias pacin="sudo pacaur -S"
alias pacfind="pacman -Ss"
alias pacafind="yay -Ss"
alias pacupdate="sudo pacman -Syu"
alias pacaupdate="yay -Syu"

pacsizes() { 
  LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h 
}
pacremoveorphans() { sudo pacman -Rns $(pacman -Qtdq) }

alias hs="ghc -dynamic"

alias primusrun="vblank_mode=0 primusrun"

alias steamrun="vblank_mode=0 LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1' optirun -b primus steam"

alias reloadwifi="systemctl restart netctl-auto@wlp3s0.service"
alias wifi="sudo wifi-menu"

alias open="xdg-open"

alias firefox="firefox-developer-edition"

resetrepeatrate() { xset r rate 256 32 }
setplanckkeymap() {
    setxkbmap -layout is -device $(xinput -list | grep -i 'ZSA Planck EZ Keyboard' | awk '{print substr($5, 4)}')
}
setpreonickeymap() {
    setxkbmap -layout is -device $(xinput -list | grep -i 'OLKB Preonic Keyboard' | awk '{print substr($5, 4)}')
}
planck() {setplanckkeymap && resetrepeatrate}
preonic() {setplanckkeymap && resetrepeatrate}

disabletrackpad() { xinput disable $(xinput list | grep -i 'Elan Touchpad' | awk '{print substr($5, 4)}') }
enabletrackpad() { xinput enable $(xinput list | grep -i 'Elan Touchpad' | awk '{print substr($5, 4)}') }
disablekeyboard () {
    xinput disable $(xinput list | grep -i 'AT Translated Set 2 keyboard' | awk '{print substr($7, 4)}')
    xinput disable $(xinput list | grep -i 'Asus WMI hotkeys' | awk '{print substr($5, 4)}')
    xinput disable $(xinput list | grep -i 'Power Button' | awk '{print substr($4, 4)}')
}
enablekeyboard () {
    xinput enable $(xinput list | grep -i 'AT Translated Set 2 keyboard' | awk '{print substr($7, 4)}')
    xinput enable $(xinput list | grep -i 'Asus WMI hotkeys' | awk '{print substr($5, 4)}')
    xinput enable $(xinput list | grep -i 'Power Button' | awk '{print substr($4, 4)}')
}
portablemode() {
    enabletrackpad
    enablekeyboard
}
dockedmode() {
    setplanckkeymap
    resetrepeatrate
    disabletrackpad
    disablekeyboard
}

#setxkbmap -layout is -option grp:win_space_toggle -option compose:menu
setxkbmap -layout is -option compose:menu

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

eval "$(starship init zsh)"
