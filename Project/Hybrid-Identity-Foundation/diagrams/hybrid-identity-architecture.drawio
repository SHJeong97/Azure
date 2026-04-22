# Hybrid Identity Architecture Diagram

```text
Personal Azure Subscription
┌─────────────────────────────────────────────────────────────┐
│ Resource Group: rg-hybrid-identity-lab                     │
│                                                             │
│ VNet: vnet-hybrid-identity (10.10.0.0/16)                  │
│ Subnet: snet-core (10.10.1.0/24)                           │
│                                                             │
│   ┌──────────────────────┐      ┌──────────────────────┐    │
│   │ ADC-01               │      │ MGMT-01              │    │
│   │ 10.10.1.10           │      │ 10.10.1.20           │    │
│   │ AD DS + DNS          │◄────►│ RSAT + Entra Connect │    │
│   │ corp.democompany...  │      │ Member Server        │    │
│   └──────────────────────┘      └──────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                     │
                     │ Microsoft Entra Connect Sync
                     ▼
Microsoft 365 / Entra Tenant
democompany1016.onmicrosoft.com
┌─────────────────────────────────────────────────────────────┐
│ Microsoft Entra ID                                          │
│ - Synced pilot users                                        │
│ - Synced department / licensing / role groups               │
│ - Cloud-only emergency access accounts                      │
│ - Role assignments                                          │
│ - Conditional Access                                        │
│ - SSPR                                                      │
│ - Password writeback                                        │
│                                                             │
│ Microsoft 365                                               │
│ - Group-based licensing                                     │
│ - Admin governance                                          │
└─────────────────────────────────────────────────────────────┘
