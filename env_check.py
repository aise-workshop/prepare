#!/usr/bin/env python3
"""
AI4SE Workshop Environment Check
Checks required software installations for the workshop
"""

import subprocess
import sys
import re
from typing import Tuple, Optional

# ANSI color codes
GREEN = '\033[92m'
RED = '\033[91m'
YELLOW = '\033[93m'
BLUE = '\033[94m'
RESET = '\033[0m'
BOLD = '\033[1m'

def run_command(command: list) -> Tuple[bool, str]:
    """Run a command and return success status and output"""
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=10
        )
        output = result.stdout + result.stderr
        return result.returncode == 0, output.strip()
    except (subprocess.TimeoutExpired, FileNotFoundError, Exception):
        return False, ""

def check_java() -> Tuple[bool, str, str]:
    """Check Java JDK version (requires JDK 21+)"""
    success, output = run_command(['java', '-version'])
    
    if not success:
        return False, "Not installed", ""
    
    # Parse version from output
    version_match = re.search(r'version "?(\d+)\.?(\d+)?', output)
    if version_match:
        major = int(version_match.group(1))
        if major >= 21:
            return True, f"JDK {major}", output
        else:
            return False, f"JDK {major} (need 21+)", output
    
    return False, "Unknown version", output

def check_docker() -> Tuple[bool, str, str]:
    """Check Docker installation (optional)"""
    success, output = run_command(['docker', '--version'])
    
    if not success:
        return False, "Not installed", ""
    
    version_match = re.search(r'Docker version ([\d.]+)', output)
    if version_match:
        return True, f"v{version_match.group(1)}", output
    
    return True, "Installed", output

def check_python() -> Tuple[bool, str, str]:
    """Check Python version (requires 3.12)"""
    success, output = run_command(['python', '--version'])
    
    if not success:
        # Try python3 command
        success, output = run_command(['python3', '--version'])
    
    if not success:
        return False, "Not installed", ""
    
    version_match = re.search(r'Python (\d+)\.(\d+)', output)
    if version_match:
        major = int(version_match.group(1))
        minor = int(version_match.group(2))
        version_str = f"{major}.{minor}"
        
        if major == 3 and minor >= 12:
            return True, f"Python {version_str}", output
        else:
            return False, f"Python {version_str} (need 3.12+)", output
    
    return False, "Unknown version", output

def check_maven() -> Tuple[bool, str, str]:
    """Check Maven installation"""
    success, output = run_command(['mvn', '-version'])
    
    if not success:
        return False, "Not installed", ""
    
    version_match = re.search(r'Apache Maven ([\d.]+)', output)
    if version_match:
        return True, f"Maven {version_match.group(1)}", output
    
    return True, "Installed", output

def check_nodejs() -> Tuple[bool, str, str]:
    """Check Node.js installation"""
    success, output = run_command(['node', '--version'])
    
    if not success:
        return False, "Not installed", ""
    
    version = output.strip()
    return True, version, output

def check_git() -> Tuple[bool, str, str]:
    """Check Git installation"""
    success, output = run_command(['git', '--version'])
    
    if not success:
        return False, "Not installed", ""
    
    version_match = re.search(r'git version ([\d.]+)', output)
    if version_match:
        return True, f"v{version_match.group(1)}", output
    
    return True, "Installed", output

def print_header():
    """Print the header"""
    print(f"\n{BOLD}{BLUE}{'='*70}{RESET}")
    print(f"{BOLD}{BLUE}  AI4SE Workshop - Environment Check{RESET}")
    print(f"{BOLD}{BLUE}{'='*70}{RESET}\n")

def print_section(title: str):
    """Print a section header"""
    print(f"\n{BOLD}{YELLOW}{title}{RESET}")
    print(f"{YELLOW}{'-'*70}{RESET}")

def print_check(name: str, required: bool, passed: bool, info: str, install_info: dict):
    """Print a check result"""
    icon = f"{GREEN}✅{RESET}" if passed else f"{RED}❌{RESET}"
    req_text = "Required" if required else "Optional"
    
    print(f"{icon} {BOLD}{name}{RESET} ({req_text}): {info}")
    
    if not passed:
        print(f"   {RED}→ Installation needed{RESET}")
        if 'winget' in install_info:
            print(f"   {BLUE}• Winget:{RESET} {install_info['winget']}")
        if 'choco' in install_info:
            print(f"   {BLUE}• Chocolatey:{RESET} {install_info['choco']}")
        if 'link' in install_info:
            print(f"   {BLUE}• Manual:{RESET} {install_info['link']}")
        if 'note' in install_info:
            print(f"   {YELLOW}  Note: {install_info['note']}{RESET}")

