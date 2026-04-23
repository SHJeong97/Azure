# Enterprise App SSO and Lifecycle Architecture

```text
On-Prem AD
corp.democompany1016.local
┌─────────────────────────────────────────────────────────────┐
│ OU=Groups                                                  │
│ └─ OU=Apps                                                 │
│    ├─ GG-App-BusinessPortal-Users                          │
│    ├─ GG-App-BusinessPortal-Admins                         │
│    └─ GG-App-BusinessPortal-Audit                          │
│                                                             │
│ Direct members added and changed here for JML lifecycle    │
└─────────────────────────────────────────────────────────────┘
                     │
                     │ Microsoft Entra Connect Sync
                     ▼
Microsoft Entra ID
democompany1016.onmicrosoft.com
┌─────────────────────────────────────────────────────────────┐
│ Synced App Groups                                           │
│ Enterprise App: BusinessPortal - Entra SAML Toolkit         │
│ - Owners assigned                                            │
│ - Assignment required                                        │
│ - Visible in My Apps for assigned users                      │
│ - SAML SSO configured                                        │
│ - No out-of-box automatic provisioning in this lab           │
└─────────────────────────────────────────────────────────────┘
                     │
                     ▼
BusinessPortal - Entra SAML Toolkit
┌─────────────────────────────────────────────────────────────┐
│ SSO trust works                                              │
│ Assigned users can sign in                                   │
│ Unassigned users lose Entra assignment visibility            │
│ Local Toolkit account model still exists                     │
│ Downstream deprovisioning is not automatic                   │
└─────────────────────────────────────────────────────────────┘
