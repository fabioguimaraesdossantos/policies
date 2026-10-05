#!/bin/bash
set -e

echo "=== 1. Atualizando repositórios e instalando dependências ==="
sudo apt update
sudo apt install -y python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential tzdata

echo "=== 2. Criando utilizador e diretórios ==="
if ! id -u homeassistant >/dev/null 2>&1; then
    sudo useradd -rm homeassistant -G dialout,gpio,i2c
fi
sudo mkdir -p /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant

echo "=== 3. Criando ambiente virtual e instalando Home Assistant ==="
sudo -u homeassistant -H bash -c '
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install --upgrade pip setuptools wheel
pip install homeassistant
'

echo "=== Instalação concluída com sucesso! ==="
echo "Para iniciar o Home Assistant, execute:"
echo "sudo -u homeassistant -H -s"
echo "cd /srv/homeassistant && source bin/activate && hass"
