$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

foreach ($UPN in $PilotUPNs) {
    $User = Get-MgUser -Filter "userPrincipalName eq '$UPN'" -Property Id,UserPrincipalName,UsageLocation

    if ($User -and [string]::IsNullOrWhiteSpace($User.UsageLocation)) {
        try {
            Update-MgUser -UserId $User.Id -UsageLocation "US" -ErrorAction Stop
            Write-Host "Set UsageLocation to US for ${UPN}"
        }
        catch {
            Write-Host "FAILED to set UsageLocation for ${UPN}: $($_.Exception.Message)"
        }
    }
    elseif ($User) {
        Write-Host "UsageLocation already set for ${UPN}: $($User.UsageLocation)"
    }
    else {
        Write-Host "User not found: ${UPN}"
    }
}