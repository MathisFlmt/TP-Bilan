# TP - Bilan

## Objectif
Ce projet déploie automatiquement une infrastructure complète avec :
- **WordPress** : CMS pour créer et gérer un site web
- **Zabbix** : Solution de monitoring réseau et serveur

## Installation rapide
1. Cloner le dépôt : `git clone `
2. Installer Docker : `./install_docker.sh`
3. Démarrer les services : `docker-compose up -d`

## 🌐 Accès
- WordPress : http://IP_SERVEUR:8080
- Zabbix : http://IP_SERVEUR:8081 (Admin/zabbix)

## 📁 Structure
- `install_docker.sh` : Script d'installation Docker
- `docker-compose.yml` : Configuration des services
