# Project 01 Architecture Diagram

```text
Azure Subscription
└── rg-srmg-hybrid-core
    └── vnet-srmg-hybrid-eastus - 10.10.0.0/16
        │
        ├── snet-domain-controllers - 10.10.1.0/24
        │   ├── DC01 - 10.10.1.10
        │   │   ├── AD DS
        │   │   ├── DNS
        │   │   └── Global Catalog
        │   │
        │   └── DC02 - 10.10.1.11
        │       ├── AD DS
        │       ├── DNS
        │       └── Global Catalog
        │
        ├── snet-management - 10.10.2.0/24
        │   └── MGMT01 - 10.10.2.10
        │       ├── Domain joined
        │       ├── RSAT AD DS tools
        │       ├── DNS Manager
        │       └── Group Policy Management
        │
        ├── snet-member-servers - 10.10.3.0/24
        │   ├── FS01 - Future file server
        │   └── APP01 - Future internal app server
        │
        └── snet-workstations - 10.10.4.0/24
            └── WIN11-CL01 - Future endpoint validation

## Identity Namespace
Internal AD DS domain:
corp.democompany1016.local

NetBIOS:
CORP

Current cloud tenant:
democompany1016.onmicrosoft.com

Future public domain:
summitridge-mfg.com

Future user sign-in:
first.last@summitridge-mfg.com

## DNS Design
Internal DNS:
DC01 and DC02 using AD-integrated DNS

External DNS:
Future managed public DNS provider for summitridge-mfg.com

Rejected:
Public Windows DNS server exposed to the internet
