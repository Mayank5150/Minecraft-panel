# 1. Update your system
apt update && apt upgrade -y

# 2. Install dependencies
apt install -y build-essential git curl wget python3 python3-pip openjdk-17-jre-headless

# 3. Install Node.js (LTS version required for MineOS)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# 4. Create a user for MineOS
adduser --disabled-login mineos

# 5. Switch to that user
su - mineos

# 6. Clone the MineOS Node web UI
git clone https://github.com/hexparrot/mineos-node.git

# 7. Enter the folder
cd mineos-node

# 8. Install Node.js dependencies
npm install

# 9. Build the web UI
npm run build

# 10. Exit back to root
exit

# 11. Setup systemd service
cp /home/mineos/mineos-node/mineos.service /etc/systemd/system/

# 12. Enable and start MineOS
systemctl daemon-reexec
systemctl enable mineos
systemctl start mineos
