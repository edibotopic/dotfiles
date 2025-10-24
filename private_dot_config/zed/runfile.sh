#!/bin/bash

# Access full path
full_path="$ZED_FILE"

# Extract file
filename_ext=$(basename "$full_path")

# Extract filename and extension
filename="${filename_ext%.*}"
extension="${filename_ext##*.}"

echo "[running $filename_ext]"

if [[ "$extension" == "cpp" ]]; then
    g++ "$full_path" -o "$filename" && ./"$filename";
elif [[ "$extension" == "py" ]]; then
    source ../py/bin/activate
    python3 "$full_path";
elif [[ "$extension" == "odin" ]]; then
    odin run .
else
    echo "nothing to run"
fi
