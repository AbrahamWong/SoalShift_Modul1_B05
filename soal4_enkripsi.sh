#!/bin/bash

# Buat nyimpan jamnya
jam=$(date "+%H")
# Buat nyimpan namafilenya
filename=$(date "+%H:%M %d-%B-%Y")

# Case buat uppercase atau lowercase
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

cat /var/log/syslog | tr "${lower:0:26}" "${lower:jam:26}" | tr "${upper:0:26}" "${upper:jam:26}"  > "$filename"