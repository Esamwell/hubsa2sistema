#!/bin/bash

echo "=== Iniciando implantação do Sistema HubSA ==="

# Configuração de cores para o terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar permissões
if [ "$(id -u)" != "0" ]; then
   echo -e "${RED}Este script deve ser executado como root${NC}" 
   exit 1
fi

echo -e "${YELLOW}Atualizando o sistema...${NC}"
apt update && apt upgrade -y

echo -e "${YELLOW}Instalando dependências...${NC}"
apt install -y nginx nodejs npm

# Instalando PM2 globalmente
echo -e "${YELLOW}Instalando PM2...${NC}"
npm install -g pm2

# Backend
echo -e "${YELLOW}Configurando o backend...${NC}"
cd backend
npm install
npm run build

# Iniciando o backend com PM2
echo -e "${YELLOW}Iniciando o backend...${NC}"
pm2 start dist/index.js --name hubsa-backend
pm2 save

# Frontend
echo -e "${YELLOW}Configurando o frontend...${NC}"
cd ../frontend
npm install
npm run build

# Configurando o Nginx
echo -e "${YELLOW}Configurando o Nginx...${NC}"
mkdir -p /var/www/sistemahubsa2
cp -r dist /var/www/sistemahubsa2/frontend
cp ../nginx.conf /etc/nginx/sites-available/hubsa

# Criando link simbólico
ln -sf /etc/nginx/sites-available/hubsa /etc/nginx/sites-enabled/

# Verificando configuração do Nginx
nginx -t

# Reiniciando o Nginx
systemctl restart nginx

echo -e "${GREEN}Implantação concluída com sucesso!${NC}"
echo -e "Sistema disponível em: http://$(hostname -I | awk '{print $1}')" 