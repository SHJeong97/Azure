# Project 06 Batch 8
# Monitor Conditional Access policy operational state.
# Does not export IP address or location fields.

Connect-MgGraph -Scopes "Policy.Read.All","Group.Read.All","User.Read.All"

$PolicyNames = @(
    "CA001-Require-MFA-Pilot-Users",
    "CA002-Block-Legacy-Authentication"
)

$PolicyState = foreach ($PolicyName in $PolicyNames) {
    $Policy = Get-MgIdentityConditionalAccessPolicy -All |
    Where-Object { $_.DisplayName -eq $PolicyName }

    if ($Policy) {
        [PSCustomObject]@{
            PolicyName = $Policy.DisplayName
            PolicyId = $Policy.Id
            State = $Policy.State
            CreatedDateTime = $Policy.CreatedDateTime
            ModifiedDateTime = $Policy.ModifiedDateTime
            Found = "Yes"
        }
    }
    else {
        [PSCustomObject]@{
            PolicyName = $PolicyName
            PolicyId = ""
            State = ""
            CreatedDateTime = ""
            ModifiedDateTime = ""
            Found = "No"
        }
    }
}

$PolicyState