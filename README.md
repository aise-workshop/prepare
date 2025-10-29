# AI4SE Workshop - Environment Check

This tool helps you verify that your environment is ready for the AI4SE workshop.

## Quick Start

### Windows Users

**Option 1: Run the Batch Script (No Python needed)**
```batch
env_check.bat
```

**Option 2: Run the Python Script (Better formatting)**
```batch
python env_check.py
```

### What Gets Checked

The script checks for the following tools required by different workshop parts:

#### ✅ Required Tools
- **Java JDK 21+** (Part 1: Agent Backend Demo)
- **Python 3.12+** (Part 2: LangGraph Practice)
- **Maven** (Part 3: JSP to Spring Boot)
- **Git** (Essential for all parts)

#### 🔵 Optional Tools
- **Docker** (Part 1: For running PostgreSQL locally)
- **Node.js** (Advanced: Tibco BW Migration exercises)

## Installation Guide

### Using Winget (Windows 11+)

Windows 11 includes `winget` by default. Run these commands in PowerShell or Command Prompt:

```powershell
# Install Java JDK 21
winget install Oracle.JDK.21

# Install Python 3.12
winget install Python.Python.3.12

# Install Maven
winget install Apache.Maven

# Install Git
winget install Git.Git

# Optional: Install Docker
winget install Docker.DockerDesktop

# Optional: Install Node.js
winget install OpenJS.NodeJS.LTS
```

### Using Chocolatey

First, install Chocolatey from https://chocolatey.org/install

Then run (in PowerShell as Administrator):

```powershell
# Install Java
choco install openjdk --version=21.0.0

# Install Python
choco install python312

# Install Maven
choco install maven

# Install Git
choco install git

# Optional: Install Docker
choco install docker-desktop

# Optional: Install Node.js
choco install nodejs-lts
```

### Manual Installation

If you prefer manual installation:

- **Java JDK 21**: https://www.oracle.com/java/technologies/downloads/#java21
- **Python 3.12**: https://www.python.org/downloads/
- **Maven**: https://maven.apache.org/download.cgi
- **Git**: https://git-scm.com/downloads
- **Docker**: https://www.docker.com/products/docker-desktop/
- **Node.js**: https://nodejs.org/

## Workshop Parts

### Part 1: Agent Backend Demo
- **Repository**: https://github.com/WeiZhang101/agent-backend-demo
- **Requirements**: Java JDK 21+, Docker (optional)
- **Note**: Follow the Quick Start guide in the repo's README

### Part 2: LangGraph Practice
- **Repository**: https://github.com/demongodYY/OOCL_langgraph
- **Requirements**: Python 3.12
- **Setup Steps**:
  1. Clone the repository
  2. Create virtual environment: `python -m venv venv`
  3. Activate: `venv\Scripts\activate` (Windows)
  4. Install dependencies: `pip install -r requirements.txt`
  5. Open `studio practice` folder and start LangGraph

### Part 3: JSP to Spring Boot Practice
- **Repository**: https://github.com/aise-workshop/jsp2spring-boot-practise
- **Requirements**: Java, Maven
- **Key Commands**: 
  - Start application: `mvn spring-boot:run`
  - Setup `.env` file with `openai_key`

### Advanced: Tibco BW Migration CLI
- **Repository**: https://github.com/aise-workshop/tibco-movie-practise
- **Requirements**: Node.js/TypeScript
- **Levels**:
  - **Beginner**: Start from Stage 1 (Project initialization)
  - **Intermediate**: Start from Stage 2 (BWP file parsing)
  - **Advanced**: Start from Stage 3 (CLI interface and automation)

## Troubleshooting

### Python Command Not Found
- After installing Python, you may need to restart your terminal
- Try using `python3` instead of `python`
- Ensure Python is added to PATH during installation

### Maven Command Not Found
- Restart your terminal after installation
- Verify JAVA_HOME environment variable is set
- Check PATH includes Maven's bin directory

### Docker Issues
- Docker Desktop requires Windows 10/11 Pro, Enterprise, or Education
- WSL2 must be enabled for Docker Desktop on Windows
- Restart your computer after Docker installation

### Permission Issues
- Run installation commands as Administrator
- Right-click PowerShell/Command Prompt → "Run as Administrator"

## After Environment Setup

Once all required tools are installed:

1. Clone the workshop repositories:
```bash
git clone https://github.com/WeiZhang101/agent-backend-demo
git clone https://github.com/demongodYY/OOCL_langgraph
git clone https://github.com/aise-workshop/jsp2spring-boot-practise
git clone https://github.com/aise-workshop/tibco-movie-practise
```

2. Follow each repository's README for specific setup instructions

3. Test your setup by running the Quick Start guides

## Support

If you encounter issues:
1. Check the error messages from the environment check script
2. Follow the installation links provided
3. Consult the workshop documentation: `doc.md`
4. Reach out to workshop organizers

## Features

✅ **Visual Feedback**: Green checkmarks for installed tools, red X for missing ones  
📦 **Multiple Install Options**: Winget, Chocolatey, or manual installation  
🎯 **Clear Requirements**: Distinguishes between required and optional tools  
📝 **Version Checking**: Verifies minimum version requirements  
🔗 **Direct Links**: Provides installation links and commands  

---

**Good luck with your workshop preparation! 🚀**
