#!/bin/sh

mkdir -p output

for input_file in data/*; do
  filename=$(basename "$input_file")
  output_file="output/$filename.json"

  echo "[" > "$output_file"

  first=1
  while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines
    [ -z "$line" ] && continue

    name=$(printf '%s' "$line" | cut -d'|' -f1)
    version=$(printf '%s' "$line" | cut -d'|' -f2)
    description=$(printf '%s' "$line" | cut -d'|' -f3)
    url=$(printf '%s' "$line" | cut -d'|' -f4)

    # Basic JSON escaping for quotes and backslashes
    escape() {
      printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'
    }

    name=$(escape "$name")
    version=$(escape "$version")
    description=$(escape "$description")
    url=$(escape "$url")

    if [ $first -eq 1 ]; then
      first=0
    else
      echo "," >> "$output_file"
    fi

    cat >> "$output_file" <<EOF
  {
    "name": "$name",
    "version": "$version",
    "description": "$description",
    "url": "$url"
  }
EOF

  done < "$input_file"

  echo "" >> "$output_file"
  echo "]" >> "$output_file"
done
