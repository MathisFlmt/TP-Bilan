#!/bin/bash

# Script d'installation de Docker et Docker Compose
# ATTENTION : Ce script doit etre execute en tant que root

# Verifier si le script est execute en root
if [ "$(id -u)" -ne 0 ]; then
    echo "ERREUR : Ce script doit etre execute avec les privileges root."
    echo "Utilisation : sudo ./install_docker.sh"
    echo "Ou connectez-vous en root : su -"
    exit 1
fi

echo "Installation de Docker et Docker Compose..."

# Mettre a jour le systeme
echo "Mise a jour du systeme..."
apt update -y && apt upgrade -y

# Installer les dependances
echo "Installation des dependances..."
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release

# Ajouter la cle GPG Docker
echo "Ajout de la cle GPG Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le depot Docker
echo "Ajout du depot Docker..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker
echo "Installation de Docker..."
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io

# Installer Docker Compose
echo "Installation de Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Ajouter l'utilisateur qui a execute le script au groupe docker
if [ -n "$SUDO_USER" ]; then
    echo "Ajout de l'utilisateur '$SUDO_USER' au groupe docker..."
    usermod -aG docker "$SUDO_USER"
    echo "Note : Deconnectez-vous et reconnectez-vous pour utiliser Docker sans sudo"
fi

# Verifier les installations
echo ""
echo "Installation terminee"
echo "Versions installees :"
docker --version
docker-compose --version

echo ""
echo "Prochaines etapes :"
echo "1. Si vous avez ete ajoute au groupe docker, deconnectez-vous et reconnectez-vous"
echo "2. Tester Docker : docker run hello-world"
echo "3. Deployer les services : cd /chemin && docker-compose up -d"