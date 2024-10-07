#!/bin/bash

# 중간에 하나라도 실행 안되면 진행 멈춤
set -e 

###############################################
# 계획
# 1) 패키지 설치 - httpd, mod_ssl
# 2) 웹서비스 설정 - /var/www/html/index.html
# 3) 웹서비스 기동 - httpd.service
# 4) 방화벽에 등록 - http, https
###############################################

#
# The file(functions.sh) load
# 현재 쉘에서 실행하는 거니까 . 아니면 source 붙여주기
#
. /root/shell/functions.sh

#
# Main function
#

# 1) 패키지 설치 - nginx
echo ; echo "[Phase 01] 패키지 설치"
PkgInstall nginx

# 2) 웹서비스 설정 - /usr/share/nginx/html/index.html
echo ; echo "[Phase 02] 웹서비스 설정"
RandomIndex "/usr/share/nginx/html/index.html" "My NGINX Web Server"
echo "[ OK ] 랜덤 웹페이지가 정상적으로 생성되었습니다."

# 3) 웹서비스 기동 - nginx.service
echo ; echo "[Phase 03] 웹서비스 기동"
ServiceStart nginx.service

# 4) 방화벽에 등록 - http, https
echo ; echo "[Phase 04] 방화벽 등록"
FWRule http 


