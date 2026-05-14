FROM golang:1.26-alpine

RUN apk add --no-cache \
    bash \
    curl \
    wget \
    git \
    tinyproxy \
    wireguard-tools

WORKDIR /app

RUN wget -O wgcf \
https://github.com/ViRb3/wgcf/releases/download/v2.2.26/wgcf_2.2.26_linux_amd64 \
&& chmod +x wgcf

RUN go install github.com/pufferffish/wireproxy/cmd/wireproxy@latest

RUN cp /root/go/bin/wireproxy /app/wireproxy \
&& chmod +x /app/wireproxy

COPY start.sh .
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

RUN chmod +x start.sh

EXPOSE 8888

CMD ["/app/start.sh"]
