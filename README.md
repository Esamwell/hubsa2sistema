# Sistema HubSA

Sistema de gerenciamento desenvolvido com React, TypeScript e Node.js.

## 🚀 Tecnologias

- React 18
- TypeScript
- Vite
- Node.js
- Express
- Tailwind CSS
- Shadcn UI
- React Query
- React Router DOM

## 📋 Pré-requisitos

- Node.js 18.x ou superior
- npm ou yarn
- Git
- VPS Ubuntu 20.04 LTS
- Domínio configurado

## 🔧 Instalação em Produção

### 1. Acesso à VPS

```bash
ssh root@seu-ip-da-vps
```

### 2. Download e Configuração

1. Baixe o script de instalação:
```bash
wget https://raw.githubusercontent.com/Esamwell/sistemahubsa2/main/install.sh
```

2. **IMPORTANTE**: Configure o script antes da execução:
```bash
nano install.sh
```

3. No editor nano, você precisa alterar:
   - Seu email (procure por `seu-email@exemplo.com`)
   - URL do sistema (se necessário)
   - Salve com Ctrl+X, depois Y e Enter

4. Execute a instalação:
```bash
chmod +x install.sh
sudo ./install.sh
```

## 📁 Estrutura do Projeto

```
sistemahubsa/
├── src/
│   ├── api/          # Backend Express
│   ├── components/   # Componentes React
│   ├── pages/        # Páginas da aplicação
│   ├── context/      # Contextos React
│   ├── hooks/        # Hooks personalizados
│   ├── lib/          # Utilitários e configurações
│   └── types/        # Definições de tipos TypeScript
├── public/           # Arquivos estáticos
└── data/            # Dados da aplicação
```

## 🔒 Segurança

- Autenticação JWT
- Proteção contra CSRF
- Sanitização de inputs
- Validação de dados
- Logs de segurança

## 🛠️ Manutenção

### Logs
```bash
# Logs da aplicação
pm2 logs sistemahubsa

# Logs do Nginx
tail -f /var/log/nginx/error.log
```

### Backups
Os backups são mantidos em:
```
/var/www/sistemahubsa/backups
```

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📞 Suporte

Em caso de dúvidas ou problemas, entre em contato com o suporte técnico.

## Estrutura do Projeto

Este sistema está organizado em duas partes:

1. **Frontend**: Aplicação React com Vite
2. **Backend**: API Node.js com Express

## Instruções de Implantação na VPS

### Configuração Inicial

1. Conecte-se à sua VPS via SSH
2. Clone o repositório: `git clone <URL_DO_REPOSITORIO>`
3. Entre na pasta do projeto: `cd sistemahubsa2`

### Backend

1. Entre na pasta do backend:
   ```
   cd backend
   ```

2. Instale as dependências:
   ```
   npm install
   ```

3. Construa o projeto:
   ```
   npm run build
   ```

4. Para iniciar o servidor em produção:
   ```
   npm start
   ```

5. Para manter o servidor rodando em segundo plano, recomenda-se usar PM2:
   ```
   npm install -g pm2
   pm2 start dist/index.js --name hubsa-backend
   ```

### Frontend

1. Entre na pasta do frontend:
   ```
   cd frontend
   ```

2. Instale as dependências:
   ```
   npm install
   ```

3. Configure a URL do backend no arquivo `.env`:
   ```
   echo "VITE_API_URL=http://seu-endereco-ou-ip:3000" > .env
   ```

4. Construa o projeto:
   ```
   npm run build
   ```

5. O projeto compilado estará na pasta `dist` e pode ser servido com Nginx ou outro servidor web.

### Configuração do Nginx

1. Instale o Nginx (se ainda não estiver instalado):
   ```
   sudo apt update
   sudo apt install nginx
   ```

2. Copie o arquivo de configuração:
   ```
   sudo cp nginx.conf /etc/nginx/sites-available/hubsa
   ```

3. Crie um link simbólico:
   ```
   sudo ln -s /etc/nginx/sites-available/hubsa /etc/nginx/sites-enabled/
   ```

4. Verifique a configuração:
   ```
   sudo nginx -t
   ```

5. Reinicie o Nginx:
   ```
   sudo systemctl restart nginx
   ```

## Manutenção

### Backup dos Dados

Os dados são armazenados em arquivos JSON na pasta `backend/data`. Faça backup regularmente:

```
cp -r backend/data /caminho/do/backup/data_$(date +%Y%m%d)
```

### Atualização do Sistema

1. Pare os serviços:
   ```
   pm2 stop hubsa-backend
   ```

2. Atualize o código:
   ```
   git pull
   ```

3. Reconstrua e reinicie:
   ```
   cd backend
   npm install
   npm run build
   pm2 restart hubsa-backend

   cd ../frontend
   npm install
   npm run build
   ```

4. Reinicie o Nginx:
   ```
   sudo systemctl restart nginx
   ```
