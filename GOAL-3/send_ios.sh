#!/bin/bash
# Usage: send_ios.sh <device_ip> <command1> <command2> ...
IP=$1; shift
{
for cmd in "$@"; do
  echo "$cmd"
  sleep 0.3
done
} | timeout 60 sshpass -p Network!337 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 -tt admin@$IP 2>&1
