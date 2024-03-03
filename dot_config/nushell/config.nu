# Nushell Config File
#
# version = "0.90.1"

# env
source aliases.nu

# config
source themes.nu
source menus.nu
source completers.nu
source keybindings.nu

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup

    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }

    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    # datetime_format determines what a datetime rendered in the shell would look like.
    # Behavior without this configuration point will be to "humanize" the datetime display,
    # showing something like "a day ago."
    datetime_format: {
        # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
        # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }

    explore: {
        status_bar_background: {fg: "#1D1F21", bg: "#C4C9C6"},
        command_bar_text: {fg: "#C4C9C6"},
        highlight: {fg: "black", bg: "yellow"},
        status: {
            error: {fg: "white", bg: "red"},
            warn: {}
            info: {}
        },
        table: {
            split_line: {fg: "#404040"},
            selected_cell: {bg: light_blue},
            selected_row: {},
            selected_column: {},
        },
    }

    # history: {
    #     max_size: 1_000_000 # Session has to be reloaded for this to take effect
    #     sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    #     file_format: "sqlite" # "sqlite" or "plaintext"
    #     isolation: true # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    # }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 12 # setting it lower can improve completion performance at the cost of omitting some options
            completer: $external_completer
        }
    }

    filesize: {
        metric: false # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
        format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
    }

    cursor_shape: {
        emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    color_config: $dark_theme # if you want a more interesting theme, you can replace the empty record with `$dark_theme`, `$light_theme` or another custom record
    use_grid_icons: true
    footer_mode: "25" # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: emacs # emacs, vi
    shell_integration: true # enables terminal shell integration. Off by default, as some terminals have issues with this.
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: true # true enables highlighting of external commands in the repl resolved by which.

    plugins: {} # Per-plugin configuration. See https://www.nushell.sh/contributor-book/plugins.html#configuration.

    hooks: {
        pre_prompt: [{ null }] # run before the prompt is shown
        pre_execution: [{ null }] # run before the repl input is run
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: { null } # return an error message when a command is not found
    }

    menus: $menus

    keybindings: $keybindings
}

def starti3 [] {
    startx /usr/bin/i3
}

def pacsizes [] {
    LC_ALL='C' pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | ^sort -h
}

def pacremoveorphans [] {
    sudo pacman -Rns ...(pacman -Qtdq)
}

def _get_device_ids [names_or_name, device_type] {
    let names = if (($names_or_name | describe) == "string") { [$names_or_name] } else { $names_or_name }
    xinput -list
           | parse --regex $"↳ \(($names | str join '|')\)\\s*id=\(\\d*\).*\\[.* ($device_type) .*\\]"
           | get capture1
}

# def setmousespeed(speed):
#     mouse_name = "Logitech G700s Rechargeable Gaming Mouse"
#     xinput --set-prop @(mouse_name) 'Coordinate Transformation Matrix' @(speed) 0 0 0 @(speed) 0 0 0 1
def resetrepeatrate [] {
    xset r rate 192 48
}
def setkeymap [] {
    setxkbmap -layout is,us -option grp:win_space_toggle
}

def setplanckkeymap [] {
    for ide in (_get_device_ids 'ZSA Planck EZ Keyboard' "keyboard") {
        setxkbmap -layout is -device $ide
    }
}
def setpreonickeymap [] {
    for ide in (_get_device_ids 'OLKB Preonic' "keyboard") {
        setxkbmap -layout is -device $ide
    }
}
def setmoonlanderkeymap [] {
    for ide in (_get_device_ids 'ZSA Technology Labs Moonlander Mark I' "keyboard") {
        setxkbmap -layout is -device $ide
    }
}

def planck [] {
    setplanckkeymap; resetrepeatrate
}
def preonic [] {
    setpreonickeymap; resetrepeatrate
}
def moonlander [] {
    setmoonlanderkeymap; resetrepeatrate
}

resetrepeatrate
# setkeymap()


def --env _activate_keychain [path] {
    let data = open $path | parse -r "SSH_AUTH_SOCK=(?<sock>.*); export SSH_AUTH_SOCK;\nSSH_AGENT_PID=(?<pid>.*); export SSH_AGENT_PID;"
    $env.SSH_AUTH_SOCK = $data.sock.0
    $env.SSH_AGENT_PID = $data.pid.0
}

def --env setup_keychain [] {
    keychain -q --absolute --dir $"($env.XDG_RUNTIME_DIR)/keychain" --eval id_ed25519 | save -f "/tmp/keychain.sh"
    _activate_keychain "/tmp/keychain.sh"
}

if (ls /tmp | where name == /tmp/keychain.sh | length) == 1 {
    _activate_keychain "/tmp/keychain.sh"
}

# plugins
source zoxide.nu
source ~/.local/share/atuin/init.nu
