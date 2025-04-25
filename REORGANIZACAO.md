# Reorganização do Projeto HubSA

## Estrutura Anterior
O projeto estava organizado em uma única pasta, com frontend e backend misturados, dificultando a implantação e manutenção na VPS.

## Nova Estrutura
O projeto foi reorganizado em duas partes principais:

### Backend
- Diretório: `backend/`
- Estrutura:
  - `src/`: Código-fonte do backend
    - `routes/`: Rotas da API
    - `services/`: Serviços e utilitários
    - `index.ts`: Ponto de entrada
    - `server.ts`: Configuração do servidor Express
  - `data/`: Diretório para armazenamento dos dados
  - `package.json`: Dependências do backend
  - `tsconfig.json`: Configuração do TypeScript

### Frontend
- Diretório: `frontend/`
- Estrutura:
  - `src/`: Código-fonte do frontend
    - `app/`: Componentes principais
    - `components/`: Componentes reutilizáveis
    - `context/`: Contextos React
    - `hooks/`: Hooks personalizados
    - `lib/`: Bibliotecas e utilidades
    - `pages/`: Páginas da aplicação
    - `types/`: Definições de tipos
  - `package.json`: Dependências do frontend
  - Arquivos de configuração (Vite, TypeScript, ESLint, etc.)

## Scripts de Implantação
Foram criados scripts para facilitar o desenvolvimento e implantação:

### `dev.bat` / `dev.sh`
- Iniciam o ambiente de desenvolvimento local
- Executam o backend e frontend simultaneamente

### `deploy.sh`
- Script para implantar o sistema em uma VPS
- Configura Nginx, instala dependências, compila e inicia os serviços

## Configuração do Nginx
O arquivo `nginx.conf` foi atualizado para:
- Servir o frontend estático
- Redirecionar chamadas de API para o backend
- Configurar CORS e cache adequadamente

## Vantagens da Nova Estrutura
1. **Separação de Responsabilidades**: Backend e frontend claramente separados
2. **Implantação Simplificada**: Cada parte pode ser implantada independentemente
3. **Manutenção Facilitada**: Atualizações podem ser feitas em partes específicas
4. **Escalabilidade**: Possibilidade de escalar backend e frontend separadamente
5. **Desenvolvimento Mais Claro**: Equipes podem trabalhar separadamente em cada parte 