#!/bin/bash
# ===========================
# BASH SCRIPTING - LESSON 4
# Functions
# ===========================

# Basic Function ---
# Define first, call second
greet() {
    echo "Hello from a function!"
}

greet

# --- Function with arguments ---
# Arguments come in as $1, $2, $3...
greet_user() {
    echo "Hello, $1!"
    echo "You are $2 years old."
}

greet_user "Jason" 50

# --- Function with return value ---
# bash functions return exit codes (0=success, 1=failure)
# To return actual data ise echo and command substitution
add_numbers() {
    local result=$(($1 + $2))
    echo $result
}

sum=$(add_numbers 10 25)
echo "10 + 25 = $sum"

# --- local variables ---
# Use 'local' to keep variables inside the function

counter=100

increment() {
    local counter=0
    counter=$((counter + 1))
    echo "Inside function: $counter"
}

increment
echo "Outside function: $counter"

# --- Fubction with return status ---
is_adult() {
    if [ $1 -ge 18 ]; then
       return 0
    else
        return 1
    fi
}

is_adult 50
if [ $? -eq 0 ]; then
    echo "50: is an adult"
else
    echo "50: is not an adult"
fi

is_adult 15
if [ $? -eq 0 ]; then
    echo "15: is an adult"
else
    echo "15: is not an adult"
fi

# --- Recursive Functions ---
factorial() {
   if [ $1 -le 1 ]; then
       echo 1
       return
   fi
   local prev=$(factorial $(($1 - 1)))
   echo $(($1 * prev))
}

echo ""
echo "=== Factorials ==="
for i in 1 2 3 4 5; do
    result=$(factorial $i)
    echo "$i! = $result"
done

# --- Practical function ---
# A function that checks if a command eists
command_exists() {
    command -v "$1" &>/dev/null
}

echo ""
echo "=== Command Checks ==="
for cmd in python3 nvim git nasm ruby; do
    if command_exists "$cmd"; then
        echo "  $cmd: installed"
    else
        echo "  $cmd: NOT installed"
    fi
done
