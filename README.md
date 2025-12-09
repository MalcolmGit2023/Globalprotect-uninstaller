# GlobalProtect Uninstaller (Windows)

> **Completely remove Palo Alto Networks GlobalProtect VPN from Windows.**  
> Stops services, uninstalls via MSI, removes leftover files and registry keys, and writes a log to `%TEMP%\GlobalProtect_Uninstall.log`.

---

## ✨ What this does

- Detects and enforces **Administrator** context
- **Stops GlobalProtect services** (`PanGPS`, `PanGPA`)
- **Uninstalls** GlobalProtect via MSI (silent, no restart)
- **Removes leftover folders** under Program Files, ProgramData, and user AppData
- **Deletes registry keys** related to GlobalProtect
- **Logs** every step to `%TEMP%\GlobalProtect_Uninstall.log`

---

## ⚙️ Requirements

- Windows with PowerShell (5.1+ recommended)
- Run **as Administrator**

---

View Wiki page for more troubleshooting steps - https://github.com/MalcolmGit2023/Globalprotect-uninstaller/wiki/KB-Article#:~:text=Home-,KB%20Article,-%F0%9F%9B%A0%20GlobalProtect%20VPN%20Troubleshooting
