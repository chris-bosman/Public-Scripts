### Check for and install Get-WUInstall Prerequisites
# Download PSWindowsUpdate
$Destination = "C:\Windows\System32\WindowsPowerShell\v1.0\Modules"
Invoke-WebRequest -Uri "https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc/file/41459/47/PSWindowsUpdate.zip" -OutFile "$Destination\PSWindowsUpdate.zip"

# Unzip Module
$File = "$Destination\PSWindowsUpdate.zip"
$Shell = New-Object -ComObject Shell.Application
$Zip = $Shell.NameSpace($File)
ForEach ($Item in $Zip.Items())
    {
        $Shell.Namespace($Destination).CopyHere($Item)
    }

# Import Module
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