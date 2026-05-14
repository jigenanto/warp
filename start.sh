#!/bin/sh

cd /app

echo "Registering WARP..."

yes | ./wgcf register

echo "Generating profile..."

./wgcf generate

PRIVATE_KEY=$(grep PrivateKey wgcf-profile.conf | awk '{print $3}')
PUBLIC_KEY=$(grep PublicKey wgcf-profile.conf | awk '{print $3}')

cat > warp.json <<EOF
{
  "bind_address": "127.0.0.1:1080",
  "workers": 1,
  "local_dns": false,
  "ipv6": false,
  "peers": [
    {
      "public_key": "$PUBLIC_KEY",
      "endpoint": "engage.cloudflareclient.com:2408",
      "keepalive": 25,
      "allowed_ips": [
        "0.0.0.0/0"
      ]
    }
  ],
  "interface": {
    "private_key": "$PRIVATE_KEY",
    "addresses": [
      "172.16.0.2/32"
    ]
  }
}
EOF

echo "Starting wireproxy..."

./wireproxy -c warp.json &

sleep 5

echo "Starting tinyproxy..."

tinyproxy -d
