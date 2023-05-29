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

mitmweb  --web-host 0.0.0.0 -s /app/curl.py
