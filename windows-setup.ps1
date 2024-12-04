# Requires running PowerShell as Administrator
# Check if script is running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator" -ForegroundColor Red
    Exit
}

# Install Chocolatey
Write-Host "Installing Chocolatey..." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Install Chocolatey packages
Write-Host "Installing applications via Chocolatey..." -ForegroundColor Green
$chocoApps = @(
    "googlechrome"
    "evernote"
    "flameshot"
)

foreach ($app in $chocoApps) {
    Write-Host "Installing $app..." -ForegroundColor Yellow
    choco install $app -y
}

# Install WSL 2
Write-Host "Installing WSL 2..." -ForegroundColor Green
wsl --install

# Install Windows Store Apps using WinGet
Write-Host "Installing Windows Store applications..." -ForegroundColor Green
$wingetApps = @(
    "9PKTQ5699M62" # iCloud
    "9PJXNHCX8BH1" # Apple Music
    "9WZDNCRFJ3PS" # Microsoft Remote Desktop
)

foreach ($app in $wingetApps) {
    Write-Host "Installing Windows Store app: $app" -ForegroundColor Yellow
    winget install --id=$app --accept-package-agreements --accept-source-agreements
}

# Final message
Write-Host "`nSetup completed!" -ForegroundColor Green
Write-Host "Note: Some applications may require a system restart to complete installation." -ForegroundColor Yellow
Write-Host "WSL 2 installation will complete after system restart." -ForegroundColor Yellow

# Prompt for restart
$restart = Read-Host "Would you like to restart your computer now? (y/n)"
if ($restart -eq 'y') {
    Restart-Computer -Force
}
