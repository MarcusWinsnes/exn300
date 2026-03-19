#!/bin/bash
DEVICE="10.0.1.2"
USER="admin"
PASS="Network!337"
LOG="/mcp/mcp.log"

run_cmd() {
    local cmd="$1"
    local device_name="$2"
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $device_name | $cmd" >> $LOG
    sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group14-sha1 $USER@$DEVICE "$cmd" 2>/dev/null
}

# Configure SW1 using Cisco CLI via SSH
sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -o KexAlgorithms=+diffie-hellman-group14-sha1 $USER@$DEVICE 2>/dev/null << EOF
configure terminal
hostname SW1
vlan 10
name PC1-SUBNET
exit
vlan 20
name PC2-SUBNET
exit
interface GigabitEthernet1/0/2
switchport mode access
switchport access vlan 10
no shutdown
exit
interface GigabitEthernet1/0/3
switchport mode access
switchport access vlan 20
no shutdown
exit
interface GigabitEthernet1/0/1
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan 10,20
no shutdown
exit
end
EOF

# Log all commands
for CMD in \
    "hostname SW1" \
    "vlan 10 - name PC1-SUBNET" \
    "vlan 20 - name PC2-SUBNET" \
    "interface Gi1/0/2 - switchport mode access - switchport access vlan 10" \
    "interface Gi1/0/3 - switchport mode access - switchport access vlan 20" \
    "interface Gi1/0/1 - switchport trunk encapsulation dot1q - switchport mode trunk - trunk allowed vlan 10,20"; do
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] SW1 | $CMD" >> $LOG
done

echo "SW1_CONFIG_COMPLETE"
