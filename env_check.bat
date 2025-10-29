@echo off
setlocal enabledelayedexpansion

:: AI4SE Workshop Environment Check
:: Windows Batch Script Version

echo.
echo ======================================================================
echo   AI4SE Workshop - Environment Check
echo ======================================================================
echo.

set "PASS_COUNT=0"
set "FAIL_COUNT=0"
set "REQUIRED_FAIL=0"

:: Check Java
echo.
echo Part 1: Agent Backend Demo
echo Repository: https://github.com/WeiZhang101/agent-backend-demo
echo ----------------------------------------------------------------------

java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Java JDK ^(Required^): Installed
    for /f "tokens=3" %%v in ('java -version 2^>^&1 ^| findstr /i "version"') do (
        echo    Version: %%v
    )
    set /a PASS_COUNT+=1
) else (
    echo [91m✗[0m Java JDK 21+ ^(Required^): Not installed
    echo    [91m→ Installation needed[0m
    echo    [94m• Winget:[0m winget install Oracle.JDK.21
    echo    [94m• Chocolatey:[0m choco install openjdk --version=21.0.0
    echo    [94m• Manual:[0m https://www.oracle.com/java/technologies/downloads/#java21
    set /a FAIL_COUNT+=1
    set /a REQUIRED_FAIL+=1
)

:: Check Docker
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Docker ^(Optional^): Installed
    docker --version
    set /a PASS_COUNT+=1
) else (
    echo [91m✗[0m Docker ^(Optional^): Not installed
    echo    [91m→ Installation needed[0m
    echo    [94m• Winget:[0m winget install Docker.DockerDesktop
    echo    [94m• Chocolatey:[0m choco install docker-desktop
    echo    [94m• Manual:[0m https://www.docker.com/products/docker-desktop/
    echo    [93m  Note: Optional for PostgreSQL[0m
    set /a FAIL_COUNT+=1
)

:: Check Python
echo.
echo Part 2: LangGraph Practice
echo Repository: https://github.com/demongodYY/OOCL_langgraph
echo ----------------------------------------------------------------------

python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Python 3.12+ ^(Required^): Installed
    python --version
    set /a PASS_COUNT+=1
) else (
    python3 --version >nul 2>&1
    if !errorlevel! equ 0 (
        echo [92m✓[0m Python 3.12+ ^(Required^): Installed
        python3 --version
        set /a PASS_COUNT+=1
    ) else (
        echo [91m✗[0m Python 3.12+ ^(Required^): Not installed
        echo    [91m→ Installation needed[0m
        echo    [94m• Winget:[0m winget install Python.Python.3.12
        echo    [94m• Chocolatey:[0m choco install python312
        echo    [94m• Manual:[0m https://www.python.org/downloads/
        echo    [93m  Note: After install, create venv: python -m venv venv[0m
        set /a FAIL_COUNT+=1
        set /a REQUIRED_FAIL+=1
    )
)

:: Check Maven
echo.
echo Part 3: JSP to Spring Boot Practice
echo Repository: https://github.com/aise-workshop/jsp2spring-boot-practise
echo ----------------------------------------------------------------------

mvn -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Maven ^(Required^): Installed
    for /f "tokens=3" %%v in ('mvn -version 2^>^&1 ^| findstr /i "Apache Maven"') do (
        echo    Version: %%v
    )
    set /a PASS_COUNT+=1
) else (
    echo [91m✗[0m Maven ^(Required^): Not installed
    echo    [91m→ Installation needed[0m
    echo    [94m• Winget:[0m winget install Apache.Maven
    echo    [94m• Chocolatey:[0m choco install maven
    echo    [94m• Manual:[0m https://maven.apache.org/download.cgi
    echo    [93m  Note: Required for Spring Boot: mvn spring-boot:run[0m
    set /a FAIL_COUNT+=1
    set /a REQUIRED_FAIL+=1
)

:: Check Node.js
echo.
echo Advanced: Tibco BW Migration CLI
echo Repository: https://github.com/aise-workshop/tibco-movie-practise
echo ----------------------------------------------------------------------

node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Node.js ^(Optional^): Installed
    node --version
    set /a PASS_COUNT+=1
) else (
    echo [91m✗[0m Node.js ^(Optional^): Not installed
    echo    [91m→ Installation needed[0m
    echo    [94m• Winget:[0m winget install OpenJS.NodeJS.LTS
    echo    [94m• Chocolatey:[0m choco install nodejs-lts
    echo    [94m• Manual:[0m https://nodejs.org/
    echo    [93m  Note: Optional for advanced exercises[0m
    set /a FAIL_COUNT+=1
)

:: Check Git
echo.
echo Essential Tools
echo ----------------------------------------------------------------------

git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [92m✓[0m Git ^(Required^): Installed
    git --version
    set /a PASS_COUNT+=1
) else (
    echo [91m✗[0m Git ^(Required^): Not installed
    echo    [91m→ Installation needed[0m
    echo    [94m• Winget:[0m winget install Git.Git
    echo    [94m• Chocolatey:[0m choco install git
    echo    [94m• Manual:[0m https://git-scm.com/downloads
    echo    [93m  Note: Required for cloning repositories[0m
    set /a FAIL_COUNT+=1
    set /a REQUIRED_FAIL+=1
)

:: Summary
echo.
echo Summary
echo ----------------------------------------------------------------------

if %REQUIRED_FAIL% equ 0 (
    if %FAIL_COUNT% equ 0 (
        echo [92m✓ All checks passed! You're ready for the workshop![0m
    ) else (
        echo [93m⚠ All required tools are installed![0m
        echo [93m  Optional tools missing ^(won't block basic exercises^)[0m
    )
) else (
    echo [91m✗ Some required tools are missing.[0m
    echo [91m  Please install them before the workshop.[0m
    echo.
    echo [94mInstallation Help:[0m
    echo [94m• If you don't have a package manager:[0m
    echo   - Install winget ^(Windows 11 has it built-in^)
    echo   - Or install Chocolatey: https://chocolatey.org/install
    echo [94m• Run commands in PowerShell ^(Admin^) or Command Prompt ^(Admin^)[0m
)

echo.
echo Passed: !PASS_COUNT! / Failed: !FAIL_COUNT!
echo.

pause

