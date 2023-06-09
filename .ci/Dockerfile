FROM mitmproxy/mitmproxy:9.0.1
RUN apt-get update \
    && apt-get install -y --no-install-recommends procps curl nginx tcpdump telnet \
    && rm -rf /var/lib/apt/lists/*
COPY app /app
COPY ca /home/mitmproxy/.mitmproxy
ENV MITMPROXY_PATH=/home/mitmproxy/.mitmproxy \
    MODE=regular \
    FLOW_NUMBER=100 \
    UPSTREAM=http://127.0.0.1:8080 \
    TZ=Asia/Shanghai
CMD ["gosu", "mitmproxy", "/app/start.sh"]
