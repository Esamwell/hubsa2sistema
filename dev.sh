#!/bin/bash

# Configuração de cores para o terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Iniciando ambiente de desenvolvimento HubSA ===${NC}"

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}Node.js não encontrado. Por favor, instale o Node.js para continuar.${NC}"
    exit 1
fi

# Instalando dependências
echo -e "${YELLOW}Instalando dependências do backend...${NC}"
cd backend
npm install

echo -e "${YELLOW}Instalando dependências do frontend...${NC}"
cd ../frontend
npm install

# Iniciar o backend em um terminal
echo -e "${BLUE}Iniciando o backend...${NC}"
cd ../backend
START_BACKEND="npm run dev"
if command -v gnome-terminal &> /dev/null; then
    gnome-terminal -- bash -c "$START_BACKEND; exec bash"
elif command -v xterm &> /dev/null; then
    xterm -e "$START_BACKEND; exec bash" &
elif command -v cmd.exe &> /dev/null; then
    # Windows
    start cmd.exe /k "cd backend && npm run dev"
else
    echo -e "${YELLOW}Não foi possível abrir um novo terminal. Iniciando em background.${NC}"
    cd ../backend
    npm run dev &
fi

# Iniciar o frontend
echo -e "${BLUE}Iniciando o frontend...${NC}"
cd ../frontend
npm run dev 