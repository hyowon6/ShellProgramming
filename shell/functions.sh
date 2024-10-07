#  이 파일을 httpd 에서 로딩해서 사용

# 패키지 설치 함수 - Pkginstall
# -q : quit 과정 안보이는
# ""로 묶으면 하나로 인식

PkgInstall(){
    PKGLIST="$*"
    yum -q -y install $PKGLIST
    [ $? -eq 0 ] \
        && echo "[ OK ] $PKGLIST 설치 완료" \
        || echo "[ Fail ] $PKGLIST 설치 실패" 
}

RandomIndex() {
    INDEXFILE="$1"
    MESSAGES="$2"
    FILE1=/root/shell/boxlist2
    MAX=$(wc -l < $FILE1) # MAX=72

    # 1번부터 MAX 값까지
    RANDNUM=$(($RANDOM% $MAX+1))

    # FILE1에서 랜덤하게 뽑아내겠다
    BOXSTR=$(sed -n "${RANDNUM}p" "$FILE1")
    cat << EOF > "$INDEXFILE"
<pre>
$(echo "$MESSAGES" | boxes -d "$BOXSTR")
</pre>
EOF
}

ServiceStart(){
    SVC="$1"
    systemctl restart "$SVC" >/dev/null 2>&1
    RET=$(systemctl is-active "$SVC")
    if [ "$RET" = 'active' ]; then
        echo "[ OK ] 정상적으로 $SVC 서비스가 실행"
        systemctl enable "$SVC" >/dev/null 2>&1
    else
        echo "[Fail] $SVC 서비스가 실행 실패"
    fi
}

FWRule() {
    RULES="$*"          # http https -> {http,https}
    FWCMD='firewall-cmd --permanent'
    # 기존에 있는 거에 하나씩 추가
    for i in $RULES
    do 
        FWCMD="$FWCMD --add-service=${i}"
    done
    $FWCMD >/dev/null 2>&1
    firewall-cmd --reload >/dev/null 2>&1
    echo "[ OK ] $* 방화벽에 등록 완료"
}

function print_good () {
    echo -e "\x1B[01;32m[+]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[-]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[*]\x1B[0m $1"
}