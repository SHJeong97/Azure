# Project 06 Batch 8
# Monitor emergency access sign-ins without exporting public IP or location fields.

Connect-MgGraph -Scopes "AuditLog.Read.All","User.Read.All"

$BreakGlassUPN = "emergency.access01@democompany1016.onmicrosoft.com"
$StartTime = (Get-Date).AddDays(-7).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$BreakGlassSignIns = Get-MgAuditLogSignIn `
    -Filter "createdDateTime ge $StartTime and userPrincipalName eq '$BreakGlassUPN'" `
    -All |
Select-Object `
    CreatedDateTime,
    UserDisplayName,
    UserPrincipalName,
    AppDisplayName,
    ClientAppUsed,
    ConditionalAccessStatus,
    @{Name="SignInStatus";Expression={$_.Status.ErrorCode}},
    @{Name="FailureReason";Expression={$_.Status.FailureReason}}

$BreakGlassSignIns