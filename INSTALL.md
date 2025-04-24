# Instalação do Sistema HubSA2 na VPS

## Pré-requisitos
- Ubuntu 20.04 ou superior
- Node.js 18.x ou superior
- Nginx
- PM2

## Passos de Instalação

1. Instalar Node.js e NPM:
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

2. Instalar Nginx:
```bash
sudo apt update
sudo apt install nginx
```

3. Instalar PM2 globalmente:
```bash
sudo npm install -g pm2
```

4. Criar diretórios necessários:
```bash
sudo mkdir -p /var/www/sistemahubsa2
sudo mkdir -p /var/www/sistemahubsa2-api
```

5. Configurar Nginx:
```bash
sudo cp nginx.conf /etc/nginx/sites-available/sistemahubsa2
sudo ln -s /etc/nginx/sites-available/sistemahubsa2 /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

6. Instalar SSL com Let's Encrypt:
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d sistema.hubsa2.com.br -d api.hubsa2.com.br
```

7. Configurar PM2 para a API:
```bash
cd /var/www/sistemahubsa2-api
npm install
pm2 start npm --name "sistemahubsa2-api" -- start
pm2 save
pm2 startup
```

## Configuração de Firewall
```bash
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 22
sudo ufw enable
```

## Manutenção
- Para atualizar o sistema, use o script `deploy.sh`
- Para verificar logs da API: `pm2 logs sistemahubsa2-api`
- Para verificar logs do Nginx: `sudo tail -f /var/log/nginx/error.log` 