
# Project 07 — Privileged Identity Management, Admin Roles, and Access Reviews

## Introduction

This project implements a privileged access governance baseline for Summit Ridge Manufacturing Group using Microsoft Entra Privileged Identity Management, Microsoft Entra admin role inventory, eligible role assignments, PIM activation testing, manual access review documentation, audit monitoring, rollback controls, and privacy-safe evidence handling.

Project 07 builds on the previous portfolio projects:

- Project 04 synchronized selected on-premises Active Directory users into Microsoft Entra ID.
- Project 05 activated Microsoft 365 services for synchronized pilot users.
- Project 06 implemented Conditional Access, MFA enforcement, legacy authentication controls, break-glass exclusions, rollback readiness, and privacy-safe sign-in evidence.
- Project 07 adds privileged access governance and operational controls for administrator access.

The project demonstrates a controlled least-privilege model where privileged access is inventoried, reviewed, activated only when needed, monitored, and protected with rollback procedures.

---

## Objectives

The objectives of Project 07 were to:

- Validate tenant and licensing readiness for privileged access governance.
- Inventory Microsoft Entra privileged role assignments.
- Review standing privileged access.
- Preserve emergency access.
- Configure or confirm PIM eligible role assignments for a pilot user.
- Test PIM activation and deactivation workflow.
- Validate temporary admin access with view-only testing.
- Document access review decisions and portal limitations.
- Export privileged audit logs with sanitized fields.
- Export privileged sign-in logs without public IP or location data.
- Create monitoring scripts for privileged role assignments and emergency access.
- Create operational runbooks and rollback procedures.
- Produce GitHub-ready documentation and evidence.

---

## Full Implementation

Project 07 was implemented across eight batches.

| Batch | Focus | Result |
|---|---|---|
| Batch 1 | Project scope, licensing, governance design, and folder structure | Created project structure, business scenario, privileged access design, PIM rollout plan, risk register, validation checklist, and README skeleton |
| Batch 2 | Tenant readiness, admin role inventory, and privileged access baseline | Validated tenant readiness, exported SKUs, inventoried active role assignments, reviewed standing privilege, and validated emergency access |
| Batch 3 | PIM role settings, eligible assignments, and activation controls | Reviewed PIM role settings, created activation control design, and created or confirmed Sophia Martinez eligible assignments |
| Batch 4 | PIM activation testing and approval/evidence workflow | Tested PIM activation, validated temporary admin access, deactivated active role, and exported activation/audit evidence |
| Batch 5 | Access reviews for privileged groups and admin assignments | Created manual access review evidence due to portal scoping limitations and documented review decisions |
| Batch 6 | Audit logs, monitoring, alerting, and admin activity review | Exported sanitized privileged audit logs, PIM activity, role management logs, sign-in logs, and emergency access monitoring evidence |
| Batch 7 | Rollback, operational controls, and privileged access runbook | Created monitoring scripts, operational runbook, rollback procedure, decision matrix, and operational control matrix |
| Batch 8 | Final validation and GitHub-ready README package | Completed final validation, final evidence exports, architecture/outcome summaries, risk updates, and README preparation |

---

## Implementation Walkthrough

### 1. Project Scope and Governance Design

The project started by creating the Project 07 folder structure and defining the privileged access governance scope.

Created folders included:

```text
projects/07-pim-admin-roles-access-reviews/
projects/07-pim-admin-roles-access-reviews/implementation/
projects/07-pim-admin-roles-access-reviews/scripts/powershell/
projects/07-pim-admin-roles-access-reviews/evidence/screenshots/
projects/07-pim-admin-roles-access-reviews/evidence/command-outputs/
projects/07-pim-admin-roles-access-reviews/data/
```

The project documented:

- Business scenario
- Privileged access design
- PIM rollout plan
- Risk and rollback plan
- Privileged role scope
- Validation checklist
- README skeleton

No privileged assignments were changed in the planning phase.

---

### 2. Tenant Readiness and Admin Role Inventory

The tenant was validated using Microsoft Graph.

Key readiness checks included:

- Microsoft Graph connection
- Tenant organization details
- Tenant SKU export
- PIM license readiness summary
- Target admin account readiness
- Active Microsoft Entra role assignment inventory
- Privileged role inventory summary

Target accounts reviewed:

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator and reviewer |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | PIM activation pilot user |

Target roles reviewed:

| Role | Governance Purpose |
|---|---|
| Global Administrator | Emergency and tenant-wide administration |
| Privileged Role Administrator | Role and PIM administration |
| Security Administrator | Security administration |
| Conditional Access Administrator | Conditional Access policy administration |
| Exchange Administrator | Exchange Online administration |
| User Administrator | User and group administration |
| Helpdesk Administrator | Limited support and password operations |

The admin role inventory established the privileged access baseline before any PIM changes were made.

---

### 3. Emergency Access Validation

Emergency access was reviewed and preserved.

Emergency access account:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

The project documented that emergency access:

