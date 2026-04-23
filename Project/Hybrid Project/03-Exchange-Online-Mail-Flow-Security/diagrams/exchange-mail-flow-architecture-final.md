# Exchange Online Mail Flow Security Architecture

```text
Microsoft 365 Tenant
democompany1016.onmicrosoft.com
┌─────────────────────────────────────────────────────────────┐
│ Exchange Online                                             │
│ - User mailboxes                                            │
│ - Shared mailboxes                                          │
│   - hr@democompany1016.onmicrosoft.com                      │
│   - finance@democompany1016.onmicrosoft.com                 │
│   - operations@democompany1016.onmicrosoft.com              │
│                                                             │
│ Mail Flow Rules                                             │
│ - MF01-Tag-External-Inbound-Mail                            │
│ - MF02-Warn-External-Mail-To-Shared-Mailboxes              │
│ - MF03-Block-Inbound-Executable-Attachments                 │
│                                                             │
│ Microsoft Defender for Office 365 / EOP                     │
│ - DP01-Exec-SharedMailbox-AntiPhish                         │
│ - DP02-SharedMailbox-Inbound-AntiSpam                       │
│ - Default anti-malware policy                               │
└─────────────────────────────────────────────────────────────┘
                     ▲
                     │
                     │ Synced users and groups from hybrid identity
                     │
┌─────────────────────────────────────────────────────────────┐
│ Hybrid Identity Foundation                                  │
│ - Existing synced users                                     │
│ - Named admin accounts                                      │
│ - Department-based access model                             │
└─────────────────────────────────────────────────────────────┘
