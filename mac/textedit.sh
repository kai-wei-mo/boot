#!/bin/sh

############
# TextEdit #
############

# Make TextEdit more like Notepad, i.e., default to plan text, not RTF files
defaults write com.apple.TextEdit RichText -boolean false
