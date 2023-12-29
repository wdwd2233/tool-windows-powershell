# 安裝 Windows Terminal
winget install -e --accept-source-agreements --id=Microsoft.WindowsTerminal


# 設定 Windows Terminal 桌面捷徑 (%LocalAppData%\Microsoft\WindowsApps\wt.ex)
$wtShortcutPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop', 'Windows Terminal.lnk')
$wtShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($wtShortcutPath)
$wtShortcut.TargetPath = "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe\wt.exe"
$wtShortcut.Save()


# 設定 Windows Terminal 桌面捷徑右鍵選單
$registryPath = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\Windows Terminal"
New-Item -Path $registryPath -Force
Set-ItemProperty -Path $registryPath -Name "(Default)" -Value "Windows Terminal"
Set-ItemProperty -Path $registryPath -Name "Icon" -Value "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe\wt.exe"
New-Item -Path "$registryPath\command" -Force
Set-ItemProperty -Path "$registryPath\command" -Name "(Default)" -Value "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.18.3181.0_x64__8wekyb3d8bbwe\wt.exe"
