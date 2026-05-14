FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    wget \
    tinyproxy \
    wireguard-tools

WORKDIR /app

RUN wget -O wgcf \
https://github.com/ViRb3/wgcf/releases/download/v2.2.26/wgcf_2.2.26_linux_amd64 \
&& chmod +x wgcf

RUN wget -O wireproxy \
https://github.com/octeep/wireproxy/releases/download/v1.0.9/wireproxy_linux_amd64 \
&& chmod +x wireproxy

COPY start.sh .
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

RUN chmod +x start.sh

EXPOSE 8888

CMD ["/app/start.sh"]
