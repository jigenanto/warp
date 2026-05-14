#!/bin/sh

cd /app

echo "Registering WARP..."

yes | ./wgcf register

echo "Generating profile..."

./wgcf generate

echo "Starting wireproxy..."

./wireproxy --config wgcf-profile.conf &

sleep 5

echo "Starting tinyproxy..."

tinyproxy -d
