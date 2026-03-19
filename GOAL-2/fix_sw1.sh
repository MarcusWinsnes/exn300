#!/bin/bash
sshpass -p 'Network!337' ssh -o StrictHostKeyChecking=no -tt admin@10.0.1.2 << 'EOF'
configure terminal
interface GigabitEthernet1/0/3
switchport access vlan 20
end
exit
EOF
