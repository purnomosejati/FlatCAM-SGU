; Inno Setup script for FlatCAM 8.4-py3 (Windows 10/11 x64)
; Build after PyInstaller (from repository root):
;     iscc packaging\FlatCAM.iss
; Output: dist\FlatCAM-8.4-py3-Windows-x64-Setup.exe

#define AppName "FlatCAM"
#define AppVersion "8.4-py3"
#define AppPublisher "Purnomo Sejati, Swiss German University"

[Setup]
AppId={{6F1C7A2E-3B8D-4C55-9E1A-8B2F4D7C9A31}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppCopyright=(c) 2014-2015 Juan Pablo Caram; Python 3 port (c) 2026 Purnomo Sejati
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
LicenseFile=..\LICENSE
OutputDir=..\dist
OutputBaseFilename=FlatCAM-{#AppVersion}-Windows-x64-Setup
SetupIconFile=..\share\flatcam_icon256.ico
UninstallDisplayIcon={app}\FlatCAM.exe
Compression=lzma2/max
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
PrivilegesRequiredOverridesAllowed=dialog
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\dist\FlatCAM\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\FlatCAM.exe"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\FlatCAM.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\FlatCAM.exe"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent
