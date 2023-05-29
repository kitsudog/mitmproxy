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
OPTION="-s /app/curl.py --set keep_host_header=true --showhost"
if [[ $MODE = "reverse" ]];then
    mitmweb  --web-host 0.0.0.0 $OPTION --mode reverse:$UPSTREAM
else
    mitmweb  --web-host 0.0.0.0 $OPTION --mode regular
fi
