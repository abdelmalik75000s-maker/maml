#!/bin/bash
# MoneroOcean Setup - FORCED START (Skips Benchmarks)
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
DIR=$HOME/moneroocean

# 1. Kill the stuck process
killall -9 xmrig 2>/dev/null

# 2. Clean and Download
rm -rf $DIR
mkdir -p $DIR
curl -L "https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/xmrig.tar.gz" -o /tmp/xmrig.tar.gz
tar xf /tmp/xmrig.tar.gz -C $DIR
rm /tmp/xmrig.tar.gz

# 3. Create the "Liar" Config
# We inject "algo-perf" so XMRig thinks calibration is done.
# We cap threads at 50% so the web server doesn't freeze again.
cat >$DIR/config.json <<EOL
{
    "autosave": true,
    "donate-level": 1,
    "cpu": {
        "enabled": true,
        "max-threads-hint": 50
    },
    "algo-perf": {
        "rx/0": 44000
    },
    "pools": [
        {
            "algo": "rx/0",
            "url": "gulf.moneroocean.stream:10128",
            "user": "$WALLET",
            "pass": "fixed-start",
            "keepalive": true,
            "tls": false
        }
    ],
    "log-file": "$DIR/xmrig.log"
}
EOL

# 4. Launch with Nohup
cd $DIR
nohup ./xmrig -c config.json > /dev/null 2>&1 &

echo "SUCCESS: Miner started. Benchmarks bypassed."