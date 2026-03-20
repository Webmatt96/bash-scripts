#!/bin/bash
# ===========================
# BASH SCRIPTING - LESSON 1
# Variables
# ===========================


# --- Declaring Variables ---
# No spaces around the = sign (this is critical)
name="JMatt"
age=42
pi=3.14159

# --- using Variables
# Prefix with $ ro use the value
echo "Name: $name"
echo "Age: $age"
echo "Pi: $pi"

# --- String interpolation ---
# Curlet braces make variable boundaries clear
echo "My name is ${name} and I am ${age} years old."

# --- Command substitution ---
# $() captures the output of a command
current_date=$(date)
current_user=$(whoami)
home_dir=$(echo $HOME)

echo "Date: $current_date"
echo "User: $current_user"
echo "Home: $home_dir"

# --- Arithmetic ---
# $(()) perorms integer Arithmetic
a=10
b=3
sum=$((a + b))
difference=$((a - b))
product=$((a * b))
quotient=$((a / b))
remainder=$((a % b))

echo ""
echo "=== Arithmetic ==="
echo "$a + $b = $sum"
echo "$a - $b = $difference"
echo "$a * $b = $product"
echo "$a / $b = $quotient"
echo "$a % $b = $remainder"

# --- Readonly variables ---
readonly MAX_SIZE=100
echo "" 
echo "Max size: $MAX_SIZE"

# --- Unsetting variables ---"
temp="temporary"
echo "Before unset: $temp"
unset temp
echo "After unset: $temp"

