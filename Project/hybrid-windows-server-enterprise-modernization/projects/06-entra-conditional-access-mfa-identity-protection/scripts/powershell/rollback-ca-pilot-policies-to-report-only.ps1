# Project 06 Batch 8
# Rollback helper script.
# Sets pilot Conditional Access policies back to report-only mode.
# Does not delete policies.
# Does not change group membership.

Connect-MgGraph -Scopes "Policy.ReadWrite.ConditionalAccess","Policy.Read.All"

$PolicyNames = @(
    "CA001-Require-MFA-Pilot-Users",
    "CA002-Block-Legacy-Authentication"
)

$RollbackResults = foreach ($PolicyName in $PolicyNames) {
    $Policy = Get-MgIdentityConditionalAccessPolicy -All |
    Where-Object { $_.DisplayName -eq $PolicyName }

    if ($Policy) {
        Update-MgIdentityConditionalAccessPolicy `
            -ConditionalAccessPolicyId $Policy.Id `
            -State "enabledForReportingButNotEnforced"

        $UpdatedPolicy = Get-MgIdentityConditionalAccessPolicy `
            -ConditionalAccessPolicyId $Policy.Id

        [PSCustomObject]@{
            PolicyName = $UpdatedPolicy.DisplayName
            PolicyId = $UpdatedPolicy.Id
            State = $UpdatedPolicy.State
            ModifiedDateTime = $UpdatedPolicy.ModifiedDateTime
            RollbackStatus = "Set to report-only"
        }
    }
    else {
        [PSCustomObject]@{
            PolicyName = $PolicyName
            PolicyId = ""
            State = ""
            ModifiedDateTime = ""
            RollbackStatus = "Policy not found"
        }
    }
}

$RollbackResults