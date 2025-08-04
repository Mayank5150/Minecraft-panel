# Update your system
apt update && apt upgrade -y

# Install dependencies
apt install -y python3 python3-venv python3-pip libffi-dev libssl-dev git

# Create a user for crafty
useradd -m -s /bin/bash crafty

# Switch to crafty user
sudo -u crafty -i bash <<'EOF'
cd ~

# Clone Crafty repo
git clone https://github.com/crafty-controller/crafty.git

cd crafty

# Setup python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Crafty requirements
pip install -r requirements.txt

# Exit crafty user shell
deactivate
EOF

# Create a systemd service to run Crafty
cat >/etc/systemd/system/crafty.service <<EOF
[Unit]
Description=Crafty Controller Service
After=network.target

[Service]
Type=simple
User=crafty
WorkingDirectory=/home/crafty/crafty
ExecStart=/home/crafty/crafty/venv/bin/python3 /home/crafty/crafty/crafty.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Crafty
systemctl daemon-reload
systemctl enable crafty
systemctl start crafty

echo "🎉 Crafty Controller installed! Open your panel at: http://your-server-ip:8000"
