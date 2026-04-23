# Exchange Online Mail Flow Architecture

```text
Microsoft 365 Tenant
democompany1016.onmicrosoft.com
┌─────────────────────────────────────────────────────────────┐
│ Exchange Online                                             │
│ - User mailboxes                                            │
│ - Shared mailboxes                                          │
│ - Mail flow rules                                           │
│ - Mail hygiene controls                                     │
│ - Message trace / validation                                │
└─────────────────────────────────────────────────────────────┘
               ▲
               │
       Synced identities and groups
               │
┌─────────────────────────────────────────────────────────────┐
│ On-Prem AD / Hybrid Identity Foundation                     │
│ - Department groups                                         │
│ - Named admin accounts                                      │
│ - Existing user population                                  │
└─────────────────────────────────────────────────────────────┘
