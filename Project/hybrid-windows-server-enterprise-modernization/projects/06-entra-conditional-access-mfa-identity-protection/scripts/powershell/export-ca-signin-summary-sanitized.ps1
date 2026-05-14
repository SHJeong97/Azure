# Project 06 Batch 8
# Export Conditional Access sign-in summary without public IP or location fields.

Connect-MgGraph -Scopes "AuditLog.Read.All","User.Read.All","Policy.Read.All"

$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$PolicyNames = @(
    "CA001-Require-MFA-Pilot-Users",
    "CA002-Block-Legacy-Authentication"
)

$StartTime = (Get-Date).AddDays(-7).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$RecentSignIns = Get-MgAuditLogSignIn `
    -Filter "createdDateTime ge $StartTime" `
    -All

$SanitizedPilotSignIns = $RecentSignIns |
Where-Object { $PilotUPNs -contains $_.UserPrincipalName } |
Select-Object `
    CreatedDateTime,
    UserDisplayName,
    UserPrincipalName,
    AppDisplayName,
    ClientAppUsed,
    ConditionalAccessStatus,
    @{Name="SignInStatus";Expression={$_.Status.ErrorCode}},
    @{Name="FailureReason";Expression={$_.Status.FailureReason}}

$SanitizedCAResults = foreach ($SignIn in $RecentSignIns) {
    if ($PilotUPNs -contains $SignIn.UserPrincipalName) {
        foreach ($Policy in $SignIn.AppliedConditionalAccessPolicies) {
            if ($Policy.DisplayName -in $PolicyNames) {
                [PSCustomObject]@{
                    CreatedDateTime = $SignIn.CreatedDateTime
                    UserPrincipalName = $SignIn.UserPrincipalName
                    UserDisplayName = $SignIn.UserDisplayName
                    AppDisplayName = $SignIn.AppDisplayName
                    ClientAppUsed = $SignIn.ClientAppUsed
                    ConditionalAccessStatus = $SignIn.ConditionalAccessStatus
                    PolicyName = $Policy.DisplayName
                    PolicyResult = $Policy.Result
                    GrantControls = ($Policy.EnforcedGrantControls -join ";")
                    SessionControls = ($Policy.EnforcedSessionControls -join ";")
                }
            }
        }
    }
}

$SanitizedPilotSignIns
$SanitizedCAResults