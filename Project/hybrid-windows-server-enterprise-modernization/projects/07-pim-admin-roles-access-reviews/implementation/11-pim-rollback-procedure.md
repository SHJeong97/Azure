# PIM Rollback Procedure

## Purpose

This document defines rollback procedures for Project 07 PIM and privileged access governance.

## Rollback Principle

Preserve tenant access first.

Emergency access must be validated before removing or changing privileged access.

## Emergency Access Account

```text
emergency.access01@democompany1016.onmicrosoft.com
```

This account must remain available for recovery.

## Common Rollback Scenarios

| Scenario | Response |
|---|---|
| Sophia has active role after test | Deactivate active assignment through PIM My roles |
| Sophia eligible role no longer needed | Remove eligible assignment only after final validation |
| Wrong user assigned privileged role | Review assignment and remove only after confirming emergency access |
| Emergency access missing | Stop changes and restore emergency access |
| Access review result applied unexpectedly | Restore required access and document issue |
| Evidence exposes IP/location | Remove or sanitize evidence before GitHub upload |

## Rollback for Active PIM Assignment

Use this when a temporary active role remains active longer than expected.

1. Sign in as the affected user or administrator.
2. Go to Microsoft Entra PIM My roles.
3. Open Active assignments.
4. Deactivate the active role.
5. Validate active assignments with Microsoft Graph.
6. Export sanitized evidence.
7. Document the final state.

## Rollback for Eligible Assignment

Use this only after final validation if the eligible assignment is no longer needed.

1. Validate emergency access.
2. Confirm the eligible assignment target.
3. Confirm the role is not currently active.
4. Remove the eligible assignment only if approved.
5. Export updated eligible assignment state.
6. Document the removal.

## Rollback for Emergency Access Issue

Use this if emergency access is missing, disabled, or no longer privileged.

1. Stop all privileged access changes.
2. Use another Global Administrator or Privileged Role Administrator account if available.
3. Restore the emergency access account.
4. Restore required emergency admin role assignment.
5. Validate sign-in and role state.
6. Export sanitized evidence.
7. Document issue and corrective action.

## Rollback Evidence Requirements

Every rollback action must include:

- Before state
- Action taken
- After state
- Admin performing action
- Reason for rollback
- Sanitized audit evidence
- Validation screenshot

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be sanitized before GitHub upload.

## Safety Decisions

This rollback plan does not recommend automatic privileged access removal.

All privileged rollback decisions should be reviewed before execution.

## Business Value

This rollback procedure reduces lockout risk and provides a controlled recovery path for PIM and privileged access governance changes.