def main():
    print_header()
    
    all_passed = True
    required_passed = True
    
    # Part 1: Agent Backend Demo (Java + Docker)
    print_section("Part 1: Agent Backend Demo")
    print(f"Repository: https://github.com/WeiZhang101/agent-backend-demo")
    
    # Check Java
    java_ok, java_info, _ = check_java()
    print_check("Java JDK 21+", True, java_ok, java_info, {
        'winget': 'winget install Oracle.JDK.21',
        'choco': 'choco install openjdk --version=21.0.0',
        'link': 'https://www.oracle.com/java/technologies/downloads/#java21',
        'note': 'OpenJDK alternatives: Temurin, Microsoft Build of OpenJDK'
    })
    if not java_ok:
        required_passed = False
        all_passed = False
    
    # Check Docker
    docker_ok, docker_info, _ = check_docker()
    print_check("Docker", False, docker_ok, docker_info, {
        'winget': 'winget install Docker.DockerDesktop',
        'choco': 'choco install docker-desktop',
        'link': 'https://www.docker.com/products/docker-desktop/',
        'note': 'Optional for PostgreSQL; required for running databases locally'
    })
    if not docker_ok:
        all_passed = False
    
    # Part 2: LangGraph (Python)
    print_section("Part 2: LangGraph Practice")
    print(f"Repository: https://github.com/demongodYY/OOCL_langgraph")
    
    python_ok, python_info, _ = check_python()
    print_check("Python 3.12+", True, python_ok, python_info, {
        'winget': 'winget install Python.Python.3.12',
        'choco': 'choco install python312',
        'link': 'https://www.python.org/downloads/',
        'note': 'After installation, create virtual environment: python -m venv venv'
    })
    if not python_ok:
        required_passed = False
        all_passed = False
    
    # Part 3: JSP to Spring Boot (Maven)
    print_section("Part 3: JSP to Spring Boot Practice")
    print(f"Repository: https://github.com/aise-workshop/jsp2spring-boot-practise")
    
    maven_ok, maven_info, _ = check_maven()
    print_check("Maven", True, maven_ok, maven_info, {
        'winget': 'winget install Apache.Maven',
        'choco': 'choco install maven',
        'link': 'https://maven.apache.org/download.cgi',
        'note': 'Required for Spring Boot: mvn spring-boot:run'
    })
    if not maven_ok:
        required_passed = False
        all_passed = False
    
    # Advanced: Tibco BW Migration (Node.js/TypeScript)
    print_section("Advanced: Tibco BW Migration CLI")
    print(f"Repository: https://github.com/aise-workshop/tibco-movie-practise")
    
    node_ok, node_info, _ = check_nodejs()
    print_check("Node.js", False, node_ok, node_info, {
        'winget': 'winget install OpenJS.NodeJS.LTS',
        'choco': 'choco install nodejs-lts',
        'link': 'https://nodejs.org/',
        'note': 'Optional for advanced exercises; includes npm for TypeScript'
    })
    if not node_ok:
        all_passed = False
    
    # Essential Tools
    print_section("Essential Tools")
    
    git_ok, git_info, _ = check_git()
    print_check("Git", True, git_ok, git_info, {
        'winget': 'winget install Git.Git',
        'choco': 'choco install git',
        'link': 'https://git-scm.com/downloads',
        'note': 'Required for cloning repositories'
    })
    if not git_ok:
        required_passed = False
        all_passed = False
    
    # Summary
    print_section("Summary")
    if all_passed:
        print(f"{GREEN}{BOLD}✅ All checks passed! You're ready for the workshop!{RESET}\n")
        return 0
    elif required_passed:
        print(f"{YELLOW}{BOLD}⚠️  All required tools are installed!{RESET}")
        print(f"{YELLOW}   Optional tools missing (won't block basic exercises){RESET}\n")
        return 0
    else:
        print(f"{RED}{BOLD}❌ Some required tools are missing.{RESET}")
        print(f"{RED}   Please install them before the workshop.{RESET}\n")
        print(f"\n{BLUE}{BOLD}Installation Help:{RESET}")
        print(f"{BLUE}• If you don't have a package manager:{RESET}")
        print(f"  - Install winget (Windows 11 has it built-in)")
        print(f"  - Or install Chocolatey: https://chocolatey.org/install")
        print(f"• Run commands in PowerShell (Admin) or Command Prompt (Admin)\n")
        return 1

if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print(f"\n\n{YELLOW}Check interrupted by user{RESET}")
        sys.exit(130)

