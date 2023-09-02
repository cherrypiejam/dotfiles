#!/usr/bin/env fish

set SP /tmp/SCRATCHPAD

if test -e $SP
    cat $SP | read SPPID
end

if not set -q SPPID; \
    or test -z "$(yabai -m query --windows | jq ".[] | select(.pid==$SPPID)")"

    if set -q SPPID;
        kill -9 $SPPID &> /dev/null # GC
    end

    /Applications/Alacritty.app/Contents/MacOS/alacritty &> /dev/null &
    set SPPID $last_pid

    for i in (seq 1 500)
        set SPID (yabai -m query --windows | jq ".[] | select(.pid==$SPPID) | .id")
        if test -n "$SPID"
            break
        end
    end
    if test -z "$SPID"
        kill -9 $SPPID &> /dev/null
        exit
    end

    yabai -m window $SPID --toggle float
    yabai -m window $SPID --grid 4:4:1:1:2:2

    echo $SPPID > $SP

else
    set SPID (yabai -m query --windows | jq ".[] | select(.pid==$SPPID) | .id")
    set SP_ISMINIMIZED (yabai -m query --windows | jq ".[] | select(.pid==$SPPID) | .\"is-minimized\"")
    set SP_ISFLOATING (yabai -m query --windows | jq ".[] | select(.pid==$SPPID) | .\"is-floating\"")
    set SP_SPACE (yabai -m query --windows | jq ".[] | select(.pid==$SPPID) | .\"space\"")
    set CURRENT_SPACE (yabai -m query --spaces --space | jq '.index')

    if test $SP_ISFLOATING = 'false'
        yabai -m window $SPID --toggle float
    end

    if test $SP_ISMINIMIZED = 'true'
        yabai -m window $SPID      \
            --space $CURRENT_SPACE \
            --deminimize $SPID     \
            --focus $SPID          \
            --grid 4:4:1:1:2:2
    else
        if test $CURRENT_SPACE = $SP_SPACE
            yabai -m window        \
                --minimize $SPID   \
                --focus (yabai -m query --windows --space | jq --slurp '.[] | .[1].id')
        else
            yabai -m window $SPID      \
                --space $CURRENT_SPACE \
                --focus $SPID
        end
    end
end
