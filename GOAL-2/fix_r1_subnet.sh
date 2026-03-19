#!/bin/bash
sshpass -p 'Network!337' ssh -o StrictHostKeyChecking=no -tt admin@10.0.1.1 << 'EOF'
configure terminal
interface GigabitEthernet0/0/0.10
ip address 192.168.0.1 255.255.255.0
end
exit
EOF
