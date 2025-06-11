# Super script de automação para GitHub
Write-Host "🚀 Iniciando automação completa do projeto..." -ForegroundColor Green

# 1. Limpeza de arquivos temporários
Write-Host "🧹 Limpando arquivos temporários..." -ForegroundColor Yellow
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue .\portfolio\dist, .\portfolio\.cache, .\portfolio\*.log

# 2. Atualização de dependências
Write-Host "📦 Atualizando dependências..." -ForegroundColor Yellow
cd portfolio
npm install

# 3. Lint
Write-Host "🔍 Rodando lint..." -ForegroundColor Yellow
npm run lint
if ($LASTEXITCODE -ne 0) { Write-Host "❌ Corrija os erros do lint antes de commitar." -ForegroundColor Red; exit 1 }

# 4. Testes
Write-Host "🧪 Rodando testes..." -ForegroundColor Yellow
npm test
if ($LASTEXITCODE -ne 0) { Write-Host "❌ Corrija os testes antes de commitar." -ForegroundColor Red; exit 1 }

# 5. Gerar documentação
Write-Host "📚 Gerando documentação..." -ForegroundColor Yellow
npm run docs

# 6. Gerar changelog
Write-Host "📝 Gerando changelog..." -ForegroundColor Yellow
npm run changelog

# 7. Backup automático
Write-Host "💾 Fazendo backup do projeto..." -ForegroundColor Yellow
cd ..
$backupDir = "backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item .\portfolio .\$backupDir -Recurse

# 8. Commit semântico e push
Write-Host "💬 Pronto para commit semântico!" -ForegroundColor Cyan
$commitMsg = Read-Host "Digite a mensagem de commit (ex: feat: nova feature)"
git add .
git commit -m "$commitMsg"
git push origin master

# 9. Notificação pós-push
Write-Host "✅ Push realizado com sucesso!" -ForegroundColor Green
try {
    Import-Module BurntToast
    New-BurntToastNotification -Text "GitHub", "Push realizado com sucesso!"
} catch {} 