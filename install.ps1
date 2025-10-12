[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Evita que o script continue se der algum erro
$ErrorActionPreference = 'Stop'

Write-Host ' Verificando Node.js...'
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error 'Node.js não está instalado. Instale antes de continuar.'
    exit 1
}

Write-Host 'Verificando npm...'
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error 'npm não está instalado. Instale Node.js completo antes de continuar.'
    exit 1
}

# Baixa o pacote zipado da aplicação
Write-Host 'Baixando app.zip...'

Invoke-WebRequest -Uri 'https://github.com/chris-works-sys/chapaci-app-dist/raw/refs/heads/main/chapaci1.0.2.zip' -OutFile 'app.zip'

# Descompacta (sobrescreve se já existir)
Write-Host 'Extraindo app.zip...'
Expand-Archive -Force -Path 'app.zip' -DestinationPath 'app'

# Vai para a pasta da aplicação
Set-Location 'app'

# Instala dependências
Write-Host 'Instalando dependências...'
npm install

# Roda a aplicação
Write-Host ' Iniciando aplicação...'
npm run start:prod

# Mantém o terminal aberto
Write-Host 'Script finalizado. Pressione Enter para sair...'
Read-Host


