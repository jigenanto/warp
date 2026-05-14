#!/bin/sh

cd /app

echo "Registering WARP..."

yes | ./wgcf register

echo "Generating profile..."

./wgcf generate

echo "Starting wireproxy..."

./wireproxy --config wgcf-profile.conf &

sleep 5

echo "Creating tinyproxy config..."

cat > /tmp/tinyproxy.conf <<EOF
Port 8888
Timeout 600
LogLevel Info
EOF

echo "Starting tinyproxy..."

tinyproxy -d -c /tmp/tinyproxy.conf
