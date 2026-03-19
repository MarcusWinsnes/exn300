#!/bin/bash
sshpass -p 'Network!337' ssh -o StrictHostKeyChecking=no -tt admin@10.0.1.1 << 'EOF'
configure terminal
interface GigabitEthernet0/0/0.20
no ip access-group NO-CLANKERS-ALLOWED out
exit
no ip access-list standard NO-CLANKERS-ALLOWED
end
exit
EOF
