#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa
DIR="mo_miner"

# 1. Clean up
killall -9 xmrig 2>/dev/null
rm -rf "$DIR" && mkdir -p "$DIR" && cd "$DIR"

# 2. Download
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" | tar xz --strip-components=1

# 3. Launch with "Hardcoded" Threading
# Since your Xeon has 64 threads, we will force it to use 16 threads.
# This bypasses the hardware discovery crash entirely.
# -t 16: Use exactly 16 threads (Safe for a 64-thread CPU)
# --randomx-mode=light: Keeps RAM at 256MB
# --cpu-no-yield: Helps with stability on some hosts
./xmrig -o gulf.moneroocean.stream:10128 -u $WALLET -p direct-bash -t 16 --randomx-mode=light --cpu-no-yield -B

echo "SUCCESS: Miner started with manual thread override."