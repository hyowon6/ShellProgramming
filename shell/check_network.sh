#!/bin/bash
###################
# 1. ping 192.168.10.2
# 2. ping 8.8.8.8
# 3. ping www.google.com
############################
IP1=192.168.10.2
IP2=8.8.8.8
IP3=www.google.com

source $HOME/shell/functions.sh

# 1. 로컬 네트워크에 ping 테스트
print_info "ping $IP1"
ping -c 2 -W 1 $IP1 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] Local Network Connection"
else
    print_error "[  FAIL  ] Local Network Connection"
    cat << EOF
    [ FAIL ] Local Network Connection
    (ㄱ) VMware >  Edit > Virtual Network Editor
    (ㄴ) VMware > VM > Settings > Network Adapter
    (ㄷ) # ip addr
EOF
    exit 1
fi

echo

# 2. 외부 네트워크에 ping 테스트
print_info "ping $IP2"
ping -c 2 -W 1 $IP2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] External Network Connection"
else
    print_error "[  FAIL  ] External Network Connection"
    cat << EOF
    [ FAIL ] External Network Connection
    (ㄱ) # ip route 
EOF
    exit 2
fi

echo
# 3. 외부 이름에 ping 테스트
print_info "ping $IP3"
ping -c 2 -W 1 $IP3 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "[  OK  ] DNS Client Configuration"
else
    print_error "[  FAIL  ] DNS Client Configuration"
    cat << EOF
    (ㄱ) # cat /etc/resolv.conf
EOF
    exit 3
fi
