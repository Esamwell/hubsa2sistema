#!/bin/bash

# Script para atualizar o Node.js na VPS

echo "Atualizando Node.js para a versão LTS mais recente"

# Instalar o NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Carregar o NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Instalar a versão LTS mais recente do Node.js
nvm install --lts

# Definir como padrão
nvm alias default lts/*
nvm use default

# Verificar a versão instalada
echo "Nova versão do Node.js:"
node -v

echo "Nova versão do NPM:"
npm -v

# Limpar o cache do npm
npm cache clean --force

echo "Atualização concluída! Por favor, saia e entre novamente no shell para garantir que as alterações sejam aplicadas."
echo "Em seguida, execute: cd backend && npm install && npm run build" 