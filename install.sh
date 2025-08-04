# 1. Update your system
apt update && apt upgrade -y

# 2. Install dependencies
apt install -y build-essential git curl wget python3 python3-pip openjdk-17-jre-headless

# 3. Install Node.js (LTS version required for MineOS)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# 4. (In Codespaces: skip creating a new user, install directly instead)
# adduser --disabled-login mineos
# su - mineos

# 5. Clone the MineOS Node web UI
git clone https://github.com/hexparrot/mineos-node.git /opt/mineos-node

# 6. Enter the folder
cd /opt/mineos-node

# 7. Install Node.js dependencies
npm install

# 8. Build the web UI
npm run build

# 9. (In a real VPS/server, you'd do:)
# cp /home/mineos/mineos-node/mineos.service /etc/systemd/system/
# systemctl daemon-reexec
# systemctl enable mineos
# systemctl start mineos

# 10. But in Codespaces/systemd-less environments, start manually:
node service.js
