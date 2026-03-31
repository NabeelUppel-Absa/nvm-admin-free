Write-Host "=== NVM Admin-Free Installer ===" -ForegroundColor Cyan

try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
} catch {
    Write-Error "Failed to set execution policy."
    exit 1
}

cd $Env:USERPROFILE;

iwr https://raw.githubusercontent.com/NabeelUppel-Absa/nvm-admin-free/main/installer.ps1 -OutFile installer.ps1


.\installer.ps1 -nvmhome $Env:USERPROFILE\nvm;

del installer.ps1
