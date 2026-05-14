# Project 06 Batch 6
# Validate Identity Protection baseline state for the Conditional Access pilot.

Connect-MgGraph -Scopes `
"User.Read.All",`
"Group.Read.All",`
"Directory.Read.All",`
"IdentityRiskEvent.Read.All",`
"IdentityRiskyUser.Read.All"

$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$RiskyUsers = Get-MgRiskyUser -All |
Select-Object `
    Id,
    UserDisplayName,
    UserPrincipalName,
    RiskLevel,
    RiskState,
    RiskDetail,
    RiskLastUpdatedDateTime,
    IsDeleted

$RiskDetections = Get-MgRiskDetection -All |
Select-Object `
    Id,
    UserDisplayName,
    UserPrincipalName,
    RiskType,
    RiskLevel,
    RiskState,
    RiskDetail,
    DetectedDateTime,
    Activity,
    IpAddress

$PilotRiskyUserState = foreach ($UPN in $PilotUPNs) {
    $RiskyUser = $RiskyUsers |
    Where-Object { $_.UserPrincipalName -eq $UPN }

    if ($RiskyUser) {
        [PSCustomObject]@{
            UserPrincipalName = $UPN
            RiskFound = "Yes"
            RiskLevel = $RiskyUser.RiskLevel
            RiskState = $RiskyUser.RiskState
            RiskDetail = $RiskyUser.RiskDetail
            RiskLastUpdatedDateTime = $RiskyUser.RiskLastUpdatedDateTime
        }
    }
    else {
        [PSCustomObject]@{
            UserPrincipalName = $UPN
            RiskFound = "No"
            RiskLevel = "none"
            RiskState = "none"
            RiskDetail = "No current risky user state found"
            RiskLastUpdatedDateTime = ""
        }
    }
}

$IdentityProtectionBaseline = [PSCustomObject]@{
    RiskyUserCount = if ($RiskyUsers) { ($RiskyUsers | Measure-Object).Count } else { 0 }
    PilotRiskyUserCount = ($PilotRiskyUserState | Where-Object { $_.RiskFound -eq "Yes" } | Measure-Object).Count
    RiskDetectionCount = if ($RiskDetections) { ($RiskDetections | Measure-Object).Count } else { 0 }
    PlannedSignInRiskPolicy = "CA004-SignIn-Risk-MFA"
    PlannedUserRiskPolicy = "CA005-User-Risk-Password-Change"
    Result = "Identity Protection baseline exported"
}

$PilotRiskyUserState
$IdentityProtectionBaseline