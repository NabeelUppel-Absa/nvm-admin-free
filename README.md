## Installation (Admin‑Free)

Open **PowerShell** and run the following commands **exactly as shown**.

### Step 1: Change to your user directory
```powershell
cd $Env:USER
```

### Step 2: Allow script execution in the current session
```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
```

### Step 3: Download the installer script
```powershell
Invoke-WebRequest https://raw.githubusercontent.com/NabeelUppel-Absa/nvm-admin-free/main/installer.ps1 -OutFile installer.ps1;
```
Note:
This might fail the first time around. If it does, simply run it again.

### Step 4: Run the installer
```powershell
.\installer.ps1 -nvmhome $Env:USERPROFILE\nvm;
```

### Step 5: Clean up
```powershell
del installer.ps1
```

<br>

## Verify Installation
```powershell
nvm -v
```

<br>

## Installing and Using Node.js
### Install a Node.js version
```powershell
nvm install 14.21.3
```

### Use the installed version
```powershell
nvm use 14.21.3
```

### Verify Node.js is active
```powershell
node -v
```

<br>

## Credit
https://github.com/jchip/nvm?tab=readme-ov-file#installing-universal-nvm-on-windows-using-powershell
