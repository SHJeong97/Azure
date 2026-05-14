# Risk and Rollback Plan

## Purpose

This document defines the risk and rollback plan for Project 07 privileged access governance.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| Emergency access removed | Tenant recovery blocked | Preserve emergency access account |
| Admin roles removed too early | Required administration blocked | Inventory roles before changes |
| PIM settings misconfigured | Admins cannot activate roles | Test with pilot scope first |
| Privileged access assigned too broadly | Over-permissioned users | Use least privilege role mapping |
| Access reviews scoped incorrectly | Wrong access reviewed or missed | Document review scope before creation |
| Audit evidence exposes IP/location | Privacy issue | Exclude IP/location fields |
| Rollback process missing | Delayed recovery | Create rollback runbook |

## Emergency Access Rule

The emergency access account must remain available.

```text
emergency.access01@democompany1016.onmicrosoft.com
```

This account should not be removed, disabled, or converted into a workflow that could block emergency tenant recovery.

## Rollback Principles

Rollback should preserve tenant access first.

Recommended order:

1. Validate emergency access.
2. Identify the affected role or assignment.
3. Restore required active admin access if needed.
4. Revert PIM settings to the previous state.
5. Remove only the problematic new assignment.
6. Validate administrator access.
7. Review audit logs.
8. Document the final state.

## Safety Decisions

This project will not:

- Remove emergency access
- Remove current admin access before inventory
- Convert all administrators at once
- Assign privileged roles broadly
- Export public IP or location fields
- Require Intune
- Require compliant devices

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show public IP, location, device details, or session metadata.

## Business Value

Rollback planning makes privileged access governance safer by preserving emergency recovery, reducing lockout risk, and documenting recovery steps before role changes are made.
