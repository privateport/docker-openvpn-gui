#!/bin/bash

function print_help {
cat <<EOF
Usage:
        -h | --help                     Print this help
        -p | --pphostname )     Privateport.io HOSTNAME
        -e | --ppeasyname )     Privateport.io EASYNAME
_______________________________________________
by privateport.io
EOF
}

OPTS=`getopt -o hp:e:x --long help,pphostname:,ppeasyname:,debug -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

echo #OPTS
eval set -- "$OPTS"
while true; do
  case "$1" in
        -h | --help )           print_help; exit 0; shift ;;
        -p | --pphostname )     PPHOSTNAME="$2"; shift; shift ;;
        -e | --ppeasyname )     PPEASYNAME="$2"; shift; shift ;;
        -x | --debug )          DEBUG=true; shift ;;
        -- ) shift; break ;;
        * ) break ;;
  esac
done

echo -n $PPHOSTNAME > /etc/pphostname
echo -n $PPEASYNAME > /etc/ppeasyname

if [ -z "$PPHOSTNAME" ] || [ -z "$PPEASYNAME" ]; then
	print_help
	exit 1	
fi

if [ -n "$DEBUG" ]; then
        /bin/bash
        exit 0
fi

cd /root/openvpn-webca && git pull
git clone https://github.com/privateport/openssl-utils.git /tmp/openssl-utils \
                && /tmp/openssl-utils/install.sh \
                && rm -rf /tmp/openssl-utils \
        && git clone https://github.com/privateport/openvpn-utils.git /tmp/openvpn-utils \
                && /tmp/openvpn-utils/install.sh \
                && rm -rf /tmp/openvpn-utils

cd /root/openvpn-webca
npm start
