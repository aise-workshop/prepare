# 🚀 Quick Start - Environment Check

## Run the Check (Choose One)

### Option 1: Python Script (Recommended)
```bash
python env_check.py
```

### Option 2: Windows Batch Script
```bash
env_check.bat
```

### Option 3: HTML View
```bash
# Simply open env_check.html in your web browser
# Shows installation instructions (not an actual check)
```

## What You'll See

### ✅ Green Checkmark
Tool is installed and meets requirements. You're good to go!

### ❌ Red X
Tool is missing or doesn't meet version requirements. Installation needed.

Example output:
```
✅ Java JDK (Required): JDK 21
❌ Docker (Optional): Not installed
   → Installation needed
   • Winget: winget install Docker.DockerDesktop
   • Chocolatey: choco install docker-desktop
   • Manual: https://www.docker.com/products/docker-desktop/
```

## Quick Install Commands

### Install Everything (Winget - Windows 11)
```powershell
# Required tools
winget install Oracle.JDK.21
winget install Python.Python.3.12
winget install Apache.Maven
winget install Git.Git

# Optional tools
winget install Docker.DockerDesktop
winget install OpenJS.NodeJS.LTS
```

### Install Everything (Chocolatey)
```powershell
# Required tools
choco install openjdk --version=21.0.0
choco install python312
choco install maven
choco install git

# Optional tools
choco install docker-desktop
choco install nodejs-lts
```

## After Installation

1. **Restart your terminal** (or computer for Docker)
2. **Run the check again** to verify everything is installed
3. **Clone the workshop repositories**:
```bash
git clone https://github.com/WeiZhang101/agent-backend-demo
git clone https://github.com/demongodYY/OOCL_langgraph
git clone https://github.com/aise-workshop/jsp2spring-boot-practise
git clone https://github.com/aise-workshop/tibco-movie-practise
```

## Common Issues

### "Command not found" after installation
- **Solution**: Restart your terminal or add to PATH

### Python version wrong
- **Solution**: Uninstall old version first, then install 3.12

### Maven needs JAVA_HOME
- **Solution**: Set environment variable:
```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-21", "Machine")
```

### Docker won't start
- **Solution**: Enable WSL2, restart computer, check Windows version

## Need Help?

📖 See detailed guide: [README.md](README.md)  
📋 Workshop requirements: [doc.md](doc.md)  

---

**Ready? Run the check and start preparing! 🎓**

