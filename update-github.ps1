# Script para atualizar o GitHub automaticamente
Write-Host "🚀 Iniciando atualização do GitHub..." -ForegroundColor Green

# Verificar se o git está instalado
try {
    $null = git --version
} catch {
    Write-Host "❌ Git não está instalado ou não está no PATH" -ForegroundColor Red
    exit 1
}

# Verificar se está em um repositório git
try {
    $null = git rev-parse --is-inside-work-tree
} catch {
    Write-Host "❌ Diretório atual não é um repositório Git" -ForegroundColor Red
    exit 1
}

# Verificar se há mudanças
$status = git status --porcelain
if ($status) {
    Write-Host "📝 Mudanças detectadas:" -ForegroundColor Yellow
    Write-Host $status

    # Adicionar todas as mudanças
    Write-Host "📦 Adicionando mudanças..." -ForegroundColor Yellow
    git add .

    # Criar commit com data e hora
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "💾 Criando commit..." -ForegroundColor Yellow
    git commit -m "feat: atualização automática em $timestamp"

    # Fazer push para o GitHub
    Write-Host "⬆️ Enviando para o GitHub..." -ForegroundColor Yellow
    git push origin master

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Atualização concluída com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "❌ Erro ao enviar para o GitHub" -ForegroundColor Red
    }
} else {
    Write-Host "ℹ️ Nenhuma mudança detectada." -ForegroundColor Blue
}

Write-Host "`nPressione qualquer tecla para sair..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null 