#!/bin/sh

# Set up directories
BASE_DIR=$(dirname "$0")
PAGES_DIR="${BASE_DIR}/CompSci.playground/Pages"
OUTPUT_DIR="${BASE_DIR}/docs"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Find all playground pages and sort them
find "$PAGES_DIR" -name "*.xcplaygroundpage" | sort > /tmp/pages.txt

printf "Found pages:\n"
cat /tmp/pages.txt
printf "\n"

# Build table of contents
TOC="<details id="contents">\n<summary><strong>Table of Contents</strong></summary><ol>\n\n"
while IFS= read -r page; do
  base_name=$(basename "$page" .xcplaygroundpage)
  display_name=${base_name#*-}

  # For table of contents links, use the original filename except for the index
  if [ "$base_name" = "00-Introduction" ]; then
    TOC="${TOC}<li><a href=\"./index.md\">${display_name}</a></li>\n"
  else
    TOC="${TOC}<li><a href=\"./${base_name}.md\">${display_name}</a></li>\n"
  fi
done < /tmp/pages.txt
TOC="${TOC}\n</ol></details>\n\n---\n"

# Process each page
while IFS= read -r page; do
  base_name=$(basename "$page" .xcplaygroundpage)
  content_file="${page}/Contents.swift"

  # Set the output filename, using index.md for the introduction
  if [ "$base_name" = "00-Introduction" ]; then
    output_file="${OUTPUT_DIR}/index.md"
  else
    output_file="${OUTPUT_DIR}/${base_name}.md"
  fi

  printf "Processing $base_name...\n"

  # Write table of contents
  printf "%b" "$TOC" > "$output_file"

  # Process the Swift file if it exists
  if [ -f "$content_file" ]; then
    # Use awk to process the file and handle multiple comment blocks
    awk '
      BEGIN {
        in_comment = 0;
        in_code = 0;
        buffer = "";
      }

      # Skip playground navigation comments
      /^\/\/: \[/ { next }

      # Handle comment blocks start
      /\/\*:/ {
        if (in_code) {
          # If we were in a code block, finish it
          if (buffer != "") {
            gsub(/\n+$/, "", buffer);
            print buffer;
            buffer = "";
          }
          print "```\n";
          in_code = 0;
        }
        in_comment = 1;
        next;
      }

      # Handle comment blocks end
      /\*\// {
        in_comment = 0;
        next;
      }

      # Handle content in comment blocks (markdown)
      in_comment == 1 {
        # Trim leading spaces from markdown lines
        gsub(/^[ \t]+/, "");
        print;
        next;
      }

      # Only process specially marked doc comments, leave regular Swift comments in code blocks
      /^\/\/\/:/ {
        if (in_code) {
          # If we were in a code block, finish it
          if (buffer != "") {
            gsub(/\n+$/, "", buffer);
            print buffer;
            buffer = "";
          }
          print "```\n";
          in_code = 0;
        }
        # Remove special doc comment markers (///)
        sub(/^\/\/\/[ \t]*/, "", $0);
        # Trim leading spaces from markdown lines
        gsub(/^[ \t]+/, "");
        print;
        next;
      }

      # Handle regular code lines (including comments)
      {
        if (!in_code) {
          print "\n```swift";
          in_code = 1;
        }
        # For code, preserve indentation but remove leading space
        # that might come from the Swift playground format
        line = $0;
        # Remove exactly one leading space if present (typical playground format)
        sub(/^ /, "", line);
        if (buffer == "") {
          buffer = line;
        } else {
          buffer = buffer "\n" line;
        }
        next;
      }

      # Handle empty lines
      /^[ \t]*$/ {
        if (in_code) {
          # Add the empty line to the code buffer
          buffer = buffer "\n";
        } else {
          # Empty line in markdown
          print "";
        }
        next;
      }

      # At the end, close any open code block
      END {
        if (in_code) {
          # Clean up any trailing newlines
          gsub(/\n+$/, "", buffer);
          print buffer;
          print "```\n";
        }
      }
    ' "$content_file" >> "$output_file"

    printf "Created $output_file\n"
  else
    printf "Warning: $content_file not found\n"
  fi
done < /tmp/pages.txt

# Clean up
rm /tmp/pages.txt

printf "All pages processed to markdown in $OUTPUT_DIR\n"
