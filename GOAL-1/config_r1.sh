#!/bin/bash
DEVICE="10.0.1.1"
USER="admin"
PASS="Network!337"
LOG="/mcp/mcp.log"

sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group14-sha1 $USER@$DEVICE 2>/dev/null << EOF
configure terminal
hostname R1
interface GigabitEthernet0/0/0
no ip address
no shutdown
exit
interface GigabitEthernet0/0/0.10
encapsulation dot1Q 10
ip address 192.168.0.1 255.255.255.0
no shutdown
exit
interface GigabitEthernet0/0/0.20
encapsulation dot1Q 20
ip address 192.168.1.1 255.255.255.0
no shutdown
exit
end
EOF

# Log commands
for CMD in \
    "hostname R1" \
    "interface Gi0/0/0 - no ip address - no shutdown" \
    "interface Gi0/0/0.10 - encapsulation dot1Q 10 - ip address 192.168.0.1 255.255.255.0" \
    "interface Gi0/0/0.20 - encapsulation dot1Q 20 - ip address 192.168.1.1 255.255.255.0"; do
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] R1 | $CMD" >> $LOG
done

echo "R1_CONFIG_COMPLETE"
