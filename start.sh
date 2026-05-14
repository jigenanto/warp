#!/bin/sh

cd /app

echo "Registering WARP..."

yes | ./wgcf register

echo "Generating profile..."

./wgcf generate

cat > warp.conf <<EOF
[Interface]
PrivateKey = $(grep PrivateKey wgcf-profile.conf | cut -d ' ' -f3)
Address = 172.16.0.2/32

[Peer]
PublicKey = $(grep PublicKey wgcf-profile.conf | cut -d ' ' -f3)
AllowedIPs = 0.0.0.0/0
Endpoint = engage.cloudflareclient.com:2408
EOF

cat > warp.json <<EOF
{
  "bind_address": "127.0.0.1:1080",
  "workers": 1,
  "local_dns": false,
  "ipv6": false,
  "peers": [
    {
      "public_key": "$(grep PublicKey wgcf-profile.conf | cut -d ' ' -f3)",
      "endpoint": "engage.cloudflareclient.com:2408",
      "keepalive": 25,
      "allowed_ips": [
        "0.0.0.0/0"
      ]
    }
  ],
  "interface": {
    "private_key": "$(grep PrivateKey wgcf-profile.conf | cut -d ' ' -f3)",
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
