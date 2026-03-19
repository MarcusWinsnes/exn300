#!/bin/bash
DEVICE_IP=$1
CFG_FILE=$2
DEVICE_NAME=$3

echo "=== Pushing config to $DEVICE_NAME ($DEVICE_IP) ==="

# Build the command string from config file
CMDS=""
while IFS= read -r line; do
  # Skip empty lines and comment-only lines
  [[ -z "$line" || "$line" =~ ^[[:space:]]*$ ]] && continue
  [[ "$line" =~ ^! ]] && continue
  CMDS+="$line\n"
done < "$CFG_FILE"

# Send via SSH
printf "$CMDS" | timeout 30 sshpass -p Network!337 ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 -tt admin@$DEVICE_IP

echo ""
echo "=== Config push to $DEVICE_NAME complete ==="

# Log to mcp.log
echo "[$(date "+%Y-%m-%d %H:%M:%S")] $DEVICE_NAME | Step 1 config pushed from $CFG_FILE" >> /mcp/mcp.log
