# Risk and Rollback Plan

## Purpose

This document defines the risk and rollback plan for Project 09 Microsoft Purview compliance, DLP, and data governance baseline.

## Key Risks

| Risk | Impact | Treatment |
|---|---|---|
| Purview feature unavailable due to licensing | Configuration cannot be completed as planned | Document limitation and use safe manual evidence |
| Compliance roles missing | Admin cannot configure Purview workloads | Validate required roles before configuration |
| Sensitivity labels published too broadly | Users see unvalidated labels | Publish to pilot users first |
| Sensitivity label model too complex | User confusion and poor adoption | Use simple four-label model |
| DLP policy enforced too early | Legitimate business sharing blocked | Use test mode first |
| DLP policy scoped incorrectly | Wrong users or locations affected | Validate policy scope before testing |
| Retention policy deletes content unexpectedly | Data loss or compliance issue | Avoid destructive retention behavior in lab |
| eDiscovery search exposes private content | Privacy issue | Do not export full search results or previews |
| Audit evidence exposes IP or location | Privacy issue | Exclude IP and location fields |
| Private document or email content exposed | Privacy issue | Crop, blur, or avoid content screenshots |
| Rollback process missing | Policy recovery delayed | Document rollback controls before final validation |

## Rollback Principles

Rollback should preserve data access, avoid destructive actions, and protect private content.

Recommended order:

1. Identify the affected Purview workload.
2. Confirm whether the issue affects pilot users only or broader locations.
3. Stop new compliance policy changes.
4. Disable or remove the pilot-scoped policy only if needed.
5. Return settings to the previous documented baseline.
6. Validate that users and locations are no longer impacted.
7. Export sanitized evidence.
8. Update the risk register and validation checklist.
9. Resume configuration only after validation.

## Sensitivity Label Rollback

Use this if labels are published incorrectly or confuse pilot users.

| Scenario | Rollback Action |
|---|---|
| Wrong labels published | Remove pilot users from label policy or disable label policy |
| Label names incorrect | Rename or recreate labels after documenting the issue |
| Label policy too broad | Restrict label policy to pilot users |
| Label priority wrong | Adjust label order and document final state |

## DLP Rollback

Use this if DLP policy causes unexpected behavior.

| Scenario | Rollback Action |
|---|---|
| DLP blocks business activity | Keep policy in test mode or disable policy |
| DLP scoped to wrong users | Correct user/location scope |
| DLP generates noisy alerts | Tune rule conditions or document as test-mode behavior |
| DLP policy accidentally enforced | Return to test mode immediately |

## Retention Rollback

Retention rollback must be handled carefully because retention policies can affect content lifecycle and deletion behavior.

| Scenario | Rollback Action |
|---|---|
| Retention policy scoped incorrectly | Remove incorrect location scope |
| Retention behavior unclear | Stop and document before applying |
| Deletion behavior configured accidentally | Disable/remove policy if safe and document corrective action |
| Records behavior too restrictive | Do not enable records enforcement until validated |

## Audit and eDiscovery Rollback

| Scenario | Rollback Action |
|---|---|
| Search exposes private content | Stop review, close search, and sanitize evidence |
| Search scope too broad | Narrow search scope to pilot users or safe terms |
| Export started unintentionally | Stop export and do not upload private content to GitHub |
| Screenshot exposes previews | Delete or sanitize screenshot before upload |

## Emergency Access Rule

Emergency access must not be removed or weakened during Project 09.

Project 09 does not change emergency access configuration.

## Safe Testing Rule

This project will not use or export:

- Private document content
- Private email body content
- Full eDiscovery result exports
- Sensitive document previews
- Sensitive message previews
- Full message headers
- Public IP address fields
- Location fields

## Privacy-Safe Evidence Rule

Do not export:

```text
IpAddress
Location
City
State
CountryOrRegion
Private document content
Private email body content
Full eDiscovery result content
Sensitive document previews
Sensitive message previews
Full message headers
```

Screenshots must be cropped or blurred if they show:

- Public IP address
- Location
- Device details
- Session metadata
- Private document text
- Private email body content
- Search result previews
- Sensitive file names
- Message IDs
- Full user activity details

## Safety Decisions

This project will not:

- Apply broad sensitivity label publishing before pilot validation
- Enable DLP full enforcement before test-mode validation
- Create destructive retention behavior without planning
- Export private document or mailbox content
- Export full eDiscovery results
- Remove emergency access
- Depend on Intune
- Require compliant devices
- Export public IP address fields
- Export location fields

## Business Value

Rollback planning makes the Microsoft Purview rollout safer by reducing the risk of user disruption, privacy exposure, over-scoped compliance policies, destructive retention behavior, and inaccurate evidence.
