#!/bin/bash

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🔐 Installing SSH server..."
sudo apt install -y openssh-server

echo "🛡️ Installing security tools..."
sudo apt install -y ufw fail2ban

echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "🌐 Installing ngrok..."
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null

echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
| sudo tee /etc/apt/sources.list.d/ngrok.list

sudo apt update
sudo apt install -y ngrok

echo "🔥 Configuring firewall..."
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable

echo "🧱 Enabling fail2ban..."
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "✅ Setup complete!"
