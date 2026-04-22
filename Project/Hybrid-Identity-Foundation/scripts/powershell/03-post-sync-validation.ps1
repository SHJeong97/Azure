Import-Module ADSync -ErrorAction Stop
Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "`n=== ADSync Service ==="
Get-Service ADSync | Select-Object Status, Name, DisplayName

Write-Host "`n=== Scheduler ==="
Get-ADSyncScheduler | Select-Object SyncCycleEnabled, StagingModeEnabled, AllowedSyncCycleInterval, CurrentlyEffectiveSyncCycleInterval, NextSyncCycleStartTimeInUTC

Write-Host "`n=== Pilot AD Users ==="
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=corp,DC=democompany1016,DC=local" -Properties UserPrincipalName |
    Select-Object Name, SamAccountName, UserPrincipalName |
    Sort-Object Name

Write-Host "`n=== Pilot Admin AD Users ==="
Get-ADUser -Filter * -SearchBase "OU=Admins,DC=corp,DC=democompany1016,DC=local" -Properties UserPrincipalName |
    Select-Object Name, SamAccountName, UserPrincipalName |
    Sort-Object Name

Write-Host "`n=== Pilot Groups ==="
Get-ADGroup -Filter * -SearchBase "OU=Groups,DC=corp,DC=democompany1016,DC=local" |
    Select-Object Name, GroupCategory, GroupScope |
    Sort-Object Name
