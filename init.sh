#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
DIR=$HOME/moneroocean

# 1. Clean and Prepare
killall -9 xmrig 2>/dev/null
rm -rf $DIR && mkdir -p $DIR && cd $DIR

# 2. Grab the latest portable miner
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" | tar xz --strip-components=1

# 3. Launch with parameters (No config file)
# --cpu-max-threads-hint=50: Capped at 50% CPU
# --randomx-mode=light: Minimal RAM usage (prevents "Killed" error)
# -o: Pool / -u: Wallet / -p: WorkerName / -B: Run in Background
./xmrig -o gulf.moneroocean.stream:10128 -u $WALLET -p direct-bash --cpu-max-threads-hint=50 --randomx-mode=light -B

echo "Miner launched on $(nproc) threads at 50% capacity."
