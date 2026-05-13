# Mail Flow and Outlook/Autodiscover Readiness

## Purpose

This document records mail-flow validation and Outlook/Autodiscover readiness for the Microsoft 365 pilot mailboxes.

## Domain

```text
summitridge-mfg.com
```

## Pilot Users

| User | Mailbox |
|---|---|
| Emma Wilson | emma.wilson@summitridge-mfg.com |
| Olivia Brown | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | sophia.martinez@summitridge-mfg.com |

## Validation Scope

This batch validated:

- Public mail DNS readiness
- Exchange Online accepted domain state
- Pilot mailbox readiness
- Outlook on the web access readiness
- Internal mail-flow test messages
- Exchange Online message trace
- Post-mail-flow mailbox statistics

## DNS Validation

The following DNS records were checked:

| Record | Purpose |
|---|---|
| MX | Routes inbound mail to Microsoft 365 |
| SPF | Authorizes Microsoft 365 to send mail for the domain |
| DMARC | Provides domain-level email authentication monitoring |
| Autodiscover | Allows Outlook clients to discover Exchange Online mailbox settings |

## Exchange Online Validation

The domain was validated as an Exchange Online accepted domain.

The pilot users were validated as Exchange Online mailboxes.

Expected mailbox state:

```text
RecipientTypeDetails = UserMailbox
PrimarySmtpAddress = first.last@summitridge-mfg.com
```

## Outlook on the Web Readiness

Outlook on the web access was tested for the pilot users when credentials were available.

If a pilot user could not sign in, the test was documented as pending or blocked by password/sign-in readiness.

## Password Note

Pilot users are synchronized from on-premises Active Directory.

Because Cloud Sync password hash sync is enabled, pilot users sign in with their on-premises AD password after password hash synchronization completes.

## Internal Mail Flow Tests

Planned mail-flow tests:

| Test ID | Sender | Recipient | Purpose |
|---|---|---|---|
| MF-001 | emma.wilson@summitridge-mfg.com | olivia.brown@summitridge-mfg.com | Internal pilot mail flow |
| MF-002 | olivia.brown@summitridge-mfg.com | emma.wilson@summitridge-mfg.com | Reverse internal pilot mail flow |
| MF-003 | Admin mailbox | sophia.martinez@summitridge-mfg.com | Admin-to-pilot readiness |

## Message Trace Validation

Message trace was reviewed using Exchange Online PowerShell.

Expected successful result:

```text
Status = Delivered
```

Message trace results may take several minutes to appear after a message is sent.

## DKIM Note

DKIM remains a future action unless selector CNAME records are created and DKIM is enabled for the domain.

The project does not treat missing DKIM selectors as a mailbox provisioning failure.

## Safety Decisions

The project did not:

- Modify MX records during this batch
- Change mailbox addresses during mail-flow testing
- Apply broad transport rules
- Enable DKIM without required selector records
- Move DMARC from monitoring to enforcement

## Business Risk

Mail-flow issues can cause:

- Failed delivery
- Incorrect sender identity
- Outlook connection issues
- Helpdesk tickets
- User confusion after mailbox rollout

## Risk Treatment

The project reduced risk by validating DNS, accepted domain state, mailbox readiness, message trace, and mailbox statistics before expanding beyond the pilot group.

## Business Value

This batch proves that licensed and mailbox-enabled pilot users can support Microsoft 365 messaging readiness using the company’s verified public domain.
