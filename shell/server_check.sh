#!/bin/bash

export LANG=en_US.UTF-8

# Function definitions
Paste() {
    ENTERLINE=$*
    echo "$ENTERLINE"
}

# DATE 변수
DATE=$(date +'%F %T')

# NAME 변수
: << EOF
YESNO='n'
while [ "$YESNO" != 'y' ]
do
    echo 
    echo -n "작성자 이름 입력(ex: Baik,SeungChan): "
    read NAME
    echo ; echo "    * 작성자 이름: $NAME" ; echo
    echo -n "작성된 내용 맞습니까? (y/n): "
    read YESNO
done
EOF
NAME='Baik,SeungChan'

# OS 변수
OS=$(cat /etc/centos-release)

# KERNEL 변수
KERNEL=$(uname -sr)

# CPU 변수
CPUNUM=$(lscpu -e | tail -n +2 | wc -l)
CPUTYPE=$(echo $(cat /proc/cpuinfo | grep 'model name' | uniq | awk -F: '{print $2}'))
CPU="$CPUNUM ($CPUTYPE)"

# MEM 변수
MEM=$(free -h | grep '^Mem:' | awk '{print $2}')

# DISK 변수
DISK=$(lsblk | grep disk | wc -l)

echo
echo "--------------- [시작] 결과 보고서 ------------------"
cat << EOF

Server Vul. Checker version 1.0

DATE: $DATE
NAME: $NAME


(1) Server Information
============================================
OS     : $OS
Kernel : $KERNEL
CPU    : $CPU
MEM    : $MEM
DISK   : $DISK
EOF

# NETOWRK 변수
NETINT=$(nmcli device | tail -n +2 | grep -v '^lo' | awk '{print $1}')
for i in $NETINT
do
    NIC=$i
    IP=$(nmcli device show $i | grep 'IP4.ADDRESS\[.\]:' | awk '{print $2}')
    GW=$(nmcli device show $i | grep 'IP4.ROUTE' | grep 'dst = 0.0.0.0/0,' | awk '{print $7}' | awk -F, '{print $1}')
    DNSLINE=$(nmcli device show $i | grep '^IP4.DNS' | awk '{print $2}')
    DNS=$(Paste $DNSLINE)
    cat << EOF
Network: $NIC
    IP : $IP
    GW : $GW
    DNS: $DNS
EOF
done

echo "--------------- [끝] 결과 보고서 ------------------"



