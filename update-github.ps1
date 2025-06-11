# Script para atualizar o GitHub automaticamente
Write-Host "🚀 Iniciando atualização do GitHub..." -ForegroundColor Green

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

    Write-Host "✅ Atualização concluída com sucesso!" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Nenhuma mudança detectada." -ForegroundColor Blue
}

Write-Host "`nPressione qualquer tecla para sair..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 