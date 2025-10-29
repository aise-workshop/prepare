@echo off
REM AI Workshop Environment Check Script for Windows (Batch Version)
REM This is a simpler version that checks for required tools

setlocal enabledelayedexpansion

echo ========================================
echo  AI Workshop Environment Check Script
echo ========================================
echo This script will check if all required tools are installed.
echo Estimated time: 1-2 minutes
echo Note: This script only CHECKS - it does not install anything.
echo ========================================
echo.

set "MISSING_TOOLS="
set "ALL_OK=1"

REM ==========================================
REM Check for Git
REM ==========================================
echo [1/8] Checking Git...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Git is installed
    for /f "delims=" %%i in ('git --version') do echo   Version: %%i
) else (
    echo   [MISSING] Git is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! Git"
    set "ALL_OK=0"
    echo   Download from: https://git-scm.com/download/win
)
echo.

REM ==========================================
REM Check for Java
REM ==========================================
echo [2/8] Checking Java JDK...
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Java is installed
    java -version 2>&1 | findstr "version"
) else (
    echo   [MISSING] Java JDK is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! Java"
    set "ALL_OK=0"
    echo   Download from: https://adoptium.net/ or https://www.oracle.com/java/technologies/downloads/
)
echo.

REM ==========================================
REM Check for Maven
REM ==========================================
echo [3/8] Checking Maven...
mvn -version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Maven is installed
    for /f "delims=" %%i in ('mvn -version ^| findstr "Apache Maven"') do echo   %%i
) else (
    echo   [MISSING] Maven is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! Maven"
    set "ALL_OK=0"
    echo   Download from: https://maven.apache.org/download.cgi
)
echo.

REM ==========================================
REM Check for Python
REM ==========================================
echo [4/8] Checking Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Python is installed
    python --version
) else (
    echo   [MISSING] Python is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! Python"
    set "ALL_OK=0"
    echo   Download from: https://www.python.org/downloads/
)
echo.

REM ==========================================
REM Check for pip
REM ==========================================
echo [5/8] Checking pip...
pip --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] pip is installed
    for /f "delims=" %%i in ('pip --version') do echo   %%i
) else (
    echo   [MISSING] pip is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! pip"
    set "ALL_OK=0"
    echo   pip usually comes with Python. Try: python -m ensurepip --upgrade
)
echo.

REM ==========================================
REM Check for Node.js
REM ==========================================
echo [6/8] Checking Node.js...
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Node.js is installed
    node --version
    npm --version 2>&1 | findstr /C:"." >nul && echo   npm is also installed
) else (
    echo   [MISSING] Node.js is NOT installed
    set "MISSING_TOOLS=!MISSING_TOOLS! Node.js"
    set "ALL_OK=0"
    echo   Download from: https://nodejs.org/
)
echo.

REM ==========================================
REM Check for Docker
REM ==========================================
echo [7/8] Checking Docker...
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] Docker is installed
    docker --version
    
    REM Check if Docker is running
    docker ps >nul 2>&1
    if %errorlevel% neq 0 (
        echo   [WARNING] Docker is installed but not running
        echo   Please start Docker Desktop
    )
) else (
    echo   [OPTIONAL] Docker is NOT installed
    echo   Docker is optional but recommended
    echo   Download from: https://www.docker.com/products/docker-desktop
)
echo.

REM ==========================================
REM Check for IDE
REM ==========================================
echo [8/8] Checking IDE...
set "IDE_FOUND=0"

code --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   [OK] VS Code is installed
    code --version | findstr /R "[0-9]\.[0-9]"
    set "IDE_FOUND=1"
)

if exist "C:\Program Files\JetBrains\IntelliJ IDEA*\bin\idea64.exe" (
    echo   [OK] IntelliJ IDEA is installed
    set "IDE_FOUND=1"
)

if !IDE_FOUND! equ 0 (
    echo   [RECOMMENDED] No IDE detected
    echo   Recommended: VS Code or IntelliJ IDEA
    echo   VS Code: https://code.visualstudio.com/
    echo   IntelliJ IDEA: https://www.jetbrains.com/idea/
)
echo.

REM ==========================================
REM Check Python packages
REM ==========================================
echo [Bonus] Checking Python packages for AI development...
pip --version >nul 2>&1
if %errorlevel% equ 0 (
    echo   Checking for essential packages...
    
    pip list 2>nul | findstr /B "openai " >nul
    if %errorlevel% equ 0 (
        echo   [OK] openai package is installed
    ) else (
        echo   [MISSING] openai package is NOT installed
        echo   Install with: pip install openai
    )
    
    pip list 2>nul | findstr /B "requests " >nul
    if %errorlevel% equ 0 (
        echo   [OK] requests package is installed
    ) else (
        echo   [MISSING] requests package is NOT installed
        echo   Install with: pip install requests
    )
    
    pip list 2>nul | findstr /B "python-dotenv " >nul
    if %errorlevel% equ 0 (
        echo   [OK] python-dotenv package is installed
    ) else (
        echo   [MISSING] python-dotenv package is NOT installed
        echo   Install with: pip install python-dotenv
    )
) else (
    echo   [SKIPPED] pip is not available
)
echo.

REM ==========================================
REM Summary Report
REM ==========================================
echo ========================================
echo  Environment Check Summary
echo ========================================
echo.

if !ALL_OK! equ 1 (
    echo [SUCCESS] All required tools are installed!
    echo.
    echo    *** You are ready for the AI workshop! ***
    echo.
) else (
    echo [WARNING] Some required tools are missing:
    echo !MISSING_TOOLS!
    echo.
    echo    *** ACTION REQUIRED ***
    echo Please install the missing tools before the workshop.
    echo See installation instructions below.
    echo.
)

echo ========================================
echo Installation Instructions:
echo ========================================
echo.
echo For easier installation, you can use the PowerShell script:
echo   1. Right-click on check-environment.ps1
echo   2. Select "Run with PowerShell"
echo   3. If you get an error, run this first in PowerShell as Admin:
echo      Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
echo.
echo Or install tools manually using winget (Windows Package Manager):
echo   Git:      winget install Git.Git
echo   Java:     winget install Microsoft.OpenJDK.17
echo   Maven:    winget install Apache.Maven
echo   Python:   winget install Python.Python.3.12
echo   Node.js:  winget install OpenJS.NodeJS.LTS
echo   VS Code:  winget install Microsoft.VisualStudioCode
echo.
echo ========================================

REM Create log file
set "LOG_FILE=%~dp0environment-check-log.txt"
echo AI Workshop Environment Check Log > "!LOG_FILE!"
echo Generated: %date% %time% >> "!LOG_FILE!"
echo ======================================== >> "!LOG_FILE!"
echo. >> "!LOG_FILE!"

if !ALL_OK! equ 1 (
    echo Status: All required tools are installed >> "!LOG_FILE!"
) else (
    echo Status: Missing tools:!MISSING_TOOLS! >> "!LOG_FILE!"
)

echo. >> "!LOG_FILE!"
echo Log file saved to: !LOG_FILE!
echo.

pause

