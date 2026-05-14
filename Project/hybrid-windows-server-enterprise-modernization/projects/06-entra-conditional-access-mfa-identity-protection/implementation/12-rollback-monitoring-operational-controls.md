# Rollback, Monitoring, and Operational Controls

## Purpose

This document records rollback, monitoring, and operational controls for Project 06 Conditional Access policies.

## Policies Covered

| Policy | Purpose |
|---|---|
| CA001-Require-MFA-Pilot-Users | Require MFA for pilot users |
| CA002-Block-Legacy-Authentication | Block legacy authentication |

## Operational State

CA001 was enabled for pilot enforcement.

CA002 was enabled or intentionally left in report-only mode depending on the legacy authentication review result.

## Pilot Scope

```text
GRP-CA-Pilot-Users
```

## Break-Glass Exclusion

```text
GRP-CA-Excluded-BreakGlass
```

## Emergency Access Account

```text
emergency.access01@democompany1016.onmicrosoft.com
```

## Rollback Controls

Rollback helper scripts were created to return Conditional Access policies to report-only mode.

| Script | Purpose |
|---|---|
| rollback-ca001-to-report-only.ps1 | Returns CA001 to report-only |
| rollback-ca002-to-report-only.ps1 | Returns CA002 to report-only |
| rollback-ca-pilot-policies-to-report-only.ps1 | Returns both pilot policies to report-only |

## Monitoring Controls

Monitoring scripts were created for policy state, group membership, sanitized sign-in review, and emergency access usage.

| Script | Purpose |
|---|---|
| monitor-ca-policy-operational-state.ps1 | Checks CA001 and CA002 policy states |
| monitor-ca-pilot-and-breakglass-groups.ps1 | Checks pilot and break-glass group membership |
| export-ca-signin-summary-sanitized.ps1 | Exports sign-in results without IP/location data |
| monitor-breakglass-signins-sanitized.ps1 | Reviews emergency access sign-ins without IP/location data |

## Privacy-Safe Evidence Rule

The project does not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show public IP address, location, device details, or session metadata.

## Operational Monitoring Areas

| Area | Healthy State |
|---|---|
| CA001 state | Enabled for pilot enforcement |
| CA002 state | Enabled or report-only based on legacy-auth review |
| Pilot group membership | Only approved pilot users |
| Break-glass group membership | Emergency account present |
| Break-glass sign-ins | Rare and explainable |
| Policy change audit logs | All changes explainable |
| Evidence privacy | No public IP or location exposure |

## Rollback Trigger Examples

Rollback should be considered if:

- Pilot users cannot sign in
- MFA prompts fail unexpectedly
- Break-glass account access is affected
- CA002 blocks a required legacy workflow
- Wrong users are included in policy scope
- Policy behavior does not match expected results

## Rollback Order

1. Confirm the affected policy.
2. Use emergency access if normal admin access is affected.
3. Set the affected policy back to report-only.
4. Validate pilot user sign-in.
5. Review sign-in logs using sanitized fields.
6. Fix the policy scope, grant controls, or exclusions.
7. Re-test in report-only mode.
8. Re-enable only after validation.

## Safety Decisions

This batch did not:

- Expand policies to all users
- Remove break-glass exclusions
- Require Intune
- Require compliant devices
- Export public IP address fields
- Export location fields
- Enforce Identity Protection risk policies

## Business Value

Rollback and monitoring controls make the Conditional Access pilot safer to operate, easier to troubleshoot, and more suitable for future production expansion.
