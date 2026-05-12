# Exchange Online Email Address and Alias Plan

## Purpose

This document defines the planned Exchange Online email address and alias strategy for Summit Ridge Manufacturing Group.

## Public Domain

```text
summitridge-mfg.com
```

## Current Tenant Domain

```text
democompany1016.onmicrosoft.com
```

## Internal AD DS Domain

```text
corp.democompany1016.local
```

## Pilot Users

| User | Department | Planned Primary SMTP |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Planned Alias Strategy

Each pilot user should eventually have:

| Address Type | Example |
|---|---|
| Primary SMTP | emma.wilson@summitridge-mfg.com |
| Microsoft tenant alias | emma.wilson@democompany1016.onmicrosoft.com |
| Legacy/internal reference alias | emma.wilson@corp.democompany1016.local |

## Important Design Note

The UPN and primary SMTP address are related but not always the same thing.

The UPN is mainly used for sign-in.

The primary SMTP address is used as the main email sending address.

For a clean Microsoft 365 user experience, the company wants both to eventually match:

```text
first.last@summitridge-mfg.com
```

## Mailbox Dependency

Email address changes can only be applied to Exchange Online mailboxes if the users have cloud mailboxes.

If pilot users do not exist in Microsoft 365 or do not have Exchange Online mailboxes yet, this batch documents the plan only.

## Mail Flow Safety

MX records control inbound mail routing.

This batch does not intentionally change MX records.

If Microsoft and GoDaddy auto-created the MX record during domain setup, that condition is documented separately in the mail-flow safety evidence.

## Business Risk

Incorrect email address changes can cause:

- Mail delivery problems
- Duplicate address conflicts
- Confusing sender addresses
- Outlook profile issues
- User support tickets
- Incorrect reply-to behavior

## Risk Treatment

The project reduces risk by:

- Planning addresses before applying changes
- Validating accepted domains first
- Checking whether pilot mailboxes exist
- Separating UPN changes from email address changes
- Avoiding broad mailbox changes
- Documenting MX state separately

## Business Value

A clean email address and alias plan prepares the company for professional communication using:

```text
first.last@summitridge-mfg.com
```

while preserving migration flexibility and rollback awareness.
