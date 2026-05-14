#!/bin/sh

echo "Starting WARP..."
/app/wireproxy -c /app/warp.json &

sleep 5

echo "Starting TinyProxy..."
tinyproxy -d
