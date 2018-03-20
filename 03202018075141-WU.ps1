### Check for and install Get-WUInstall Prerequisites
# Latest NuGet provider
If ((Get-PackageProvider | Select-Object Name) -match "NuGet")
    {
        Write-Host "NuGet installed, continuing..."   
    }
Else
    {
        Install-PackageProvider Nuget -Force
    }

# PowershellGet
If ((Get-InstalledModule | Select-Object Name) -match "PowershellGet")
    {
        Write-Host "PowershellGet installed, continuing..."
    }
else
    {
        Install-Module -Name PowershellGet -Force
    }

# PSWindowsUpdate
If ((Get-Module | Select-Object Name) -match "PSWindowsUpdate")
    {
        Write-Host "PSWIndowsUpdate installed, continuing..."
    }
else 
    {
        Install-Module PSWindowsUpdate -Force -Scope AllUsers
    }

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