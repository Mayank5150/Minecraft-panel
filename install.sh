#!/bin/bash

# 1. Update your system
apt update && apt upgrade -y

# 2. Install dependencies
apt install -y build-essential git curl wget python3 python3-pip openjdk-17-jre-headless

# 3. Install Node.js (LTS version required for MineOS)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# 4. Create a user for MineOS
adduser --disabled-login mineos

# 5. Clone MineOS as root
cd /opt
git clone https://github.com/hexparrot/mineos-node.git

# 6. Change ownership to mineos user
chown -R mineos:mineos /opt/mineos-node

# 7. Switch to mineos user and install node dependencies
sudo -u mineos bash -c "
  cd /opt/mineos-node
  npm install
  npm run build
"

# 8. Copy and enable systemd service
cp /opt/mineos-node/mineos.service /etc/systemd/system/

# 9. Enable and start MineOS
systemctl daemon-reload
systemctl enable mineos
systemctl start mineos

echo "✅ MineOS should now be installed and running!"
echo "🔗 Access it at: https://<your-server-ip>:8443"