- Must remain available for tenant recovery.
- Should not be used for daily administration.
- Should not be removed by access review workflows.
- Should be monitored separately through sign-in logs and role assignment checks.

No emergency access assignment was removed or weakened.

---

### 4. PIM Role Settings and Eligible Assignments

The project reviewed Microsoft Entra PIM role settings and created a controlled eligible assignment pilot.

Pilot user:

```text
sophia.martinez@summitridge-mfg.com
```

Eligible assignments created or confirmed:

| User | Eligible Role | Purpose |
|---|---|---|
| sophia.martinez@summitridge-mfg.com | User Administrator | User and group administration workflow testing |
| sophia.martinez@summitridge-mfg.com | Helpdesk Administrator | Helpdesk and password support workflow testing |

Activation control design:

| Control | Lab Baseline |
|---|---|
| Activation duration | 2 hours recommended |
| MFA on activation | Required where supported |
| Justification | Required |
| Approval | Not required for lab pilot |
| Notifications | Default or documented current state |

Global Administrator and emergency access assignments were not modified.

---

### 5. PIM Activation and Deactivation Testing

Sophia Martinez signed in through Microsoft Entra PIM My Roles to test privileged activation.

Path used:

```text
Microsoft Entra admin center
→ Identity governance
→ Privileged Identity Management
→ My roles
→ Microsoft Entra roles
```

Tested roles:

| Role | Result |
|---|---|
| User Administrator | Eligible but not active during deactivation review |
| Helpdesk Administrator | Activated and deactivated successfully |

The activation test used a lab justification:

```text
Project 07 PIM activation workflow validation
```

Sophia performed view-only validation in the Microsoft Entra user administration area.

No changes were made to:

- Users
- Groups
- Passwords
- Roles
- Conditional Access policies
- Emergency access assignments

After testing, Helpdesk Administrator was deactivated and post-deactivation evidence was exported.

---

### 6. Access Review Governance

The original goal was to create scoped PIM access reviews in the portal.

During testing, the tenant portal did not allow the exact Sophia-only scoped PIM eligible assignment review with the available options. The corrected approach used manual documented access review records.

Manual reviews documented:

| Review | Method | Decision |
|---|---|---|
| AR-P07-PIM-Eligible-Assignments-Sophia | Manual documented review | Approve for lab testing |
| AR-P07-Emergency-Access-Exception | Manual documented review | Approve / preserve |
| AR-P07-Standing-Admin-Access | Manual documented review | Review for future PIM conversion |

Important access review safety decisions:

- No review results were auto-applied.
- No denied access was automatically removed.
- No privileged access was removed.
- Emergency access was preserved.
- Portal limitation was documented clearly.

---

### 7. Audit Monitoring and Admin Activity Review

Privileged access monitoring evidence was exported using sanitized fields.

Monitoring areas:

| Area | Evidence |
|---|---|
| Privileged audit logs | Directory audit logs filtered for role, PIM, eligible, activation, and access review activity |
| PIM activity | PIM-related audit activity and role assignment schedule evidence |
| Role management activity | Role assignment and role management audit events |
| Access review activity | Access review audit activity or documented blank result due to manual review approach |
| Privileged sign-ins | Sign-ins for srmgadmin, emergency access, and Sophia |
| Emergency access sign-ins | Separate emergency access monitoring export |

The project also reviewed audit and sign-in logs in the Microsoft Entra admin center.

All final sign-in and audit exports excluded public IP and location fields.

---

### 8. Operational Controls and Rollback Readiness

The project created operational scripts and rollback documentation.

Scripts created:

| Script | Purpose |
|---|---|
| export-pim-operational-state.ps1 | Exports target account and PIM operational state |
| monitor-privileged-role-assignments.ps1 | Reviews active privileged role assignments |
| monitor-sophia-pim-eligibility.ps1 | Reviews Sophia eligible and active PIM assignments |
| monitor-emergency-access-state.ps1 | Reviews emergency access account and role state |
| export-privileged-signins-sanitized.ps1 | Exports sign-ins without IP or location fields |

Runbook documents created:

| Document | Purpose |
|---|---|
| 10-privileged-access-operational-runbook.md | Defines monitoring, rollback triggers, emergency access rules, and evidence handling |
| 11-pim-rollback-procedure.md | Defines rollback procedures for active assignments, eligible assignments, emergency access issues, and evidence cleanup |
| 12-rollback-operational-controls-summary.md | Summarizes operational controls and rollback readiness |

Rollback triggers documented:

- Emergency access missing or disabled
- Emergency access role assignment missing
- Sophia keeps an active role longer than expected
- Wrong user receives a privileged assignment
- Privileged role is assigned too broadly
- Access review result is applied unexpectedly
- Evidence exposes public IP or location data

No rollback scripts were executed during the project.

---

## Results & Validation

Project 07 successfully created a privileged access governance baseline.

Final results:

