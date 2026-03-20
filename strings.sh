#!/bin/bash
# ===========================
# BASH SCRIPTING - LESSON 6
# String Manipulation
# ===========================


# --- String Length ---
name="Jason Matthews"
echo "=== String Length ==="
echo "String: $name"
echo "Length: ${#name}"


# --- Substring Extraction --- 
echo ""
echo "=== Substring Extraction ==="
echo "Full:         $name"
echo "From pos 6:   ${name:6}"          # From position 6 to end
echo "5 chars:      ${name:0:5}"        # 5 chars from position 0
echo "Last 9:       ${name: -9}"        # last 9 characters


# --- String REplacement ---
echo ""
echo "=== String Replacement ==="
sentence="I love Windows and Windows is great"
echo "Original:         $sentence"
echo "First Only:       ${sentence/Windows/Linux}"  # Replace first
echo "All:              ${sentence//Windows/Linux}" # Replaces all


# --- Case Conversion ---
echo ""
echo "=== Case Conversion ==="
text="Hello World"
echo "Original:     $text"
echo "Uppercase:    ${text^^}"      # all uppercase
echo "Lowercase:    ${text,,}"      # all lowercase
echo "First cap:    ${text^}"       # capitalize first letter
echo "First low:    ${text,}"       # lowercase first letter


# --- String Trimming ---
echo ""
echo "=== Removing Patterns ==="
filename="report_2026_final.txt"
echo "Original:             $filename"
echo "Remove prefix:        ${filename#report_}"  # removes shortest prefix
echo "Remove suffix:        ${filename%.txt}"     # removes shortest suffix
echo "Get extension:        ${filename##*.}"      # remove longest prefix


# --- Strip from path ---
filepath="/home/jmatt/projects/bash/strings.sh"
echo ""
echo "=== Path Manipulation ==="
echo "Full path:        $filepath"
echo "Filename:         ${filepath##*/}"    # everything after last /
echo "Directory:        ${filepath%/*}"     # everything before last /
echo "No extension:     ${filepath%.*}"     # remove extension


# --- String Contains ---
echo ""
echo "=== String Tests ==="
haystack="The quick brown fox"

if [[ "$haystack" == *"quick"* ]]; then
    echo "Contains 'quick': yes"
fi

if [[ "$haystack" == *"slow"* ]]; then
    echo "Contains 'slow': yes"
else
    echo "Contains 'slow': no"
fi

# --- String Starts/Ends With ---
if [[ "$haystack" == The* ]]; then
    echo "Starts with 'The': yes"
fi

if [[ "$haystack" == *fox ]]; then
    echo "Ends with 'fox': yes"
fi


# --- Split String ---
echo ""
echo "=== Splitting Strings ==="
csv="apple,banana,cherry,date"
echo "Original: $csv"

# split csv string into array
IFS=',' read -ra items <<< "$csv"
echo "Split into array:"
for item in "${items[@]}"; do
    echo "  - $item"
done


# --- String Padding and Formatting ---
echo ""
echo "=== Formatted Outputs ==="
printf "%-15s %5s %10s\n" "Name" "Age" "Language"
printf "%-15s %5s %10s\n" "Jason" "50" "Bash"
printf "%-15s %5s %10s\n" "Alice" "30" "Python"
printf "%-15s %5s %10s\n" "Bob" "25" "Rust"
