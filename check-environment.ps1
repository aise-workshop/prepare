# AI Workshop Environment Check Script for Windows
# This script checks if all required tools are installed and offers to install missing ones

# Require Administrator privileges
#Requires -RunAsAdministrator

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " AI Workshop Environment Check Script" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try {
        if (Get-Command $command -ErrorAction Stop) {
            return $true
        }
    }
    catch {
        return $false
    }
    finally {
        $ErrorActionPreference = $oldPreference
    }
}

# Function to prompt for installation
function Prompt-Install {
    param($tool)
    $response = Read-Host "Would you like to install $tool now? (Y/N)"
    return $response -eq 'Y' -or $response -eq 'y'
}

# Check results
$allChecks = @()

# ==========================================
# 1. Check for Git
# ==========================================
Write-Host "[1/8] Checking Git..." -ForegroundColor Yellow
if (Test-CommandExists git) {
    $gitVersion = git --version
    Write-Host "  ✓ Git is installed: $gitVersion" -ForegroundColor Green
    $allChecks += @{Name="Git"; Status="OK"; Version=$gitVersion}
} else {
    Write-Host "  ✗ Git is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="Git"; Status="MISSING"; Version="N/A"}
    
    if (Prompt-Install "Git") {
        Write-Host "  Installing Git..." -ForegroundColor Cyan
        winget install --id Git.Git -e --source winget --silent
        Write-Host "  Git installed. Please restart your terminal." -ForegroundColor Green
    }
}

