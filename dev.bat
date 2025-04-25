@echo off
echo === Iniciando ambiente de desenvolvimento HubSA ===

REM Verificar se o Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js nao encontrado. Por favor, instale o Node.js para continuar.
    exit /b
)

echo Instalando dependencias do backend...
cd backend
call npm install

echo Instalando dependencias do frontend...
cd ..\frontend
call npm install

echo Iniciando o backend...
start cmd /k "cd ..\backend && npm run dev"

echo Iniciando o frontend...
cd ..\frontend
npm run dev 