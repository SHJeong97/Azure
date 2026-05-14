# Project 07 Batch 7
# Export PIM operational state.
# Privacy-safe: does not export IP address or location fields.

Connect-MgGraph -Scopes `
"User.Read.All",`
"Directory.Read.All",`
"RoleManagement.Read.Directory"

$TargetUPNs = @(
    "srmgadmin@democompany1016.onmicrosoft.com",
    "emergency.access01@democompany1016.onmicrosoft.com",
    "sophia.martinez@summitridge-mfg.com"
)

$TargetUsers = foreach ($UPN in $TargetUPNs) {
    $User = Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property Id,DisplayName,UserPrincipalName,AccountEnabled,UserType `
        -ErrorAction SilentlyContinue

    if ($User) {
        [PSCustomObject]@{
            DisplayName = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            AccountEnabled = $User.AccountEnabled
            UserType = $User.UserType
            Id = $User.Id
            Found = "Yes"
        }
    }
    else {
        [PSCustomObject]@{
            DisplayName = ""
            UserPrincipalName = $UPN
            AccountEnabled = ""
            UserType = ""
            Id = ""
            Found = "No"
        }
    }
}

$TargetUsers

$Sophia = $TargetUsers |
Where-Object { $_.UserPrincipalName -eq "sophia.martinez@summitridge-mfg.com" }

if ($Sophia.Found -eq "Yes") {
    $EligibilityUri = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleEligibilityScheduleInstances?`$expand=principal,roleDefinition&`$top=999"

    $EligibilityInstances = @()

    do {
        $Response = Invoke-MgGraphRequest -Method GET -Uri $EligibilityUri

        if ($Response.value) {
            $EligibilityInstances += $Response.value
        }

        $EligibilityUri = $Response.'@odata.nextLink'
    }
    while ($EligibilityUri)

    $SophiaEligibleAssignments = foreach ($Instance in $EligibilityInstances) {
        if ($Instance.principalId -eq $Sophia.Id) {
            [PSCustomObject]@{
                PrincipalDisplayName = $Instance.principal.displayName
                UserPrincipalName = $Sophia.UserPrincipalName
                RoleName = $Instance.roleDefinition.displayName
                RoleDefinitionId = $Instance.roleDefinitionId
                DirectoryScopeId = $Instance.directoryScopeId
                StartDateTime = $Instance.startDateTime
                EndDateTime = $Instance.endDateTime
                AssignmentType = "Eligible"
            }
        }
    }

    $SophiaEligibleAssignments | Sort-Object RoleName
}