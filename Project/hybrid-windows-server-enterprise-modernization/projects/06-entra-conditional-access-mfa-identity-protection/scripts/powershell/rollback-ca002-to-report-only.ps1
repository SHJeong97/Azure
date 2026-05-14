# Project 06 Batch 5
# Rollback helper script for CA002.
# This sets CA002 back to report-only mode.
# Use this if CA002 is later enabled and needs quick rollback.

Connect-MgGraph -Scopes "Policy.ReadWrite.ConditionalAccess","Policy.Read.All"

$PolicyName = "CA002-Block-Legacy-Authentication"

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