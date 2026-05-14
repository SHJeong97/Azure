# Project 07 Batch 7
# Monitor emergency access account state and active role assignments.
# Privacy-safe: does not export IP address or location fields.

Connect-MgGraph -Scopes `
"User.Read.All",`
"Directory.Read.All",`
"RoleManagement.Read.Directory"

$EmergencyAccessUPN = "emergency.access01@democompany1016.onmicrosoft.com"

$EmergencyAccessUser = Get-MgUser `
    -Filter "userPrincipalName eq '$EmergencyAccessUPN'" `
    -Property Id,DisplayName,UserPrincipalName,AccountEnabled,UserType `
    -ErrorAction SilentlyContinue

if (-not $EmergencyAccessUser) {
    throw "Emergency access account not found: $EmergencyAccessUPN"
}

$RoleAssignmentsUri = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?`$expand=principal,roleDefinition&`$top=999"

$AllRoleAssignments = @()

do {
    $Response = Invoke-MgGraphRequest -Method GET -Uri $RoleAssignmentsUri

    if ($Response.value) {
        $AllRoleAssignments += $Response.value
    }

    $RoleAssignmentsUri = $Response.'@odata.nextLink'
}
while ($RoleAssignmentsUri)

$EmergencyAccessAssignments = foreach ($Assignment in $AllRoleAssignments) {
    if ($Assignment.principalId -eq $EmergencyAccessUser.Id) {
        [PSCustomObject]@{
            UserPrincipalName = $EmergencyAccessUser.UserPrincipalName
            DisplayName = $EmergencyAccessUser.DisplayName
            AccountEnabled = $EmergencyAccessUser.AccountEnabled
            RoleName = $Assignment.roleDefinition.displayName
            DirectoryScopeId = $Assignment.directoryScopeId
            AssignmentType = "Active"
            RecommendedAction = "Preserve and monitor"
        }
    }
}

$EmergencyAccessAssignments |
Sort-Object RoleName