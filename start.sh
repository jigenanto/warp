#!/bin/sh

cd /app

echo "Registering WARP..."
yes | ./wgcf register

echo "Generating profile..."
./wgcf generate

echo "Adding HTTP proxy config..."

cat >> wgcf-profile.conf <<EOF

[http]
BindAddress = 0.0.0.0:8888
EOF

echo "Starting wireproxy..."

./wireproxy --config wgcf-profile.conf
