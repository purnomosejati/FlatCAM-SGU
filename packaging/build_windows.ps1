# Build the FlatCAM Windows installer on a Windows 10/11 x64 PC.
# Requirements: Python 3.12+ from python.org (with Tcl/Tk), Inno Setup 6 (https://jrsoftware.org/isdl.php)
# Usage (PowerShell, from the repository root):
#     powershell -ExecutionPolicy Bypass -File packaging\build_windows.ps1
$ErrorActionPreference = "Stop"

python -m venv .venv-win
.\.venv-win\Scripts\python -m pip install --upgrade pip
.\.venv-win\Scripts\pip install -r requirements.txt pyinstaller

.\.venv-win\Scripts\pyinstaller --noconfirm packaging\FlatCAM.spec

$iscc = "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe"
if (-not (Test-Path $iscc)) { $iscc = "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe" }
& $iscc packaging\FlatCAM.iss

Write-Host "Installer: dist\FlatCAM-8.4-py3-Windows-x64-Setup.exe"
