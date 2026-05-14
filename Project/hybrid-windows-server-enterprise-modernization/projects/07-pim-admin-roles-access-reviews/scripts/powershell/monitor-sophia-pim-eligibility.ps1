# Project 07 Batch 7
# Monitor Sophia Martinez PIM eligible and active assignments.

Connect-MgGraph -Scopes `
"User.Read.All",`
"Directory.Read.All",`
"RoleManagement.Read.Directory"

$SophiaUPN = "sophia.martinez@summitridge-mfg.com"

$SophiaUser = Get-MgUser `
    -Filter "userPrincipalName eq '$SophiaUPN'" `
    -Property Id,DisplayName,UserPrincipalName,AccountEnabled `
    -ErrorAction Stop

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
    if ($Instance.principalId -eq $SophiaUser.Id) {
        [PSCustomObject]@{
            UserPrincipalName = $SophiaUser.UserPrincipalName
            RoleName = $Instance.roleDefinition.displayName
            RoleDefinitionId = $Instance.roleDefinitionId
            DirectoryScopeId = $Instance.directoryScopeId
            StartDateTime = $Instance.startDateTime
            EndDateTime = $Instance.endDateTime
            AssignmentType = "Eligible"
        }
    }
}

$AssignmentUri = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignmentScheduleInstances?`$expand=principal,roleDefinition&`$top=999"

$AssignmentInstances = @()

do {
    $Response = Invoke-MgGraphRequest -Method GET -Uri $AssignmentUri

    if ($Response.value) {
        $AssignmentInstances += $Response.value
    }

    $AssignmentUri = $Response.'@odata.nextLink'
}
while ($AssignmentUri)

$SophiaActiveAssignments = foreach ($Instance in $AssignmentInstances) {
    if ($Instance.principalId -eq $SophiaUser.Id) {
        [PSCustomObject]@{
            UserPrincipalName = $SophiaUser.UserPrincipalName
            RoleName = $Instance.roleDefinition.displayName
            RoleDefinitionId = $Instance.roleDefinitionId
            DirectoryScopeId = $Instance.directoryScopeId
            StartDateTime = $Instance.startDateTime
            EndDateTime = $Instance.endDateTime
            AssignmentType = "Active"
        }
    }
}

"Eligible assignments:"
$SophiaEligibleAssignments | Sort-Object RoleName

"Active assignments:"
$SophiaActiveAssignments | Sort-Object RoleName