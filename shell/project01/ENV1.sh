#!/bin/bash
###################
# 1. telnet 서비스
# 2. vsftpd 서비스
# 3. ?
###################

set -e 

source /root/shell/functions.sh

####################################################
# 1. telnet 서비스
# 1) 패키지 설치 - telnet-server, telnet
# 2) 서비스 기동 - telnet.socket
# 4) 방화벽 등록 - telnet
####################################################
echo "[TELNET 서비스]"
# 1) 패키지 설치 - telnet-server, telnet
PKGS="telnet-server telnet"
echo "[ Phase 01] $PKGS 패키지 설치"
PkgInstall $PKGS

# 2) 서비스 기동 - telnet.socket
SVCS="telnet.socket"
echo "[Phase 02] $SVCS 서비스 기동"
ServiceStart $SVCS

# 3) 방화벽 등록 - telnet
RULES="telnet"
echo "[Phase 03] $RULES 방화벽에 등록"
FWRule $RULES

echo 
####################################################
# 2. vsftpd 서비스
# 1) 패키지 설치 - vsftpd, ftp
# 2) 서비스 설정 - /etc/vsftpd/{ftpusers,user_list}
# 3) 서비스 기동 - vsftpd.service
# 4) 방화벽 등록 - ftp
####################################################
echo "[FTP 서비스]"
# 1) 패키지 설치 - vsftpd, ftp
PKGS="vsftpd ftp"
echo "[Phase 01] $PKGS 패키지 설치"
PkgInstall $PKGS

# 2) 서비스 설정 - /etc/vsftpd/{ftpusers,user_list}
FTPUSERS=/etc/vsftpd/ftpusers
USER_LIST=/etc/vsftpd/user_list
echo "[Phase 02] $FTPUSERS $USER_LIST 설정"
for i in $FTPUSERS $USER_LIST
do
    sed -i 's/^root/#root/' $i
done
echo "[ OK ] root 사용자 허용 설정 완료"

# 3) 서비스 기동 - vsftpd.service
SVCS="vsftpd.service"
echo "[Phase 03] $SVCS 서비스 기동"
ServiceStart $SVCS

# 4) 방화벽 등록 - ftp
RULES="ftp"
echo "[Phase 04] $RULES 방화벽에 등록"
FWRule $RULES