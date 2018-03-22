### Check for and install Get-WUInstall Prerequisites
# Install chocolatey
$InstallDir="C:\ProgramData\chocoportable"
$env:ChocolateyInstall="$InstallDir"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install 7zip
choco install 7zip -y

# Download PSWindowsUpdate
(New-Object Net.WebClient).DownloadFile("https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc/file/41459/47/PSWindowsUpdate.zip")

# Unzip PSWindows Update
7z x PSWindowsUpdate.zip -oC:\Windows\System32\WindowsPowerShell\v1.0\Modules\

# Load PSWindowsUpdate
Import-Module PSWindowsUpdate

### Add Windows Update Service Manager ID
If ((Get-WUServiceManager | Select-Object ServiceID) -match "7971f918-a847-4430-9279-4a52d1efe18d")
    {
        Write-Host "Required Service Manager imported, continuing..."
    }
else
    {
        Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false
    }

### Install Updates But Supress Reboot
Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot -Install -Confirm:$false