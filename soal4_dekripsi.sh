#!/bin/bash

# Mengambil argumen pertama dari file
file="$1"
filename="$1-dec"
jam="${file:0:2}"

# Case buat uppercase atau lowercase
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

cat "$1" | tr "${lower:0:26}" "${lower:26-jam:26}" | tr "${upper:0:26}" "${upper:26-jam:26}"  > "$filename"