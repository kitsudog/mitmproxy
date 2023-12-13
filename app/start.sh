#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace
cat <<EOF
# please load CA cert [START]
$(cat /home/mitmproxy/.mitmproxy/mitmproxy-ca-cert.pem)
# please load CA cert [OVER]
EOF
if [ $VERBOSE = TRUE ];then
  PARAMS="-s /app/curl.py ${PARAMS:-}"
fi 
PARAMS="-s /app/keep.py --set keep_host_header=true --showhost ${PARAMS:-}"
OPTIONS="--set view_order_reversed=true ${OPTIONS:-}"
nginx -c /app/nginx.conf
set -x
if [[ $MODE = "reverse" ]];then
    mitmweb  --web-host 0.0.0.0 --web-port 8082 $PARAMS $OPTIONS --set "view_filter=${FILTER:-}" --mode reverse:$UPSTREAM 
elif [[ $MODE = "upstream" ]];then
    mitmweb  --web-host 0.0.0.0 --web-port 8082 $PARAMS $OPTIONS --set "view_filter=${FILTER:-}" --mode upstream:$UPSTREAM
else
    mitmweb  --web-host 0.0.0.0 --web-port 8082 $PARAMS $OPTIONS --set "view_filter=${FILTER:-}" --mode regular
fi
