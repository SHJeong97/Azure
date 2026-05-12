# Exchange Online Email Address Planning Result

## Purpose

This document records the Exchange Online email address and alias planning result for Summit Ridge Manufacturing Group.

## Domain

```text
summitridge-mfg.com
```

## Accepted Domain Validation

The domain was checked in Exchange Online accepted domains.

Expected result:

```text
summitridge-mfg.com appears as an accepted domain.
```

## Pilot Users

| User | Planned Primary SMTP |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Planned Alias Model

| Alias Type | Example |
|---|---|
| Primary SMTP | emma.wilson@summitridge-mfg.com |
| Tenant alias | emma.wilson@democompany1016.onmicrosoft.com |
| Legacy/internal reference | emma.wilson@corp.democompany1016.local |

## Validation Performed

Validation included:

- Exchange Online PowerShell module check
- Exchange Online connection validation
- Accepted domain validation
- Current mailbox export
- Pilot mailbox lookup
- Pilot email address planning CSV
- Public MX lookup
- Mail-flow safety documentation

## Important Finding

Update this section based on your validation:

```text
Pilot mailboxes do not exist yet, so this batch remains planning-only.
```

or:

```text
Pilot mailboxes exist in Exchange Online and are ready for future email address validation.
```

## Safety Decision

This batch does not intentionally change MX records.

This batch does not require mailbox email address changes unless pilot mailboxes already exist and the change is intentionally approved.

## Business Risk

Email address changes can affect:

- Mail delivery
- Sender address behavior
- Outlook profiles
- User confusion
- Duplicate proxy address conflicts
- Helpdesk workload

## Risk Treatment

The project reduces risk by:

- Checking accepted domains first
- Checking mailbox existence before applying changes
- Planning primary SMTP and aliases before implementation
- Keeping MX mail-flow changes separate
- Documenting current MX state
- Avoiding broad email changes during planning

## Business Value

This planning creates a clean path for professional email addresses using:

```text
first.last@summitridge-mfg.com
```

while avoiding premature mailbox and mail-flow changes.
