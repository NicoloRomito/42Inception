# 🐳 Docker & Docker Compose Installation Guide (Ubuntu/Debian)

This guide explains how to install **Docker** and **Docker Compose (plugin version)** properly on Ubuntu or Debian-based systems.

---

## ✅ Prerequisites

Ensure your system is up to date:

```bash
sudo apt update && sudo apt upgrade -y
```

## 🧹 Uninstall Old Versions
```bash
sudo apt remove docker docker-engine docker.io containerd runc
```

## 📦 Install Required Packages
```bash
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

## 🔑 Add Docker’s Official GPG Key
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

## 📚 Set Up the Docker Repository
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## 🛠 Install Docker Engine & Compose Plugin
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## 🧪 Verify Installation
```bash
sudo docker run hello-world
```

## 👤 (Optional) Run Docker Without sudo
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker  # or log out and back in
```
Then test:
```bash
docker ps
```

## 🧩 Check Docker Compose
```bash
docker compose version
```

## Create docker volume directories
```bash
sudo rm -rf /home/nromito/data  # Only if you want a clean slate
sudo mkdir -p /home/nromito/data/wordpress /home/nromito/data/mariadb
sudo chown -R $USER:$USER /home/nromito/data
```
