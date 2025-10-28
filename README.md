# AI Workshop Environment Check Scripts

This package contains scripts to help you verify that your Windows computer has all the necessary tools installed for the AI workshop.

## 📋 Required Tools

The following tools will be checked:

1. **Git** - Version control system
2. **Java JDK** - Java Development Kit (recommended: JDK 17+)
3. **Maven** - Java project management tool
4. **Python** - Python programming language (recommended: Python 3.8+)
5. **pip** - Python package installer
6. **Node.js** - JavaScript runtime (includes npm)
7. **Docker** - Container platform (optional but recommended)
8. **IDE** - VS Code or IntelliJ IDEA (recommended)

### Python Packages
The script will also check for essential Python packages:
- `openai` - OpenAI API client
- `requests` - HTTP library
- `python-dotenv` - Environment variable management

## 🚀 How to Use

### Option 1: Batch File (Easiest - Check Only)

1. **Double-click** `check-environment.bat`
2. The script will check all required tools
3. A summary report will show what's installed and what's missing
4. Follow the download links provided for any missing tools

**This option only CHECKS your environment - it does not install anything.**

### Option 2: PowerShell Script (Recommended - Check & Install)

This option can automatically install missing tools for you!

#### Step 1: Enable PowerShell Scripts (One-time setup)

1. Press `Win + X` and select "Windows PowerShell (Admin)" or "Terminal (Admin)"
2. Run this command:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. Type `Y` and press Enter

#### Step 2: Run the Script

**Method A - Right-click:**
1. Right-click on `check-environment.ps1`
2. Select "Run with PowerShell"
3. If prompted for Administrator access, click "Yes"

**Method B - PowerShell Terminal:**
1. Open PowerShell as Administrator
2. Navigate to the script folder:
   ```powershell
   cd "C:\Mac\Home\Desktop\prepare"
   ```
3. Run the script:
   ```powershell
   .\check-environment.ps1
   ```

#### Step 3: Follow the Prompts

- The script will check each tool
- If a tool is missing, it will ask if you want to install it
- Type `Y` for Yes or `N` for No
- The script uses `winget` (Windows Package Manager) to install tools automatically

## 📊 What Happens After Running?

1. **Console Output**: You'll see a real-time status of each check
   - ✓ Green checkmarks = Tool is installed
   - ✗ Red X = Tool is missing
   - ⚠ Yellow warning = Optional or needs attention

2. **Log File**: A log file `environment-check-log.txt` will be created in the same folder with details of the check

3. **Installation**: If you chose to install missing tools via PowerShell script, they will be installed automatically

## ⚠️ Important Notes

### After Installation
**Please restart your terminal/PowerShell** after installing any tools for the changes to take effect.

### Winget Requirement
The PowerShell automatic installation feature requires `winget` (Windows Package Manager), which is included in Windows 11 and Windows 10 (version 1809 or later). If you're on an older version of Windows, you'll need to install tools manually.

### Manual Installation Links

If automatic installation doesn't work, here are the download links:

- **Git**: https://git-scm.com/download/win
- **Java (OpenJDK)**: https://adoptium.net/ or https://www.oracle.com/java/technologies/downloads/
- **Maven**: https://maven.apache.org/download.cgi
- **Python**: https://www.python.org/downloads/
- **Node.js**: https://nodejs.org/
- **Docker Desktop**: https://www.docker.com/products/docker-desktop
- **VS Code**: https://code.visualstudio.com/
- **IntelliJ IDEA**: https://www.jetbrains.com/idea/

### Installing Python Packages

After Python and pip are installed, you can install required packages by running:

```bash
pip install openai requests python-dotenv
```

Or install them one by one:
```bash
pip install openai
pip install requests
pip install python-dotenv
```

## 🔧 Troubleshooting

### "Script cannot be loaded" Error (PowerShell)
If you get an error about execution policy:
1. Open PowerShell as Administrator
2. Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. Try running the script again

### "winget not found" Error
If you get a "winget not found" error:
1. Make sure you're on Windows 10 (1809+) or Windows 11
2. Update Windows to the latest version
3. Install the App Installer from Microsoft Store
4. Alternatively, install tools manually using the links above

### "Access Denied" Error
Make sure you're running the PowerShell script as Administrator:
1. Right-click on `check-environment.ps1`
2. Select "Run with PowerShell"
3. Click "Yes" when prompted for administrator access

### Docker Not Running
If Docker is installed but not running:
1. Open Docker Desktop from the Start menu
2. Wait for it to start (you'll see a whale icon in the system tray)
3. Run the check script again

## 📝 Workshop Preparation Checklist

Before the workshop, make sure:

- [ ] All required tools show green checkmarks (✓)
- [ ] Java version is 17 or higher
- [ ] Python version is 3.8 or higher
- [ ] Essential Python packages are installed
- [ ] You have an IDE installed (VS Code or IntelliJ IDEA)
- [ ] You've restarted your terminal after installations
- [ ] Docker Desktop is running (if installed)

## 🆘 Need Help?

If you encounter any issues:

1. Check the log file: `environment-check-log.txt`
2. Try installing tools manually using the provided links
3. Restart your computer after installing tools
4. Contact the workshop organizer with details from the log file

## 📚 Additional Resources

### GitHub Repositories Referenced in Workshop
- https://github.com/aise-workshop/jsp2spring-boot-practise
- https://github.com/openai/openai-java
- https://github.com/gszhangwei/structured-prompts-driven-development
- https://github.com/WeiZhang101/agent-backend-demo
- https://github.com/aise-workshop/tibco-movie-practise

### Useful Documentation
- Git: https://git-scm.com/doc
- Java: https://docs.oracle.com/en/java/
- Maven: https://maven.apache.org/guides/
- Python: https://docs.python.org/3/
- Node.js: https://nodejs.org/docs/
- Docker: https://docs.docker.com/
- OpenAI API: https://platform.openai.com/docs/

---

**Good luck with your AI workshop! 🚀**

