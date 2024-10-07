#!/bin/bash
# makescript.sh tools.sh
# -> /root/scripts/tools.sh
#    /#!/bin/bash
# -> chmod 700 /root/scripts/tools.sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <scriptfile>"
    exit 1
fi
SCRIPTFILE=$1
SCRIPTBASE=/root/shell

cat << EOF > $SCRIPTBASE/$SCRIPTFILE
#!/bin/bash


EOF
chmod 700 $SCRIPTBASE/$SCRIPTFILE
