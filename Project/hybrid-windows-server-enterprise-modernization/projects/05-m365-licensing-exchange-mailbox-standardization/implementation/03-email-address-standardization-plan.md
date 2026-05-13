# Email Address Standardization Plan

## Purpose

This document defines the planned email address standardization approach for the Microsoft 365 pilot users.

## Domain

The verified public domain is:

```text
summitridge-mfg.com
```

## Current Identity State

The pilot users were synchronized from on-premises Active Directory to Microsoft Entra ID using Microsoft Entra Cloud Sync.

| User | Cloud UPN |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Target Email Standard

The target primary SMTP format is:

```text
first.last@summitridge-mfg.com
```

## Pilot Email Address Plan

| User | Target Primary SMTP | Tenant Alias | Legacy/Internal Reference |
|---|---|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com | emma.wilson@democompany1016.onmicrosoft.com | emma.wilson@corp.democompany1016.local |
| Olivia Brown | olivia.brown@summitridge-mfg.com | olivia.brown@democompany1016.onmicrosoft.com | olivia.brown@corp.democompany1016.local |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com | sophia.martinez@democompany1016.onmicrosoft.com | sophia.martinez@corp.democompany1016.local |

## UPN vs Primary SMTP

The UPN is used primarily for sign-in.

The primary SMTP address is the main email sending address.

For a clean user experience, the project target is for both values to match:

```text
first.last@summitridge-mfg.com
```

## Why Standardization Matters

Consistent UPN and email address formats reduce:

- User confusion
- Helpdesk tickets
- Outlook profile issues
- Incorrect sender addresses
- Reply-to confusion
- Mail routing mistakes

## Implementation Rule

Do not change primary SMTP addresses until Exchange Online mailboxes exist.

Mailbox provisioning must be validated first.

## Safety Decisions

The project will not:

- Apply broad email address policies
- Change all users at once
- Remove existing aliases before mail flow is validated
- Assume mailboxes exist before checking Exchange Online
- Modify MX records during licensing validation

## Business Risk

Incorrect address standardization can cause:

- Mail delivery failures
- Duplicate proxy address conflicts
- Incorrect outbound sender address
- User confusion during migration
- Support escalation

## Risk Treatment

The project reduces risk by:

- Starting with three pilot users
- Validating mailbox creation before address changes
- Exporting current mailbox addresses
- Checking proxy addresses
- Standardizing one pilot group first
- Keeping rollback notes

## Business Value

Standardized email addresses create a professional communication experience for the company and prepare the organization for broader Microsoft 365 adoption.
