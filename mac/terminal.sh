#!/bin/sh

############
# Terminal #
############

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Show sysinfo at login
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
