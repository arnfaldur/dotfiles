
# aliases
alias l = ls -a
alias la = ls -a

alias el = exa --long
alias ea = exa --long --all

# disgusting
alias et0 = exa --long --tree --level=0
alias et1 = exa --long --tree --level=1
alias et2 = exa --long --tree --level=2
alias et3 = exa --long --tree --level=3
alias et4 = exa --long --tree --level=4
alias et5 = exa --long --tree --level=5
alias et6 = exa --long --tree --level=6
alias et7 = exa --long --tree --level=7
alias et8 = exa --long --tree --level=8
alias et9 = exa --long --tree --level=9

alias ea0 = exa --long --all --tree --level=0
alias ea1 = exa --long --all --tree --level=1
alias ea2 = exa --long --all --tree --level=2
alias ea3 = exa --long --all --tree --level=3
alias ea4 = exa --long --all --tree --level=4
alias ea5 = exa --long --all --tree --level=5
alias ea6 = exa --long --all --tree --level=6
alias ea7 = exa --long --all --tree --level=7
alias ea8 = exa --long --all --tree --level=8
alias ea9 = exa --long --all --tree --level=9

def cdir --env [path] { mkdir $path; cd $path }

alias orgsave = git commit -am $"(^date -Iseconds)"

def pa [command] { ^$command --color=always | bat -p }

def paparu [...args] { paru $args --color=always | bat -p }

# pacman utils

alias hs = ghc -dynamic
alias wifi = sudo wifi-menu
alias xopen = xdg-open
alias firefox = firefox-developer-edition
alias dragon = dragon-drop
alias vim = nvim
alias yarn = yarn --use-yarnrc $"($env.XDG_CONFIG_HOME)/yarn/config"
alias copy = xclip -selection clipboard
def pulserestart [] {
    pulseaudio --kill; sleep 1sec; pulseaudio --start
}

# misc

alias ssh = kitty +kitten ssh

alias gs = git status -sb
alias gc = git commit
alias gps = git push
alias gpl = git pull
alias gf = git fetch


alias em = emacsclient -t
alias wem = emacsclient -c
alias guimacs = emacsclient -c

# alias resource = source ~/.config/xonsh/rc.xsh

alias chs = cht.sh

alias units = units --history $"($env.XDG_CACHE_HOME)/units_history"
alias unts = units -t
