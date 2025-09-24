<powershell>
$ErrorActionPreference = "Stop"

# Espera a que principalmente los servicios de red estén activos
Start-Sleep -Seconds 30

function Ensure-OpenSSHInstalled {
  $feature = Get-WindowsCapability -Online | Where-Object { $_.Name -ilike 'OpenSSH.Server*' }
  if ($null -eq $feature -or $feature.State -ne 'Installed') {
    Add-WindowsCapability -Online -Name 'OpenSSH.Server~~~~0.0.1.0'
  }
}

Ensure-OpenSSHInstalled

Start-Service sshd
Set-Service -Name sshd -StartupType Automatic
if (Get-Service -Name ssh-agent -ErrorAction SilentlyContinue) {
  Set-Service -Name ssh-agent -StartupType Automatic
  Start-Service ssh-agent
}

$authorizedKeysPath = 'C:\ProgramData\ssh\administrators_authorized_keys'
New-Item -ItemType Directory -Path (Split-Path $authorizedKeysPath) -Force | Out-Null
@"
${authorized_keys}
"@ | Out-File -FilePath $authorizedKeysPath -Encoding ascii -Force

& icacls $authorizedKeysPath /inheritance:r | Out-Null
& icacls $authorizedKeysPath /grant 'SYSTEM:(F)' | Out-Null
& icacls $authorizedKeysPath /grant 'Administrators:(F)' | Out-Null

$configPath = 'C:\ProgramData\ssh\sshd_config'
if (-not (Test-Path $configPath)) {
  Copy-Item 'C:\Program Files\OpenSSH\sshd_config' $configPath -Force
}

$config = Get-Content $configPath
if ($config -notcontains 'PubkeyAuthentication yes') {
  Add-Content -Path $configPath -Value "PubkeyAuthentication yes"
}
if ($config -notcontains 'PasswordAuthentication no') {
  Add-Content -Path $configPath -Value "PasswordAuthentication no"
}
if ($config -notcontains 'Subsystem sftp sftp-server.exe') {
  Add-Content -Path $configPath -Value "Subsystem sftp sftp-server.exe"
}

Restart-Service sshd

if (-not (Get-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -ErrorAction SilentlyContinue)) {
  New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH SSH Server (TCP)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
}
Set-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -Profile Domain,Private,Public -Enabled True
</powershell>

