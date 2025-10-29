# Quick Install All Tools Script for AI Workshop
# This script installs ALL required tools without prompting
# USE WITH CAUTION - This will install multiple applications

#Requires -RunAsAdministrator

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " AI Workshop - Quick Install All Tools" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "WARNING: This script will install ALL required tools for the AI workshop." -ForegroundColor Yellow
Write-Host "This includes: Git, Java JDK 17, Maven, Python 3.12, Node.js, VS Code" -ForegroundColor Yellow
Write-Host "`nExisting installations will be preserved (not overwritten)." -ForegroundColor Cyan
Write-Host "`nThis may take 10-15 minutes depending on your internet connection.`n" -ForegroundColor Cyan

$confirmation = Read-Host "Do you want to proceed? (Type 'YES' in capital letters to confirm)"

if ($confirmation -ne 'YES') {
    Write-Host "`nInstallation cancelled." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "`nStarting installation...`n" -ForegroundColor Green

# Check if winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: winget (Windows Package Manager) is not available." -ForegroundColor Red
    Write-Host "Please update Windows or install App Installer from Microsoft Store." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit
}

$installCount = 0
$skipCount = 0
$errorCount = 0

# Function to install a package
function Install-Package {
    param(
        [string]$Name,
        [string]$WingetId,
        [string]$CheckCommand
    )
    
    Write-Host "[$($installCount + $skipCount + $errorCount + 1)] Installing $Name..." -ForegroundColor Yellow
    
    # Check if already installed
    if ($CheckCommand) {
        try {
            Invoke-Expression "$CheckCommand" 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ $Name is already installed. Skipping." -ForegroundColor Green
                $script:skipCount++
                return
            }
        } catch {
            # Command not found, proceed with installation
        }
    }
    
    # Install the package
    Write-Host "  Installing $Name..." -ForegroundColor Cyan
    try {
        $output = winget install --id $WingetId -e --source winget --silent --accept-package-agreements --accept-source-agreements 2>&1
        
        if ($LASTEXITCODE -eq 0 -or $output -match "successfully installed" -or $output -match "No applicable update found") {
            Write-Host "  ✓ $Name installed successfully" -ForegroundColor Green
            $script:installCount++
        } else {
            Write-Host "  ⚠ $Name installation completed with warnings" -ForegroundColor Yellow
            $script:installCount++
        }
    } catch {
        Write-Host "  ✗ Failed to install $Name" -ForegroundColor Red
        Write-Host "    Error: $_" -ForegroundColor Red
        $script:errorCount++
    }
    
    Start-Sleep -Seconds 1
}

# Install all tools
Write-Host "`nInstalling required tools...`n" -ForegroundColor Cyan

Install-Package -Name "Git" -WingetId "Git.Git" -CheckCommand "git --version"
Install-Package -Name "Java JDK 17" -WingetId "Microsoft.OpenJDK.17" -CheckCommand "java -version"
Install-Package -Name "Maven" -WingetId "Apache.Maven" -CheckCommand "mvn -version"
Install-Package -Name "Python 3.12" -WingetId "Python.Python.3.12" -CheckCommand "python --version"
Install-Package -Name "Node.js LTS" -WingetId "OpenJS.NodeJS.LTS" -CheckCommand "node --version"
Install-Package -Name "Visual Studio Code" -WingetId "Microsoft.VisualStudioCode" -CheckCommand "code --version"

# Optional: Docker Desktop
Write-Host "`n[Optional] Docker Desktop" -ForegroundColor Yellow
Write-Host "Docker Desktop requires manual download and installation." -ForegroundColor Cyan
Write-Host "Download from: https://www.docker.com/products/docker-desktop" -ForegroundColor Cyan

$dockerResponse = Read-Host "`nWould you like to open the Docker Desktop download page? (Y/N)"
if ($dockerResponse -eq 'Y' -or $dockerResponse -eq 'y') {
    Start-Process "https://www.docker.com/products/docker-desktop"
}

# Install Python packages
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " Installing Python Packages" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Wait a bit for Python to be available
Start-Sleep -Seconds 3

if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "Installing essential Python packages..." -ForegroundColor Yellow
    
    $packages = @("openai", "requests", "python-dotenv")
    
    foreach ($pkg in $packages) {
        Write-Host "  Installing $pkg..." -ForegroundColor Cyan
        try {
            python -m pip install $pkg --quiet
            Write-Host "  ✓ $pkg installed" -ForegroundColor Green
        } catch {
            Write-Host "  ⚠ Failed to install $pkg" -ForegroundColor Yellow
        }
    }
    
    # Upgrade pip
    Write-Host "`n  Upgrading pip..." -ForegroundColor Cyan
    python -m pip install --upgrade pip --quiet
} else {
    Write-Host "Python is not available yet. You may need to restart your terminal." -ForegroundColor Yellow
    Write-Host "After restarting, run: pip install openai requests python-dotenv" -ForegroundColor Cyan
}

# Installation Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " Installation Summary" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "  Newly installed: $installCount" -ForegroundColor Green
Write-Host "  Already installed (skipped): $skipCount" -ForegroundColor Cyan
Write-Host "  Failed: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " Next Steps" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "1. RESTART your computer or at least close and reopen your terminal" -ForegroundColor Yellow
Write-Host "2. After restarting, run check-environment.ps1 to verify all installations" -ForegroundColor Yellow
Write-Host "3. Make sure Docker Desktop is running (if you installed it)" -ForegroundColor Yellow
Write-Host "`n4. You're ready for the workshop! 🚀" -ForegroundColor Green

# Create installation log
$logPath = Join-Path $PSScriptRoot "installation-log.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logContent = @"
AI Workshop - Quick Installation Log
Generated: $timestamp
========================================

Installation Summary:
- Newly installed: $installCount
- Already installed: $skipCount
- Failed: $errorCount

Tools processed:
1. Git
2. Java JDK 17
3. Maven
4. Python 3.12
5. Node.js LTS
6. Visual Studio Code

Python packages:
- openai
- requests
- python-dotenv

========================================
Next Steps:
1. Restart your computer
2. Run check-environment.ps1 to verify
3. Start Docker Desktop (if installed)
========================================
"@

$logContent | Out-File -FilePath $logPath -Encoding UTF8
Write-Host "`nInstallation log saved to: $logPath" -ForegroundColor Cyan

Write-Host "`n========================================`n" -ForegroundColor Cyan

Read-Host "Press Enter to exit"

