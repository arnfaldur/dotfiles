xontrib load argcomplete kitty prompt_starship vox autovox
#xontrib load z
xontrib load coreutils
#xontrib load readable-traceback
xontrib load zoxide
xontrib load fzf-widgets

# source-zsh .config/zsh/.zshrc
# source-zsh "echo loading xonsh foreign shell"

#$VI_MODE = True
$XONSH_SHOW_TRACEBACK = False

from math import sqrt, log

$XONSH_DEBUG = 0
#
source ~/.config/xonsh/env.xsh

# workaround https://github.com/xonsh/xonsh/issues/4409
__import__('warnings').filterwarnings('ignore', 'There is no current event loop', DeprecationWarning, 'prompt_toolkit.eventloop.utils')

# aliases
aliases['l'] = "ls -a --color=auto"
aliases['ll'] = "ls -lh --color=auto"
aliases['la'] = "ls -lah --color=auto"
aliases['ls'] = "ls --color=auto"

aliases['el'] = "exa --long"
aliases['ea'] = "exa --long --all"
for i in range(9):
    aliases[f'et{i}'] = f"exa --long --tree --level={i}"
    aliases[f'ea{i}'] = f"exa --long --all --tree --level={i}"


#aliases['reload'] = "source ~/.config/zsh/.zshrc"

aliases['orgsave'] = "git commit -am @$(date -Iseconds)"

aliases['pa'] = "@($args) --color=always | bat -p"

aliases['paparu'] = "paru @($args) --color=always | bat -p"

# pacman utils

aliases['hs'] = "ghc -dynamic"
aliases['primusrun'] = "vblank_mode=0 primusrun"
aliases['steamrun'] = "vblank_mode=0 LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1' optirun -b primus steam"
aliases['reloadwifi'] = "systemctl restart netctl-auto@wlp3s0.service"
aliases['wifi'] = "sudo wifi-menu"
aliases['open'] = "xdg-open"
aliases['firefox'] = "firefox-developer-edition"
aliases['dragon'] = "dragon-drop"
aliases['vim'] = "nvim"
aliases['yarn'] = 'yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
aliases['copy'] = 'xclip -selection clipboard'
aliases['pulserestart'] = 'pulseaudio --kill && sleep 1 && pulseaudio --start'

# misc

$TEXMFDIST = p"/usr/share/texmf-dist"
$TEXMFHOME = p"$XDG_DATA_HOME/texmf"
aliases['tlmgr'] = '/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

aliases['ssh'] = 'kitty +kitten ssh'

aliases['gs'] = 'git status -sb'
aliases['gc'] = 'git commit'
aliases['gps'] = 'git push'
aliases['gpl'] = 'git pull'
aliases['gf'] = 'git fetch'

$RANGER_LASTDIR = p"$XDG_STATE_HOME/ranger/lastdir"
#aliases['ranger'] = '/usr/bin/ranger --choosedir=$RANGER_LASTDIR && cd $(cat $RANGER_LASTDIR)'


aliases['em'] = "emacsclient -t"
aliases['wem'] = "emacsclient -c"
aliases['guimacs'] = "emacsclient -c"

aliases['resource'] = "source ~/.config/xonsh/rc.xsh"

aliases['chs'] = "cht.sh"

aliases['units'] = 'units --history "$XDG_CACHE_HOME/units_history"'
aliases['unts'] = 'units -t'

from xonsh.tools import uncapturable, unthreadable
@uncapturable
@unthreadable
def _dif(args):
    return ($(diff -u @(args) | diff-so-fancy), None)
#aliases['dif'] = "diff -u @($args) | diff-so-fancy"
aliases['dif'] = _dif

def starti3():
    startx $XINITRC /usr/bin/i3

def pacsizes():
    with ${...}.swap(LC_ALL='C'):
        pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h

def pacremoveorphans():
    sudo pacman -Rns @$(pacman -Qtdq)

def setmousespeed(speed):
    mouse_name = "Logitech G700s Rechargeable Gaming Mouse"
    xinput --set-prop @(mouse_name) 'Coordinate Transformation Matrix' @(speed) 0 0 0 @(speed) 0 0 0 1
def resetrepeatrate():
    xset r rate 256 32
def setkeymap():
    setxkbmap -layout is
def setplanckkeymap():
    setxkbmap -layout is -device $(xinput -list | grep -i 'ZSA Planck EZ Keyboard' | awk '{print substr($5, 4)}')

