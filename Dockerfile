FROM golang:1.26-alpine

RUN apk add --no-cache \
    bash \
    curl \
    wget \
    git \
    wireguard-tools

WORKDIR /app

# Install wgcf
RUN wget -O wgcf \
https://github.com/ViRb3/wgcf/releases/download/v2.2.26/wgcf_2.2.26_linux_amd64 \
&& chmod +x wgcf

# Install wireproxy
RUN GOTOOLCHAIN=auto go install github.com/windtf/wireproxy/cmd/wireproxy@v1.1.2

RUN find / -name wireproxy -type f | head -n 1 | xargs -I {} cp {} /app/wireproxy \
&& chmod +x /app/wireproxy

# Copy start script
COPY start.sh .

RUN sed -i 's/\r$//' /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8888

CMD ["sh", "/app/start.sh"]
