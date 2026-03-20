#!/bin/bash
# ===========================
# BASH SCRIPTING - LESON 2
# ===========================


# --- reading User Input ---
echo "What is your name?"
read user_name

echo "How old are you?"
read user_age

echo "Hello $user_name, you are $user_age years old."

# --- BAsic if/else ---
if [ $user_age -ge 18 ]; then
    echo "you are an adult."
else
    echo "You are a minor."
fi

# --- elif ---
if [ $user_age -lt 13 ]; then
    echo "You are a child."
elif [ $user_age -lt 18 ]; then
    echo "You are a teenager."
elif [ $user_age -lt 65 ]; then
    echo "You are an adult."
else
    echo "You are a senior."
fi

# --- String comparison ---
echo ""
echo "What is your favorite OS?"
read os

if [ "$os" = "Linux" ]; then
    echo "Excellent choice!"
elif [ "$os" = "Windows" ]; then
    echo "We can fix that"
else
    echo "Interesting choice: $os"
fi


# --- File tests ---
echo ""
echo "Enter a filename to check:"
read filename

if [ -f "$filename" ]; then
    echo "$filename exists and is a file."
elif [ -d "$filename" ]; then
    echo "$filename exists and is a directory."
else
    echo "$filename does not exist."
fi
