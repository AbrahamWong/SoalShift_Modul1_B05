#!/bin/bash

# Jika folder belum ada, maka dibuat terlebih dahulu
mkdir -p /home/$USER/modul1

awk '{if ($0 ~/cron/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog > /home/$USER/modul1/record.log