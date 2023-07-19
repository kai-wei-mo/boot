#!/bin/bash

# Find all .sh files (excluding files starting with an underscore) in the same
# directory as this very file
sh_files=$(find "$(dirname "$0")" -maxdepth 1 -type f -name '*.sh' ! -name '_*')

# Define the array of shell configuration files
shell_files=("$HOME/.zshrc" "$HOME/.bashrc")

# Loop through the shell configuration files
for config_file in "${shell_files[@]}"; do
  # Check if the file exists
  if [[ ! -f "$config_file" ]]; then
    echo "File not found: $config_file"
    continue
  fi

  # Append the content of each .sh file
  for file in $sh_files; do
    filename=$(basename "$file")
    echo "Processing: $filename"

    start_line="#### START OF $filename "
    start_line_length=${#start_line}
    start_line+="$(printf '#%.0s' $(seq 1 $((80 - start_line_length)) ))"
    printf "\n\n%s\n" "$start_line" >> "$config_file"

    # append the contents of file to end of config_file
    cat "$filename" >> "$config_file"

    end_line="#### END OF $filename "
    end_line_length=${#end_line}
    end_line+="$(printf '#%.0s' $(seq 1 $((80 - end_line_length)) ))"
    printf "%s\n" "$end_line" >> "$config_file"

    echo "Appended: $filename to $config_file"
  done
done
