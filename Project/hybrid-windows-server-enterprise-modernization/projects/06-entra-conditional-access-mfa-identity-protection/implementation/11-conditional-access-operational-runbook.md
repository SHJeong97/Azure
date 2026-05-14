# Conditional Access Operational Runbook

## Purpose

This runbook defines operational monitoring, rollback, and evidence-handling procedures for Project 06 Conditional Access policies.

## Policies

| Policy | Purpose | Operational State |
|---|---|---|
| CA001-Require-MFA-Pilot-Users | Require MFA for pilot users | Enabled |
| CA002-Block-Legacy-Authentication | Block legacy authentication | Enabled or report-only depending on legacy-auth review |

## Pilot Group

```text
GRP-CA-Pilot-Users
```

## Break-Glass Exclusion Group

```text
GRP-CA-Excluded-BreakGlass
```

## Emergency Access Account

```text
emergency.access01@democompany1016.onmicrosoft.com
```

## Monitoring Checklist

Monitor the following areas:

| Area | Healthy State |
|---|---|
| CA001 state | Enabled for pilot enforcement |
| CA002 state | Enabled or report-only based on legacy-auth decision |
| Pilot group membership | Only approved pilot users |
| Break-glass group membership | Emergency access account present |
| Break-glass sign-ins | Rare and documented |
| Policy change audit logs | All changes explainable |
| Sign-in results | No unexpected lockouts |
| Evidence privacy | No public IP or location fields exported |

## Privacy-Safe Evidence Rule

Do not export these fields:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Geographic location
- Device details
- Browser session metadata
- Authenticator device details
- Phone numbers
- QR codes

## Rollback Decision Tree

Use rollback if:

- Pilot users cannot sign in
- MFA prompts fail unexpectedly
- Break-glass account is affected
- CA002 blocks a required legacy workflow
- Policy scope includes wrong users
- Emergency access is not available

## Rollback Order

1. Confirm the affected policy.
2. Use break-glass account if normal admin access is affected.
3. Set affected policy back to report-only.
4. Validate pilot user sign-in.
5. Review sign-in logs.
6. Fix scope, grant controls, or exclusions.
7. Re-test in report-only mode.
8. Re-enable only after validation.

## Rollback Scripts

| Script | Purpose |
|---|---|
| rollback-ca001-to-report-only.ps1 | Sets CA001 back to report-only |
| rollback-ca002-to-report-only.ps1 | Sets CA002 back to report-only |
| rollback-ca-pilot-policies-to-report-only.ps1 | Sets both pilot policies back to report-only |

## Monitoring Scripts

| Script | Purpose |
|---|---|
| monitor-ca-policy-operational-state.ps1 | Checks CA001 and CA002 state |
| monitor-ca-pilot-and-breakglass-groups.ps1 | Checks pilot and break-glass group membership |
| export-ca-signin-summary-sanitized.ps1 | Exports sanitized CA sign-in evidence |
| monitor-breakglass-signins-sanitized.ps1 | Exports sanitized break-glass sign-in evidence |

## Safety Decisions

This operational model does not:

- Export public IP address fields
- Export location fields
- Require Intune
- Require compliant devices
- Remove break-glass exclusions
- Apply policies to all users without pilot validation

## Business Value

This runbook provides a safe operational process for monitoring Conditional Access policies, preserving emergency access, protecting user privacy, and rolling back policy enforcement if required.
