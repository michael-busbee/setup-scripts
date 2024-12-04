# Windows Setup Script

This script automates the installation of common applications and development tools on a fresh Windows installation. It installs Chocolatey package manager, various applications, and Windows Subsystem for Linux (WSL 2).

## Prerequisites

- Windows 10 version 1903 or higher, with Build 18362 or higher
- Administrator access
- Active internet connection
- Windows PowerShell 5.1 or higher

## Download and Installation

1. Download the script:
   - Create a new file named `windows-setup.ps1`
   - Copy the script content into this file
   - Save it to a location you can easily access (e.g., `C:\Setup\windows-setup.ps1`)

2. Run PowerShell as Administrator:
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

3. Navigate to the script directory:
   ```powershell
   cd C:\Setup
   ```

4. Set the execution policy to allow the script to run:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process
   ```

5. Run the script:
   ```powershell
   .\windows-setup.ps1
   ```

## How It Works

The script performs the following operations in order:

1. **Administrator Check**
   - Verifies the script is running with administrator privileges
   - Exits if not running as administrator

2. **Chocolatey Installation**
   - Downloads and installs the Chocolatey package manager
   - Updates system PATH variables

3. **Application Installation**
   - Installs the following applications via Chocolatey:
     - Google Chrome
     - Evernote
     - Flameshot

4. **WSL 2 Installation**
   - Installs Windows Subsystem for Linux 2
   - Requires system restart to complete

5. **Windows Store Applications**
   - Uses WinGet to install:
     - iCloud for Windows
     - Apple Music
     - Microsoft Remote Desktop

6. **Final Steps**
   - Prompts for system restart
   - Displays completion message

## Troubleshooting

### Common Issues and Solutions

1. **"Running scripts is disabled on this system"**
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```

2. **"Chocolatey is not recognized"**
   - Close and reopen PowerShell as Administrator
   - Verify installation by running:
     ```powershell
     choco --version
     ```

3. **Windows Store App Installation Fails**
   - Ensure you're signed into the Microsoft Store
   - Run the following commands:
     ```powershell
     wsreset.exe
     ```
   - Try installing the app manually from the Store

4. **WSL 2 Installation Issues**
   - Ensure Windows is up to date
   - Enable required Windows features:
     ```powershell
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
     ```
   - Download and install the WSL2 Linux kernel update package from Microsoft

5. **Network-Related Issues**
   - Verify internet connection
   - Check if Windows Defender or antivirus is blocking the script
   - Try using a different DNS server

### Logging and Debugging

The script outputs status messages in different colors:
- Green: Success messages
- Yellow: Warning messages
- Red: Error messages

To enable detailed logging, add the `-verbose` flag when running the script:
```powershell
.\windows-setup.ps1 -verbose
```

## Customization

To add or remove applications:

1. **Chocolatey Packages**
   - Modify the `$chocoApps` array
   - Find package names at [chocolatey.org](https://chocolatey.org/packages)

2. **Windows Store Apps**
   - Modify the `$wingetApps` array
   - Find app IDs by searching in the Microsoft Store

## Support

If you encounter issues not covered in the troubleshooting section:

1. Check the Windows Event Viewer for error messages
2. Verify all prerequisites are met
3. Try running individual installation commands manually to isolate the issue
4. Ensure your Windows installation is up to date

## Notes

- Some applications may require manual configuration after installation
- A system restart is recommended after the script completes
- WSL 2 installation requires a system restart to complete
- Some Windows Store apps may require Microsoft Store login
