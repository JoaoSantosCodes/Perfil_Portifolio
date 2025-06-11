# Script para atualizar o GitHub automaticamente
Write-Host "🚀 Iniciando atualização do GitHub..." -ForegroundColor Green

# Função para verificar se o comando git está disponível
function Test-GitCommand {
    try {
        $null = git --version
        return $true
    }
    catch {
        Write-Host "❌ Git não está instalado ou não está no PATH" -ForegroundColor Red
        return $false
    }
}

# Função para verificar se o repositório está configurado
function Test-GitRepository {
    try {
        $null = git rev-parse --is-inside-work-tree
        return $true
    }
    catch {
        Write-Host "❌ Diretório atual não é um repositório Git" -ForegroundColor Red
        return $false
    }
}

# Verificar pré-requisitos
if (-not (Test-GitCommand)) { exit 1 }
if (-not (Test-GitRepository)) { exit 1 }

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
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 