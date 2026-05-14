# Project 06 Batch 4
# Validation helper script for CA001 policy state and scope.

Connect-MgGraph -Scopes "Policy.Read.All","Group.Read.All","User.Read.All"

$PolicyName = "CA001-Require-MFA-Pilot-Users"

$Policy = Get-MgIdentityConditionalAccessPolicy -All |
Where-Object { $_.DisplayName -eq $PolicyName }

if (-not $Policy) {
    throw "Policy not found: $PolicyName"
}

$PolicyFull = Get-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId $Policy.Id

[PSCustomObject]@{
    PolicyName = $PolicyFull.DisplayName
    PolicyId = $PolicyFull.Id
    State = $PolicyFull.State
    IncludedGroups = ($PolicyFull.Conditions.Users.IncludeGroups -join ";")
    ExcludedGroups = ($PolicyFull.Conditions.Users.ExcludeGroups -join ";")
    IncludedApplications = ($PolicyFull.Conditions.Applications.IncludeApplications -join ";")
    ClientAppTypes = ($PolicyFull.Conditions.ClientAppTypes -join ";")
    GrantControls = ($PolicyFull.GrantControls.BuiltInControls -join ";")
}