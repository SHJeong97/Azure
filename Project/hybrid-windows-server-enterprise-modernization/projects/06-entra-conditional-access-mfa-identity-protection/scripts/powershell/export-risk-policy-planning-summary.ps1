# Project 06 Batch 6
# Export risk-based Conditional Access planning summary.
# This script does not create or enforce Conditional Access policies.

$RiskPolicyPlan = @(
    [PSCustomObject]@{
        PolicyName = "CA004-SignIn-Risk-MFA"
        RiskType = "Sign-in risk"
        RiskLevels = "medium; high"
        PlannedGrantControl = "Require MFA"
        InitialMode = "Report-only planned"
        IncludedGroup = "GRP-CA-Pilot-Users"
        ExcludedGroup = "GRP-CA-Excluded-BreakGlass"
        EnforcementNow = "No"
    }
    [PSCustomObject]@{
        PolicyName = "CA005-User-Risk-Password-Change"
        RiskType = "User risk"
        RiskLevels = "high"
        PlannedGrantControl = "Require password change"
        InitialMode = "Report-only planned"
        IncludedGroup = "GRP-CA-Pilot-Users"
        ExcludedGroup = "GRP-CA-Excluded-BreakGlass"
        EnforcementNow = "No"
    }
)

$RiskPolicyPlan

$RiskPolicyPlan |
Export-Csv ".\risk-policy-planning-summary.csv" -NoTypeInformation