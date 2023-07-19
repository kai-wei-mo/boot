#!/bin/bash

read -p "This file will overwrite files in ~/.aliases directory with ones in \
the same directory as this script. Are you okay with this? (y/N): " \
confirmation

if [[ $confirmation != [yY] ]]; then
    echo "Operation aborted."
    exit 0
fi

if [ ! -d ~/.aliases ]; then
    # create ~/.aliases
    mkdir ~/.aliases
    echo "📁 Created: ~/.aliases"
else
    echo "📁 Found: ~/.aliases"
fi

if [ -d ~/.aliases ]; then
    # copy all .sh files in the same directory as this file
    # whose file name does not begin with underscore
    # into the ~/.aliases directory
    to_be_copied=$(find "$(dirname "$0")" -maxdepth 1 -type f -name '*.sh' ! -name '_*')
    to_be_copied=$(echo "$to_be_copied" | sort)
    for file in $to_be_copied; do
        exists=$(find ~/.aliases -maxdepth 1 -type f -name "$(basename "$file")")
        filename=$(basename "$file")
        cp "$filename" ~/.aliases

        if [[ $exists ]]; then
            echo "  📎 Copied: $filename (overwritten)"
        else
            echo "  📎 Copied: $filename"
        fi
    done

    echo "✅ Copied all alias files to ~/.aliases"
fi

shell_files=("$HOME/.zshrc" "$HOME/.bashrc")
# add aliases to shellfiles
echo "📝 Adding 'source ~/.aliases' to shell files"
for config_file in "${shell_files[@]}"; do
    # Check if the file exists
    if [[ ! -f "$config_file" ]]; then
        echo "  😐 File not found: $config_file"
        continue
    fi

    # Append "source ~/.aliases" to the end of the file if it isnt already in there somewhere
    if ! grep -q "source ~/.aliases" "$config_file"; then
        printf "\n\n" >> "$config_file"
        echo "source ~/.aliases" >> "$config_file"
        echo "  ✅ Appended: 'source ~/.aliases' to $config_file"
    else
        echo "  ✅ Found: 'source ~/.aliases' in $config_file"
    fi
done
