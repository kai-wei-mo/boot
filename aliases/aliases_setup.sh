#!/bin/bash

# -y flag
skip_confirmation=false
while getopts "y" opt; do
    case $opt in
        y) skip_confirmation=true ;;
        *) ;;
    esac
done

if [ "$skip_confirmation" = false ]; then
    read -p "This file will overwrite files in ~/.aliases directory with ones in \
    the same directory as this script. Are you okay with this? (y/N): " \
    confirmation

    if [[ $confirmation != [yY] ]]; then
        echo "Operation aborted."
        exit 0
    fi
fi

if [ ! -d ~/.aliases ]; then
    mkdir ~/.aliases
    echo "📁 Created: ~/.aliases"
else
    echo "📁 Found: ~/.aliases"
fi

if [ -d ~/.aliases ]; then
    # copy all files from the aliases_files directory
    # into the ~/.aliases directory
    script_dir=$(dirname "$0")
    aliases_files_dir="$script_dir/aliases_files"
    to_be_copied=$(find "$aliases_files_dir" -maxdepth 1 -type f)
    to_be_copied=$(echo "$to_be_copied" | sort)
    for file in $to_be_copied; do
        exists=$(find ~/.aliases -maxdepth 1 -type f -name "$(basename "$file")")
        filename=$(basename "$file")
        cp "$file" ~/.aliases

        if [[ $exists ]]; then
            echo "  📎 Copied: $filename (overwritten)"
        else
            echo "  📎 Copied: $filename"
        fi
    done

    echo "✅ Copied all files from aliases_files to ~/.aliases"
fi

shell_files=("$HOME/.zshrc" "$HOME/.bashrc")
# add aliases to shellfiles
echo "📝 Adding alias sourcing loop to shell files"
for config_file in "${shell_files[@]}"; do
    # Check if the file exists
    if [[ ! -f "$config_file" ]]; then
        echo "  😐 File not found: $config_file"
        continue
    fi

    # Append the alias sourcing loop to the end of the file if it isn't already in there somewhere
    if ! grep -q "Source all alias files in the ~/.aliases directory" "$config_file"; then
        printf "\n\n" >> "$config_file"
        echo "# Source all alias files in the ~/.aliases directory" >> "$config_file"
        echo "for alias_file in ~/.aliases/*; do" >> "$config_file"
        echo "    source \"\$alias_file\"" >> "$config_file"
        echo "done" >> "$config_file"
        echo "  ✅ Appended: Alias sourcing loop to $config_file"
        source $config_file
    else
        echo "  ✅ Found: Alias sourcing loop in $config_file"
    fi
done

echo ""
echo "📝 Please source your shell config file(s) to start using the aliases."
