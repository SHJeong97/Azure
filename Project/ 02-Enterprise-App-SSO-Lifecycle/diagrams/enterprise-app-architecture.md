# Enterprise App Architecture

```text
On-Prem AD (corp.democompany1016.local)
┌───────────────────────────────────────────────┐
│ OU=Groups                                     │
│ └─ OU=Apps                                    │
│    ├─ GG-App-BusinessPortal-Users             │
│    ├─ GG-App-BusinessPortal-Admins            │
│    └─ GG-App-BusinessPortal-Audit             │
└───────────────────────────────────────────────┘
                    │
                    │ Entra Connect Sync
                    ▼
Microsoft Entra ID
┌───────────────────────────────────────────────┐
│ Synced app access groups                      │
│ Enterprise Application                        │
│ - SSO configuration                           │
│ - Users and groups assignment                 │
│ - Future provisioning scope                   │
└───────────────────────────────────────────────┘
                    │
                    ▼
Business SaaS Application
- Standard user access
- Admin access
- Lifecycle provisioning target
