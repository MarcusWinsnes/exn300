#!/bin/bash
PASS="Network!337"
LOG="/mcp/mcp.log"

# Save R1
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group14-sha1 admin@10.0.1.1 2>/dev/null << EOF
write memory
EOF
echo "[$(date "+%Y-%m-%d %H:%M:%S")] R1 | write memory" >> $LOG

# Save SW1
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group14-sha1 admin@10.0.1.2 2>/dev/null << EOF
write memory
EOF
echo "[$(date "+%Y-%m-%d %H:%M:%S")] SW1 | write memory" >> $LOG

echo "[$(date "+%Y-%m-%d %H:%M:%S")] SYSTEM | === MÄTBART MÅL 1 - TASK 1 COMPLETE ===" >> $LOG
echo "CONFIGS_SAVED"
