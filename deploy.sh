#!/bin/bash

echo "=== Iniciando implantação do Sistema HubSA ==="

# Configuração de cores para o terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# IP da VPS
VPS_IP="168.231.92.234"
FRONTEND_DOMAIN="sistema.hubsa2.com.br"
BACKEND_DOMAIN="api.hubsa2.com.br"

# Verificar permissões
if [ "$(id -u)" != "0" ]; then
   echo -e "${RED}Este script deve ser executado como root${NC}" 
   exit 1
fi

echo -e "${YELLOW}Atualizando o sistema...${NC}"
apt update && apt upgrade -y

echo -e "${YELLOW}Instalando dependências...${NC}"
apt install -y nginx nodejs npm certbot python3-certbot-nginx

# Instalando PM2 globalmente
echo -e "${YELLOW}Instalando PM2...${NC}"
npm install -g pm2

# Backend
echo -e "${YELLOW}Configurando o backend...${NC}"
cd backend
npm install
npm run build

# Criando o diretório de dados
mkdir -p data

# Iniciando o backend com PM2
echo -e "${YELLOW}Iniciando o backend...${NC}"
pm2 start dist/index.js --name hubsa-backend
pm2 save

# Frontend
echo -e "${YELLOW}Configurando o frontend...${NC}"
cd ../frontend

# Criar arquivo .env.production com a URL da API
echo -e "${YELLOW}Configurando variáveis de ambiente...${NC}"
echo "VITE_API_URL=http://${BACKEND_DOMAIN}" > .env.production

npm install
npm run build

# Configurando o Nginx
echo -e "${YELLOW}Configurando o Nginx...${NC}"
mkdir -p /var/www/sistemahubsa2/frontend
cp -r dist /var/www/sistemahubsa2/frontend
cp ../nginx.conf /etc/nginx/sites-available/hubsa

# Criando link simbólico
ln -sf /etc/nginx/sites-available/hubsa /etc/nginx/sites-enabled/

# Verificando configuração do Nginx
nginx -t

# Reiniciando o Nginx
systemctl restart nginx

# Configurar SSL com Certbot
echo -e "${YELLOW}Configurando SSL com Certbot...${NC}"
certbot --nginx -d ${FRONTEND_DOMAIN} -d ${BACKEND_DOMAIN} --non-interactive --agree-tos --email admin@hubsa2.com.br

echo -e "${GREEN}Implantação concluída com sucesso!${NC}"
echo -e "Frontend disponível em: https://${FRONTEND_DOMAIN}"
echo -e "Backend disponível em: https://${BACKEND_DOMAIN}"
echo -e "IP da VPS: ${VPS_IP}" 