$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$CloudPilotResults = foreach ($UPN in $PilotUPNs) {
    $User = Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property DisplayName,UserPrincipalName,Mail,AccountEnabled,Id `
        -ErrorAction SilentlyContinue

    if ($User) {
        [PSCustomObject]@{
            LookupUPN = $UPN
            CloudUserFound = "Yes"
            DisplayName = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            Mail = $User.Mail
            AccountEnabled = $User.AccountEnabled
            Id = $User.Id
            Source = "Microsoft 365 / Entra ID"
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
            Id = ""
            Source = "Microsoft 365 / Entra ID"
        }
    }
}

$CloudPilotResults |
Export-Csv "C:\LabEvidence\Project03\Batch06\batch-06-cloud-pilot-user-lookup.csv" -NoTypeInformation