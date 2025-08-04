#!/bin/bash
# MineOS install script

# 1. Update your system
apt update && apt upgrade -y

# 2. Install dependencies
apt install -y build-essential git curl wget python3 python3-pip openjdk-17-jre-headless

# 3. Install Node.js (LTS version required for MineOS)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# 4. Create a user for MineOS
adduser --disabled-login mineos

# 5. Switch to that user and install MineOS
su - mineos -c "
  git clone https://github.com/hexparrot/mineos-node.git &&
  cd mineos-node &&
  npm install &&
  npm run build
"

# 6. Setup systemd service
cp /home/mineos/mineos-node/mineos.service /etc/systemd/system/

# 7. Enable and start MineOS
systemctl daemon-reexec
systemctl enable mineos
systemctl start mineos
