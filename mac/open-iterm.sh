#!/bin/sh
path="$1"

osascript <<EOF
tell application "iTerm"
    tell current window
        create tab with default profile
        tell current session of current tab
            write text "cd $path"
        end tell
    end tell
end tell

tell application "iTerm" to activate
EOF
