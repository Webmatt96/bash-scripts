#!/bin/bash
# ===========================
# BASH SCRIPTING - LESSON 3
# Loops
# ===========================


# For loop over a list
echo "=== Favorite Languages ==="
for language in Python BASH Rust "C#" Assembly; do
    echo " - $language"
done

# --- For loop with a range ---
echo ""
echo "=== Counting to 5 ==="
for i in {1..5}; do
    echo " Number: $i"
done


# --- For loop with step ---
echo ""
echo "=== Even numbers to 10 ==="
for i in {2..10..2}; do
    echo "    $i"
done


# --- C-style for loop ---
echo ""
echo "=== C-style loop ==="
for ((i=0; i<5; i++)); do
    echo "    i = $i"
done


# --- While loop ---
echo ""
echo "=== While Loop ==="
count=1
while [ $count -le 5 ]; do
    echo "    Count: $count"
    count=$((count +1))
done


# --- Untill loop ---
echo ""
echo "=== Untill loop==="
num=10
until [ $num -eq 0 ]; do
    echo "    Num: $num"
    num=$((num - 2))
done


# --- Loop over files ---
echo ""
echo "=== Bash scripts in projects ==="
for file in ~/projects/bash/*.sh; do
    echo "    Found: $file"
done

# --- Break and continue ---
echo ""
echo "=== Break and Continue"
for i in {1..10}; do
    if [ $i -eq 3 ]; then
        echo "    Skipping 3"
        continue
    fi
    if [ $i -eq 7 ]; then
        echo "    Stopping at 7"
        break
    fi
    echo "    i = $i"
done
