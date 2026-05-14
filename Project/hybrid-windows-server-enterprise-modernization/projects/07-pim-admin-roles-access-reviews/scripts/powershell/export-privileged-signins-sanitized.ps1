# Project 07 Batch 7
# Export privileged target sign-ins without IP or location fields.

Connect-MgGraph -Scopes `
"AuditLog.Read.All",`
"User.Read.All"

$PrivilegedTargetUPNs = @(
    "srmgadmin@democompany1016.onmicrosoft.com",
    "emergency.access01@democompany1016.onmicrosoft.com",
    "sophia.martinez@summitridge-mfg.com"
)

$StartTime = (Get-Date).AddDays(-14).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$PrivilegedTargetSignIns = Get-MgAuditLogSignIn `
    -Filter "createdDateTime ge $StartTime" `
    -All |
Where-Object {
    $PrivilegedTargetUPNs -contains $_.UserPrincipalName
} |
Select-Object `
    CreatedDateTime,
    UserDisplayName,
    UserPrincipalName,
    AppDisplayName,
    ClientAppUsed,
    ConditionalAccessStatus,
    IsInteractive,
    @{Name="SignInStatusCode";Expression={$_.Status.ErrorCode}},
    @{Name="FailureReason";Expression={$_.Status.FailureReason}}

$PrivilegedTargetSignIns |
Sort-Object CreatedDateTime -Descending