#!/bin/bash
# ===========================
# BASH SCRIPTING - LESSON 5
# Arrays
# ===========================


# --- Declaring Arrays ---
fruits=("apple" "banana" "cherry" "date" "elderberry")

# --- Accessing Arrays ---
echo "=== Accessing Elements ==="
echo "First:  ${fruits[0]}"
echo "Second: ${fruits[1]}"
echo "Last:  ${fruits[-1]}"


# --- All Elements ---
echo ""
echo "=== All Elements ==="
echo "All: ${fruits[@]}"
echo "All: ${fruits[*]}"


# --- Array Length ---
echo ""
echo "=== Array Info ==="
echo "Length: ${#fruits[*]}"


# --- Looping Over Array ---
echo ""
echo "=== Looping Over Array ==="
for fruit in "${fruits[@]}"; do
    echo "   - $fruit"
done


# --- Looping with Index ---
echo ""
echo "=== Looping With Index ===" 
for i in "${!fruits[@]}"; do    # ! = indicies
    echo "  $i: ${fruits[$i]}"
done


# --- Adding Elements ---
echo ""
echo "=== Adding Elements ==="
fruits+=("fig")     # append
fruits[6]="grape"   # set specific Index
echo "After adding: ${fruits[*]}"


# ---Removing ELements ---
unset fruits[1]         # remove banana
echo "After removing index 1: ${fruits[*]}"
echo "Length now: ${#fruits[*]}"


# --- Slicing ---
echo ""
echo "=== Slicing ==="
echo "Elements 2-4: ${fruits[*]:2:3}"


# --- Associative Arrays (Like dictionaries) ---
echo ""
echo "=== Associative Arrays ==="
declare -A person
person["name"]="Jason"
person["age"]="50"
person["os"]="Linux"
person["language"]="Bash"

echo "Name:             ${person[name]}"
echo "Age:              ${person[age]}"
echo "OS:               ${person[os]}"
echo "Language:         ${person[language]}"


# --- Loop Over Associative Array ---
echo ""
echo "=== All Person Data ==="
for key in "${!person[@]}"; do
    echo "   $key: ${person[$key]}"
done


# --- Practical Example ---
# Store command outputs in Array
echo ""
echo "=== Bash Scripts Found ==="
scripts=()
for file in ~/projects/bash/*.sh; do
    scripts+=("$file")
done

echo "Found ${#scripts[@]} scripts:"
for script in "${scripts[@]}"; do
    echo "    $(basename $script)"
done

