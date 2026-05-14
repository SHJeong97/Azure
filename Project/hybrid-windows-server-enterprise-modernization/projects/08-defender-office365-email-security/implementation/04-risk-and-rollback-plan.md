# Risk and Rollback Plan

## Purpose

This document defines the risk and rollback plan for Project 08 Microsoft Defender for Office 365 email security baseline.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| Mail security policies applied tenant-wide too early | Legitimate mail disruption | Use pilot scope before broad enforcement |
| Safe Links blocks legitimate URLs | User productivity impact | Validate with pilot users first |
| Safe Attachments delays legitimate mail | Mail delivery delay | Use pilot scope and safe validation messages |
| Anti-phishing policy too aggressive | Legitimate messages quarantined | Review impersonation settings and quarantine behavior |
| Quarantine message released incorrectly | Malicious message reaches user | Document admin review workflow before release decisions |
| Real malware or phishing used in testing | Security incident | Use safe validation messages only |
| Private email content exposed in evidence | Privacy issue | Crop or blur message body and sensitive headers |
| Public IP or location exposed in evidence | Privacy issue | Exclude IP/location fields and sanitize screenshots |
| Rollback process missing | Delayed recovery | Document rollback steps before final validation |

## Rollback Principles

Rollback should preserve mail flow first.

Recommended order:

1. Identify the affected policy.
2. Confirm whether the issue affects pilot users only or broader mail flow.
3. Disable or revert the affected pilot policy if needed.
4. Return policy settings to the previous documented state.
5. Validate mail flow with pilot users.
6. Review quarantine and message trace evidence.
7. Document the issue and corrective action.
8. Update the risk register and validation checklist.

## Policy Rollback Examples

| Policy Area | Rollback Action |
|---|---|
| Anti-phishing | Disable pilot policy or remove pilot users from scope |
| Safe Links | Disable pilot Safe Links policy or remove pilot users from scope |
| Safe Attachments | Disable pilot Safe Attachments policy or remove pilot users from scope |
| Anti-spam | Restore previous spam action settings if changed |
| Anti-malware | Restore previous malware action settings if changed |
| Quarantine | Do not release suspicious messages without review |
| Alerts | Document alert behavior before changing alert policy |

## Emergency Access Rule

Emergency access must not be removed or weakened during this project.

Project 08 does not change emergency access configuration.

## Safe Testing Rule

This project will not use:

- Real phishing emails
- Real malware
- Live credential-harvesting links
- External attack infrastructure
- Sensitive mailbox content in screenshots

Use safe validation messages and portal evidence only.

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Message body content
- Message routing headers
- Session metadata
- Device details
- Private mailbox content

## Safety Decisions

This project will not:

- Apply broad tenant-wide changes before pilot validation
- Send real phishing simulations
- Upload real malware
- Expose public IP address fields
- Expose location fields
- Remove emergency access
- Depend on Intune
- Require compliant devices

## Business Value

Rollback planning makes the Defender for Office 365 rollout safer by protecting mail flow, limiting policy scope, preserving emergency access, and documenting recovery actions before policy changes are made.
