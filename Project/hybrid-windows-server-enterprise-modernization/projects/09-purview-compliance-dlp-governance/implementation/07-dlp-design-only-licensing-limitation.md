# DLP Design-Only and Licensing Limitation

## Purpose

This document records the Project 09 Data Loss Prevention design, licensing limitation, and final decision to skip hands-on DLP policy configuration.

## Project Context

Project 09 builds the final Microsoft Purview compliance, DLP, and data governance baseline for the portfolio project series.

Batch 4 originally planned to configure a Microsoft Purview DLP policy in test mode. During implementation, hands-on DLP configuration was skipped because the lab tenant did not use the additional licensing or cost required for the desired DLP capabilities.

## Final DLP Decision

| Area | Final Decision |
|---|---|
| DLP hands-on configuration | Skipped |
| Reason | Additional licensing/cost not used for this lab |
| DLP policy created | No |
| DLP rules created | No |
| DLP test mode enabled | No |
| DLP full enforcement enabled | No |
| DLP alerts generated | No |
| Sensitive values uploaded | No |
| Private content exported | No |

## DLP Design Matrix

The project still documented a DLP design for future implementation.

| Control Area | Intended Control | Hands-On Configured | Reason |
|---|---|---|---|
| Financial data | Detect financial sensitive information | No | Licensing/cost limitation |
| Employee data | Detect employee-sensitive information | No | Licensing/cost limitation |
| External sharing | Review risky outbound sharing behavior | No | Licensing/cost limitation |
| DLP alerts | Review DLP alert workflow | No | No DLP policy or alert generated |
| Evidence privacy | Avoid private content exposure | Yes, documentation control | Evidence sanitized |

## Intended Future DLP Policy

If licensing is available later, the intended policy would be:

| Item | Intended Configuration |
|---|---|
| Policy name | P09-Pilot-DLP-TestMode |
| Initial mode | Test/simulation mode |
| Target locations | Exchange, SharePoint, and OneDrive where available |
| Target users | Emma Wilson, Olivia Brown, Sophia Martinez |
| Sensitive information types | Credit Card Number, U.S. Social Security Number |
| Enforcement | No blocking during pilot validation |
| Evidence | Policy state, alerts, and safe validation notes only |

## What Was Completed

Batch 4 completed the following safely:

- DLP design matrix created
- Existing DLP baseline exported if available
- DLP portal area reviewed
- DLP licensing limitation documented
- DLP design-only summary created
- DLP design-only control matrix created
- DLP README accuracy note created
- Revised DLP limitation summary created

## What Was Not Completed

Batch 4 did not complete hands-on DLP configuration.

The project did not:

- Create a DLP policy
- Create DLP rules
- Enable DLP test mode
- Enable DLP full enforcement
- Generate DLP alerts
- Upload sensitive test values
- Use real or synthetic financial records for detection testing
- Use real or synthetic HR records for detection testing

## README Accuracy Requirement

The final README must describe DLP as **design-only**.

Acceptable wording:

```text
DLP policy design was created, but hands-on DLP policy configuration was skipped due to licensing/cost constraints. No DLP policy, DLP rule, DLP test-mode validation, DLP alert, or DLP enforcement result is claimed.
```

Do not claim:

- DLP policy was configured
- DLP rules were created
- DLP test mode was enabled
- DLP alerts were generated
- DLP enforcement was validated
- Sensitive information detections were tested hands-on

## Privacy-Safe Evidence Handling

The following data was not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
Private document content
Private email body content
Sensitive values
DLP match details
Search result previews
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
- Sensitive values
- Search result previews
- Sensitive file names
- Message IDs
- Full user activity details

## Safety Decisions

This batch did not:

- Create DLP policies
- Create DLP rules
- Enable DLP test mode
- Enable DLP enforcement
- Upload sensitive values
- Export private document content
- Export private email body content
- Export public IP address fields
- Export location fields

## Business Risk

DLP policies can affect business workflows if configured incorrectly or enforced too early.

Poorly scoped DLP policies may block legitimate email, restrict file sharing, generate noisy alerts, or expose sensitive information during validation.

## Risk Treatment

The project reduced risk by documenting DLP as design-only, avoiding unsupported paid configuration, avoiding private content exposure, and clearly stating the limitation in final evidence and README documentation.

## Business Value

This batch demonstrates responsible compliance project scoping.

Rather than overstating implementation, the project documents a realistic DLP design, acknowledges licensing limitations, avoids unnecessary cost, and preserves portfolio accuracy.