| Area | Final Result |
|---|---|
| Tenant readiness | Validated |
| Admin role inventory | Exported |
| Standing privilege | Reviewed |
| Emergency access | Preserved and monitored |
| Sophia PIM eligible assignments | Created or confirmed |
| User Administrator | Eligible assignment confirmed; not active during deactivation review |
| Helpdesk Administrator | Activated and deactivated successfully |
| Access reviews | Manually documented due to portal scoping limitation |
| Privileged audit logs | Exported with sanitized fields |
| Privileged sign-in logs | Exported without IP/location fields |
| Emergency access sign-ins | Exported separately without IP/location fields |
| Monitoring scripts | Created |
| Rollback runbook | Created |
| Privacy-safe evidence | Implemented |

Final project result:

```text
Privileged access governance baseline validated.
```

---

## Validation Walkthrough

Final validation evidence included:

| Evidence | File Type |
|---|---|
| Tenant organization details | TXT |
| Tenant SKUs | TXT / CSV |
| Target admin account state | TXT / CSV |
| Active privileged role assignments | TXT / CSV |
| Sophia eligible assignments | TXT / CSV |
| Sophia active assignments | TXT / CSV |
| PIM activation requests | TXT / CSV |
| PIM activation audit logs | TXT / CSV |
| Access review manual records | TXT / CSV |
| Privileged audit logs | TXT / CSV |
| Privileged sign-in logs | TXT / CSV |
| Emergency access sign-ins | TXT / CSV |
| Final architecture summary | CSV |
| Final privileged access outcomes | CSV |
| Final validation summary | TXT / CSV |
| Risk register updates | CSV |
| Validation checklist updates | CSV |
| Screenshots | PNG |

Key final validation checks:

- Confirmed target admin accounts existed.
- Confirmed emergency access remained preserved.
- Confirmed Sophia eligible PIM assignments existed.
- Confirmed Sophia did not retain unexpected active assignments after activation testing.
- Confirmed privileged audit evidence was exported.
- Confirmed privileged sign-in evidence was exported without IP/location fields.
- Confirmed manual access review method and portal limitation were documented.
- Confirmed rollback and monitoring controls were created.

---

## Privacy-Safe Evidence Handling

Public IP address and location data were intentionally excluded from final evidence.

Fields intentionally excluded:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be sanitized before GitHub upload if they show:

- Public IP address
- Geographic location
- Device details
- Browser details
- Session metadata
- Phone numbers
- QR codes
- Authenticator device details

This privacy rule was applied consistently across privileged sign-in exports, emergency access monitoring, audit review evidence, and final validation documentation.

---

## Repository Structure

Recommended final project structure:

```text
projects/07-pim-admin-roles-access-reviews/
├── README.md
├── data/
│   ├── project-07-final-architecture-summary.csv
│   ├── project-07-final-privileged-access-outcomes.csv
│   ├── project-07-privileged-role-scope.csv
│   ├── project-07-risk-register.csv
│   └── project-07-validation-checklist.csv
├── evidence/
│   ├── command-outputs/
│   ├── screenshots/
│   └── validation-notes/
├── implementation/
│   ├── 01-business-scenario.md
│   ├── 02-privileged-access-design.md
│   ├── 03-pim-rollout-plan.md
│   ├── 04-risk-and-rollback-plan.md
│   ├── 05-tenant-readiness-admin-role-inventory.md
│   ├── 06-pim-role-settings-eligible-assignments.md
│   ├── 07-pim-activation-testing-workflow.md
│   ├── 08-access-review-privileged-access-governance.md
│   ├── 09-audit-monitoring-admin-activity-review.md
│   ├── 10-privileged-access-operational-runbook.md
│   ├── 11-pim-rollback-procedure.md
│   ├── 12-rollback-operational-controls-summary.md
│   └── 13-project-07-final-validation-summary.md
└── scripts/
    └── powershell/
        ├── export-pim-operational-state.ps1
        ├── monitor-privileged-role-assignments.ps1
        ├── monitor-sophia-pim-eligibility.ps1
        ├── monitor-emergency-access-state.ps1
        └── export-privileged-signins-sanitized.ps1
```

---

## Key Takeaways

Project 07 demonstrates practical privileged access governance in Microsoft Entra ID.

Key takeaways:

- Privileged access should be inventoried before changes are made.
- Emergency access must be preserved and monitored separately.
- Standing privilege should be reviewed for future reduction.
- PIM eligible assignments support just-in-time access.
- Activation testing should include deactivation and audit evidence.
- Access reviews should not auto-remove access unless scope and impact are fully validated.
- Manual review documentation is acceptable in a lab when the portal does not support the exact target scope.
- Privileged sign-in and audit evidence should avoid public IP and location exposure.
- Operational runbooks and rollback procedures are required before expanding privileged access governance.

This project supports real-world IAM, Microsoft Entra ID, Microsoft 365 administrator, and cloud security administrator responsibilities by showing controlled privileged access governance, evidence handling, monitoring, and rollback readiness.
