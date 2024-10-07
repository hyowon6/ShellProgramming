#!/bin/bash

ApacheWebServer(){
    systemctl disable --now nginx >/dev/null 2>&1
    /root/shell/httpd.sh 
}

NiginxWebServer(){
    systemctl disable --now httpd >/dev/null 2>&1
    /root/shell/nginx.sh
}

# 사용하는 방법
Usage(){
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <httpd|nginx>"
        exit 1
    fi
}

case "$1" in
    'httpd') ApacheWebServer ;;
    'nginx') NiginxWebServer ;;
    *)       Usage           ;;
esac

