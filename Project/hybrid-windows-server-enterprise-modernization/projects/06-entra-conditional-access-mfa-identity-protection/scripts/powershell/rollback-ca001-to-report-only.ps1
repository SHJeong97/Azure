# Project 06 Batch 4
# Rollback helper script for CA001.
# This sets CA001 back to report-only mode.
# Use this if CA001 is later enabled and needs quick rollback.

Connect-MgGraph -Scopes "Policy.ReadWrite.ConditionalAccess","Policy.Read.All"

$PolicyName = "CA001-Require-MFA-Pilot-Users"

$Policy = Get-MgIdentityConditionalAccessPolicy -All |
Where-Object { $_.DisplayName -eq $PolicyName }

if (-not $Policy) {
    throw "Policy not found: $PolicyName"
}

Update-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId $Policy.Id `
    -State "enabledForReportingButNotEnforced"

$UpdatedPolicy = Get-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId $Policy.Id

$UpdatedPolicy |
Select-Object Id,DisplayName,State,ModifiedDateTime