def setpreonickeymap():
    setxkbmap -layout is -device $(xinput -list | grep -i 'OLKB Preonic Keyboard' | awk '{print substr($5, 4)}')

def planck():
    setplanckkeymap(); resetrepeatrate()
def preonic():
    setplanckkeymap(); resetrepeatrate()

def _disable_device_by_name(name):
    xinput disable @($(xinput list | grep -i @(name) | awk '{print substr($0, match($0, "id=") + 3, 2)}').strip())
def _enable_device_by_name(name):
    xinput enable @($(xinput list | grep -i @(name) | awk '{print substr($0, match($0, "id=") + 3, 2)}').strip())

def disabletrackpad():
    _disable_device_by_name("Elan Touchpad")
def enabletrackpad():
    _enable_device_by_name("Elan Touchpad")

def disablekeyboard():
    _disable_device_by_name('AT Translated Set 2 keyboard')
    _disable_device_by_name('Asus WMI hotkeys')
    _disable_device_by_name('Power Button')
def enablekeyboard():
    _enable_device_by_name('AT Translated Set 2 keyboard')
    _enable_device_by_name('Asus WMI hotkeys')
    _enable_device_by_name('Power Button')

def portablemode():
    enabletrackpad()
    enablekeyboard()

def dockedmode():
    setplanckkeymap()
    resetrepeatrate()
    disabletrackpad()
    disablekeyboard()


resetrepeatrate()
setkeymap()

def inline_latex(args, stdin=None):
    latex = args[0] if stdin is None else stdin
    prev_dir = $(pwd).strip()
    tmp_dir = $(mktemp -d).strip()
    cd @(tmp_dir)
    with open('latex.tex', 'w') as file:
        file.write(
            "\\documentclass[varwidth=true,border=2pt]{standalone} \\usepackage{amsmath,amsthm,amssymb,amsfonts} \\begin{document} $$"
            + latex
            + "$$ \\end{document}"
        )
    texfot --quiet pdflatex -shell-escape latex.tex > /dev/null
#pdftoppm latex.pdf | pnmtopng > latex.png
    convert -density 600 -colorspace Gray latex.pdf -quality 90 -alpha off -negate -resize 50% latex.png
    icat latex.png
    cd @(prev_dir)
#rm -r @(tmp_dir)
    return

def entomb_workspaces():
    for i in range(1,11):
        i3-resurrect save -d ~/.local/share/i3/resurrect -n -w @(i)

def resurrect_workspaces():
    for i in range(1,11):
        i3-resurrect restore -d ~/.local/share/i3/resurrect -n -w @(i)

aliases['intex'] = inline_latex

def setup_keychain():
    keychain -q --absolute --dir "$XDG_RUNTIME_DIR/keychain" --eval id_ed25519 > /tmp/keychain.sh
    source-bash /tmp/keychain.sh

if p'/tmp/keychain.sh'.exists():
    source-bash /tmp/keychain.sh

@events.autovox_policy
def venv_policy(path, **_):
    venv = path / "venv"
    if venv.exists():
        return venv

$LS_COLORS.update({
    'bd': ('BACKGROUND_BLACK', 'BOLD_YELLOW'),
    'ca': ('BLACK', 'BACKGROUND_RED'),
    'cd': ('BACKGROUND_BLACK', 'BOLD_YELLOW'),
    'di': ('BOLD_BLUE',),
    'do': ('BOLD_PURPLE',),
    'ex': ('BOLD_GREEN',),
    'ln': ('BOLD_CYAN',),
    'mh': ('RESET',),
    'mi': ('RESET',),
    'or': ('BACKGROUND_BLACK', 'BOLD_RED'),
    'ow': ('BOLD_PURPLE',),
    'pi': ('BACKGROUND_BLACK', 'YELLOW'),
    'rs': ('RESET',),
    'sg': ('BLACK', 'BACKGROUND_YELLOW'),
    'so': ('BOLD_PURPLE',),
    'st': ('WHITE', 'BACKGROUND_BLUE'),
    'su': ('WHITE', 'BACKGROUND_RED'),
    'tw': ('BLACK', 'BACKGROUND_GREEN')
})

import builtins
import xonsh
builtins.__xonsh__.commands_cache.threadable_predictors.update({
    'git': xonsh.commands_cache.predict_false,
    'bat': xonsh.commands_cache.predict_false,
    'paru': xonsh.commands_cache.predict_false,
    'journalctl': xonsh.commands_cache.predict_false,
    'systemctl': xonsh.commands_cache.predict_false,
})
