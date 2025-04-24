#!/bin/bash

# Configurações
IP="168.231.92.234"
USER="root"
APP_DIR="/var/www/sistemahubsa2"
API_DIR="/var/www/sistemahubsa2-api"

echo "Iniciando processo de deploy..."

# 1. Build do frontend
echo "Construindo frontend..."
npm run build

# 2. Copiar arquivos para a VPS
echo "Copiando arquivos para a VPS..."
scp -r dist/* $USER@$IP:$APP_DIR/

# 3. Copiar arquivos da API
echo "Copiando arquivos da API..."
scp -r src/api/* $USER@$IP:$API_DIR/
scp package.json $USER@$IP:$API_DIR/

# 4. Instalar dependências e reiniciar a API
echo "Instalando dependências e reiniciando a API..."
ssh $USER@$IP "cd $API_DIR && npm install && pm2 restart sistemahubsa2-api"

# 5. Reiniciar Nginx
echo "Reiniciando Nginx..."
ssh $USER@$IP "systemctl restart nginx"

echo "Deploy concluído com sucesso!" 