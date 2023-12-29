# 指定防火牆端口
$port = 13389

# 新增防火牆規則
New-NetFirewallRule -DisplayName "RDP ($Port)" -Direction Inbound -Protocol TCP -LocalPort $port -Action Allow

# 修改 RDP 端口
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name 'PortNumber' -Value $port

# 指定依賴服務的名稱
$dependentServices = Get-Service -Name "TermService" | Select-Object -ExpandProperty DependentServices

# 如果有依賴的服務，先停止依賴的服務
if ($dependentServices) {
    foreach ($dependentService in $dependentServices) {
        Stop-Service -Name $dependentService.ServiceName -Force
    }
}

# TermService 服務 (停止/重啟)
Stop-Service -Name "TermService" -Force
Start-Service -Name "TermService"