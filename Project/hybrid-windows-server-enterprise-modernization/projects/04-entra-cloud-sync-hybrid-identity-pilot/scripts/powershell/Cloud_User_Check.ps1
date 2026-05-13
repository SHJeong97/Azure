$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$CloudPilotLookup = foreach ($UPN in $PilotUPNs) {
    $CloudUser = Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property DisplayName,UserPrincipalName,Mail,AccountEnabled,Id,OnPremisesSyncEnabled `
        -ErrorAction SilentlyContinue

    if ($CloudUser) {
        [PSCustomObject]@{
            LookupUPN = $UPN
            CloudUserFound = "Yes"
            DisplayName = $CloudUser.DisplayName
            UserPrincipalName = $CloudUser.UserPrincipalName
            Mail = $CloudUser.Mail
            AccountEnabled = $CloudUser.AccountEnabled
            OnPremisesSyncEnabled = $CloudUser.OnPremisesSyncEnabled
            Id = $CloudUser.Id
            Status = "Cloud user found"
        }
    }
    else {
        [PSCustomObject]@{
            LookupUPN = $UPN
            CloudUserFound = "No"
            DisplayName = ""
            UserPrincipalName = ""
            Mail = ""
            AccountEnabled = ""
            OnPremisesSyncEnabled = ""
            Id = ""
            Status = "Not found yet or sync pending"
        }
    }
}

$CloudPilotLookup