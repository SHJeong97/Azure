# Project 07 Batch 7
# Monitor active Microsoft Entra privileged role assignments.

Connect-MgGraph -Scopes `
"Directory.Read.All",`
"RoleManagement.Read.Directory"

$TargetRoleNames = @(
    "Global Administrator",
    "Privileged Role Administrator",
    "Security Administrator",
    "Conditional Access Administrator",
    "Exchange Administrator",
    "User Administrator",
    "Helpdesk Administrator"
)

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

$PrivilegedRoleAssignments = foreach ($Assignment in $AllRoleAssignments) {
    if ($TargetRoleNames -contains $Assignment.roleDefinition.displayName) {
        [PSCustomObject]@{
            RoleName = $Assignment.roleDefinition.displayName
            PrincipalDisplayName = $Assignment.principal.displayName
            PrincipalType = $Assignment.principal.'@odata.type'
            PrincipalId = $Assignment.principalId
            DirectoryScopeId = $Assignment.directoryScopeId
            AssignmentId = $Assignment.id
            AssignmentType = "Active"
        }
    }
}

$PrivilegedRoleAssignments |
Sort-Object RoleName,PrincipalDisplayName