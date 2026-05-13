Import-Module ActiveDirectory

$PilotUsers = @(
    @{
        SamAccountName = "emma.wilson"
        TargetUPN = "emma.wilson@summitridge-mfg.com"
    },
    @{
        SamAccountName = "olivia.brown"
        TargetUPN = "olivia.brown@summitridge-mfg.com"
    },
    @{
        SamAccountName = "sophia.martinez"
        TargetUPN = "sophia.martinez@summitridge-mfg.com"
    }
)

$ADToCloudComparison = foreach ($Pilot in $PilotUsers) {
    $ADUser = Get-ADUser $Pilot.SamAccountName -Properties UserPrincipalName,Department,Title,Enabled,mail,DistinguishedName

    $CloudUser = Get-MgUser `
        -Filter "userPrincipalName eq '$($Pilot.TargetUPN)'" `
        -Property DisplayName,UserPrincipalName,Mail,AccountEnabled,Id,OnPremisesSyncEnabled,OnPremisesImmutableId,CreatedDateTime `
        -ErrorAction SilentlyContinue

    [PSCustomObject]@{
        SamAccountName = $ADUser.SamAccountName
        ADName = $ADUser.Name
        ADUserPrincipalName = $ADUser.UserPrincipalName
        ADDepartment = $ADUser.Department
        ADTitle = $ADUser.Title
        ADEnabled = $ADUser.Enabled
        ADMail = $ADUser.mail
        ADDistinguishedName = $ADUser.DistinguishedName
        CloudUserFound = if ($CloudUser) { "Yes" } else { "No" }
        CloudDisplayName = if ($CloudUser) { $CloudUser.DisplayName } else { "" }
        CloudUserPrincipalName = if ($CloudUser) { $CloudUser.UserPrincipalName } else { "" }
        CloudMail = if ($CloudUser) { $CloudUser.Mail } else { "" }
        CloudAccountEnabled = if ($CloudUser) { $CloudUser.AccountEnabled } else { "" }
        OnPremisesSyncEnabled = if ($CloudUser) { $CloudUser.OnPremisesSyncEnabled } else { "" }
        OnPremisesImmutableId = if ($CloudUser) { $CloudUser.OnPremisesImmutableId } else { "" }
        CreatedDateTime = if ($CloudUser) { $CloudUser.CreatedDateTime } else { "" }
        ValidationStatus = if ($CloudUser -and $CloudUser.OnPremisesSyncEnabled -eq $true) { "Synced successfully" } elseif ($CloudUser) { "Cloud user found; sync flag review needed" } else { "Not found or sync pending" }
    }
}

$ADToCloudComparison |
Export-Csv "C:\LabEvidence\Project04\Batch05\batch-05-ad-to-cloud-pilot-comparison.csv" -NoTypeInformation