# ==========================================
# 2. Check for Java (JDK)
# ==========================================
Write-Host "`n[2/8] Checking Java JDK..." -ForegroundColor Yellow
if (Test-CommandExists java) {
    $javaVersion = java -version 2>&1 | Select-Object -First 1
    Write-Host "  ✓ Java is installed: $javaVersion" -ForegroundColor Green
    $allChecks += @{Name="Java"; Status="OK"; Version=$javaVersion}
    
    # Check Java version (recommend JDK 17 or higher)
    $versionMatch = $javaVersion -match '(\d+)\.(\d+)'
    if ($matches) {
        $majorVersion = [int]$matches[1]
        if ($majorVersion -lt 17) {
            Write-Host "  ⚠ Warning: Java version is below 17. Recommend JDK 17+" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "  ✗ Java JDK is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="Java"; Status="MISSING"; Version="N/A"}
    
    if (Prompt-Install "Java JDK 17") {
        Write-Host "  Installing OpenJDK 17..." -ForegroundColor Cyan
        winget install --id Microsoft.OpenJDK.17 -e --source winget --silent
        Write-Host "  Java JDK installed. Please restart your terminal." -ForegroundColor Green
    }
}

# ==========================================
# 3. Check for Maven
# ==========================================
Write-Host "`n[3/8] Checking Maven..." -ForegroundColor Yellow
if (Test-CommandExists mvn) {
    $mavenVersion = mvn -version | Select-Object -First 1
    Write-Host "  ✓ Maven is installed: $mavenVersion" -ForegroundColor Green
    $allChecks += @{Name="Maven"; Status="OK"; Version=$mavenVersion}
} else {
    Write-Host "  ✗ Maven is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="Maven"; Status="MISSING"; Version="N/A"}
    
    if (Prompt-Install "Maven") {
        Write-Host "  Installing Maven..." -ForegroundColor Cyan
        winget install --id Apache.Maven -e --source winget --silent
        Write-Host "  Maven installed. Please restart your terminal." -ForegroundColor Green
    }
}

# ==========================================
# 4. Check for Python
# ==========================================
Write-Host "`n[4/8] Checking Python..." -ForegroundColor Yellow
if (Test-CommandExists python) {
    $pythonVersion = python --version
    Write-Host "  ✓ Python is installed: $pythonVersion" -ForegroundColor Green
    $allChecks += @{Name="Python"; Status="OK"; Version=$pythonVersion}
    
    # Check Python version (recommend 3.8+)
    $versionMatch = $pythonVersion -match '(\d+)\.(\d+)'
    if ($matches) {
        $majorVersion = [int]$matches[1]
        $minorVersion = [int]$matches[2]
        if ($majorVersion -lt 3 -or ($majorVersion -eq 3 -and $minorVersion -lt 8)) {
            Write-Host "  ⚠ Warning: Python version is below 3.8. Recommend Python 3.8+" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "  ✗ Python is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="Python"; Status="MISSING"; Version="N/A"}
    
    if (Prompt-Install "Python 3.11") {
        Write-Host "  Installing Python 3.11..." -ForegroundColor Cyan
        winget install --id Python.Python.3.11 -e --source winget --silent
        Write-Host "  Python installed. Please restart your terminal." -ForegroundColor Green
    }
}

# ==========================================
# 5. Check for pip
# ==========================================
Write-Host "`n[5/8] Checking pip..." -ForegroundColor Yellow
if (Test-CommandExists pip) {
    $pipVersion = pip --version
    Write-Host "  ✓ pip is installed: $pipVersion" -ForegroundColor Green
    $allChecks += @{Name="pip"; Status="OK"; Version=$pipVersion}
} else {
    Write-Host "  ✗ pip is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="pip"; Status="MISSING"; Version="N/A"}
    
    if (Test-CommandExists python) {
        Write-Host "  Python is installed. Installing pip..." -ForegroundColor Cyan
        python -m ensurepip --upgrade
    }
}

# ==========================================
# 6. Check for Node.js
# ==========================================
Write-Host "`n[6/8] Checking Node.js..." -ForegroundColor Yellow
if (Test-CommandExists node) {
    $nodeVersion = node --version
    Write-Host "  ✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
    $allChecks += @{Name="Node.js"; Status="OK"; Version=$nodeVersion}
} else {
    Write-Host "  ✗ Node.js is NOT installed" -ForegroundColor Red
    $allChecks += @{Name="Node.js"; Status="MISSING"; Version="N/A"}
    
    if (Prompt-Install "Node.js LTS") {
        Write-Host "  Installing Node.js LTS..." -ForegroundColor Cyan
        winget install --id OpenJS.NodeJS.LTS -e --source winget --silent
        Write-Host "  Node.js installed. Please restart your terminal." -ForegroundColor Green
    }
}

# ==========================================
# 7. Check for Docker
# ==========================================
Write-Host "`n[7/8] Checking Docker..." -ForegroundColor Yellow
if (Test-CommandExists docker) {
    $dockerVersion = docker --version
    Write-Host "  ✓ Docker is installed: $dockerVersion" -ForegroundColor Green
    $allChecks += @{Name="Docker"; Status="OK"; Version=$dockerVersion}
    
    # Check if Docker is running
    $dockerRunning = docker ps 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ⚠ Docker is installed but not running. Please start Docker Desktop." -ForegroundColor Yellow
    }
} else {
    Write-Host "  ⚠ Docker is NOT installed (Optional)" -ForegroundColor Yellow
    $allChecks += @{Name="Docker"; Status="OPTIONAL"; Version="N/A"}
    
    $response = Read-Host "Docker is optional but recommended. Install Docker Desktop? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Write-Host "  Please download and install Docker Desktop from: https://www.docker.com/products/docker-desktop" -ForegroundColor Cyan
        Write-Host "  Opening browser..." -ForegroundColor Cyan
        Start-Process "https://www.docker.com/products/docker-desktop"
    }
}

# ==========================================
# 8. Check for VS Code or IntelliJ
# ==========================================
Write-Host "`n[8/8] Checking IDE..." -ForegroundColor Yellow
$ideFound = $false

if (Test-CommandExists code) {
    $codeVersion = code --version | Select-Object -First 1
    Write-Host "  ✓ VS Code is installed: $codeVersion" -ForegroundColor Green
    $allChecks += @{Name="VS Code"; Status="OK"; Version=$codeVersion}
    $ideFound = $true
}

# Check for IntelliJ IDEA
$intellijPaths = @(
    "C:\Program Files\JetBrains\IntelliJ IDEA*\bin\idea64.exe",
    "C:\Program Files (x86)\JetBrains\IntelliJ IDEA*\bin\idea64.exe"
)

foreach ($path in $intellijPaths) {
    if (Test-Path $path) {
        Write-Host "  ✓ IntelliJ IDEA is installed" -ForegroundColor Green
        $allChecks += @{Name="IntelliJ IDEA"; Status="OK"; Version="Detected"}
        $ideFound = $true
        break
    }
}

if (-not $ideFound) {
    Write-Host "  ⚠ No IDE detected (VS Code or IntelliJ recommended)" -ForegroundColor Yellow
    $allChecks += @{Name="IDE"; Status="RECOMMENDED"; Version="N/A"}
    
    $response = Read-Host "Would you like to install VS Code? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Write-Host "  Installing VS Code..." -ForegroundColor Cyan
        winget install --id Microsoft.VisualStudioCode -e --source winget --silent
        Write-Host "  VS Code installed." -ForegroundColor Green
    }
}

# ==========================================
# Check for specific Python packages
# ==========================================
Write-Host "`n[Bonus] Checking Python packages for AI development..." -ForegroundColor Yellow
if (Test-CommandExists pip) {
    $packages = @("openai", "requests", "python-dotenv")
    $missingPackages = @()
    
    foreach ($pkg in $packages) {
        $installed = pip list 2>&1 | Select-String -Pattern "^$pkg\s"
        if ($installed) {
            Write-Host "  ✓ $pkg is installed" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $pkg is NOT installed" -ForegroundColor Red
            $missingPackages += $pkg
        }
    }
    
    if ($missingPackages.Count -gt 0) {
        $response = Read-Host "`nWould you like to install missing Python packages? (Y/N)"
        if ($response -eq 'Y' -or $response -eq 'y') {
            Write-Host "  Installing packages: $($missingPackages -join ', ')..." -ForegroundColor Cyan
            foreach ($pkg in $missingPackages) {
                pip install $pkg
            }
            Write-Host "  Packages installed successfully!" -ForegroundColor Green
        }
    }
}

# ==========================================
# Summary Report
# ==========================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " Environment Check Summary" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$missingTools = @()
$optionalTools = @()

foreach ($check in $allChecks) {
    $status = $check.Status
    $name = $check.Name
    
    if ($status -eq "OK") {
        Write-Host "  ✓ $name" -ForegroundColor Green
    } elseif ($status -eq "MISSING") {
        Write-Host "  ✗ $name (REQUIRED)" -ForegroundColor Red
        $missingTools += $name
    } elseif ($status -eq "OPTIONAL" -or $status -eq "RECOMMENDED") {
        Write-Host "  ⚠ $name (Optional)" -ForegroundColor Yellow
        $optionalTools += $name
    }
}

if ($missingTools.Count -eq 0) {
    Write-Host "`n✓ All required tools are installed! You're ready for the workshop!" -ForegroundColor Green
} else {
    Write-Host "`n⚠ Missing required tools: $($missingTools -join ', ')" -ForegroundColor Red
    Write-Host "Please install the missing tools before the workshop." -ForegroundColor Yellow
}

if ($optionalTools.Count -gt 0) {
    Write-Host "`nOptional/Recommended tools not installed: $($optionalTools -join ', ')" -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Note: If you installed any tools, please restart your terminal/PowerShell" -ForegroundColor Yellow
Write-Host "for the changes to take effect." -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan

# Create a log file
$logPath = Join-Path $PSScriptRoot "environment-check-log.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logContent = @"
AI Workshop Environment Check Log
Generated: $timestamp
========================================

"@

foreach ($check in $allChecks) {
    $logContent += "$($check.Name): $($check.Status) - $($check.Version)`n"
}

if ($missingTools.Count -gt 0) {
    $logContent += "`nMissing Required Tools: $($missingTools -join ', ')`n"
}

$logContent | Out-File -FilePath $logPath -Encoding UTF8
Write-Host "Log file saved to: $logPath" -ForegroundColor Cyan

Read-Host "`nPress Enter to exit"

