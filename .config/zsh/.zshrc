# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
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
prompt spaceship

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# aliases
alias ls="ls --color=auto"
alias em="emacs -nw"
alias wem="emacs"
alias guimacs="emacs"

alias reload="source ~/.config/zsh/.zshrc"

alias pacin="pacaur -S"
alias pacfind="pacman -Ss"
alias pacafind="pacaur -Ss"
alias pacupdate="sudo pacman -Syu"
alias pacaupdate="pacaur -Syu"

# pacman utils
alias pacsizes="LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h"


alias hs="ghc -dynamic"

alias primusrun="vblank_mode=0 primusrun"

alias steamrun="vblank_mode=0 LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1' optirun -b primus steam"

alias reloadwifi="systemctl restart netctl-auto@wlp3s0.service"

alias firefox="firefox-developer-edition"

#setxkbmap -layout is -option grp:win_space_toggle -option compose:menu
setxkbmap -layout is -option compose:menu

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
