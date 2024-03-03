# Nushell Environment Config File
#
# version = "0.90.1"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.PATH = [
    /home/hugsun/.local/share/python/bin,
    /home/hugsun/.local/bin,
    /usr/local/sbin,
    /usr/local/bin,
    /usr/bin,
    /home/hugsun/Programming/go/bin,
    /home/hugsun/.local/share/cargo/bin,
    /home/hugsun/.local/share/npm/bin,
    /home/hugsun/.local/share/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/
    /home/hugsun/,
]

source ~/.config/nushell/env/xonsh-migration.nu
source ~/.config/nushell/env/nu-env.nu
