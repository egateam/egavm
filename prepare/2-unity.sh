#!/usr/bin/env bash

# http://superuser.com/questions/244189/bashrc-how-to-know-x-window-is-available-or-not
if [ -n "$DISPLAY" ]; then
    # gsettings get com.canonical.Unity.Launcher favorites
    echo " + Set Unity launcher items"
    gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'unity://running-apps', 'application://gnome-system-monitor.desktop', 'unity://expo-icon', 'unity://devices']"

    # http://askubuntu.com/questions/177348/how-do-i-disable-the-screensaver-lock
    echo " + Disable unity lock screen"
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0 # (0 to disable)
else
    echo "This script should be execute inside a GUI terminal"
fi
