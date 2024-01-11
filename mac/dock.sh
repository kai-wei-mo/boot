#!/bin/bash

########
# Dock #
########

defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Minimize windows using: Scale effect
defaults write com.apple.dock "mineffect" -string "scale"

# Show suggested and recent apps in Dock: Off
defaults write com.apple.dock show-recents -bool FALSE

# Force reload settings
killall dock
