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

## 🚀 Usage

### Option A — Run directly (elevated PowerShell)
```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Clone or download the repo, then:
