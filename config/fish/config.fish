if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set -x BAT_THEME "Nord"

function sudo --description "Replacement for Bash 'sudo !!'"
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# Ghcup env
if test -f $HOME/.ghcup/env
    contains $HOME/.cabal/bin $PATH
    or fish_add_path -mpP $HOME/.cabal/bin
    contains $HOME/.ghcup/bin $PATH
    or fish_add_path -mpP $HOME/.ghcup/bin
end

# Brew m1
if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin
end

alias ghidra="$HOME/hack/software/re/ghidra/build/dist/ghidra_10.3_DEV/ghidraRun"
