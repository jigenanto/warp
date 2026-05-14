FROM alpine:latest

RUN apk add --no-cache \
    bash \
    wget \
    tinyproxy

WORKDIR /app

RUN wget -O wireproxy \
https://github.com/octeep/wireproxy/releases/download/v1.0.9/wireproxy_linux_amd64 \
&& chmod +x wireproxy

COPY start.sh .
COPY warp.json .
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

RUN chmod +x start.sh

EXPOSE 8888

CMD ["/app/start.sh"]
