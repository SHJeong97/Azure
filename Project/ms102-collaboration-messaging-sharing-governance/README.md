# Microsoft 365 Collaboration, Messaging, and External Sharing Governance for a 200-User Company

**Platform:** Microsoft 365 + Microsoft Entra ID  
**Focus Areas:** MS-102, Exchange Online, SharePoint Online, Microsoft Teams, Shared Mailboxes, External Sharing, Admin Role Separation

## Introduction
This project implements a Microsoft 365 collaboration, messaging, and external sharing governance model for a fictional 200-user company named Summit Advisory Services.

The goal was to build a cleaner Microsoft 365 service-administration model across Exchange Online, SharePoint Online, Microsoft Teams, and the Microsoft 365 admin center. The project focused on workload-specific administration, shared mailbox governance, distribution-group governance, collaboration resource ownership, and controlled external sharing.

The implementation used a pilot scope with workload admins, department users, shared mailboxes, Teams, SharePoint communication sites, and one approved external-sharing path so the tenant could be validated without overbuilding the environment.

## Objectives
- Standardize Microsoft 365 collaboration and messaging resource administration
- Separate Exchange, SharePoint, Teams, and read-only oversight roles
- Use group-based licensing for the pilot users
- Create governed shared mailboxes and a distribution group
- Create department Teams and SharePoint sites with business ownership
- Control external sharing through an approved pilot path
- Validate workload-specific administration and delegated mailbox behavior with evidence

## Full Implementation
The project was built in six major stages.

First, the company scenario, collaboration governance model, workload scope, external sharing strategy, admin role model, and validation plan were documented before implementation began.

Second, the pilot foundation was created. Eight pilot users were created, collaboration groups were created, Microsoft 365 E3 was assigned through a dedicated pilot license group, workload-specific admin roles were assigned, four shared mailboxes were created, and a distribution group was created.

Third, the collaboration resource layer was built. Four private department Teams were created, four SharePoint communication sites were created, business ownership was assigned to each resource, and the distribution group membership baseline was completed.

Fourth, mailbox delegation and external sharing controls were configured. Shared mailbox access was assigned according to department role and business need, SharePoint organization-level sharing was configured for a controlled pilot, Sales Site was designated as the approved external-sharing site, the remaining department sites stayed internal-only, and Teams guest access was enabled.

Fifth, the service-admin model was validated end to end. Exchange Administrator, SharePoint Administrator, Teams Administrator, and Global Reader access were each validated in their respective admin centers. Shared mailbox behavior was also validated with the department users to confirm that delegated access matched the intended permission model.

Finally, all evidence was organized into screenshots, outputs, and validation notes so the project could be reviewed as a complete Microsoft 365 administration and governance implementation.

## Implementation Walkthrough

### 1. Planned the Microsoft 365 governance model
The project began by documenting the business problem, workload boundaries, pilot scope, external sharing strategy, and validation standard before any users or resources were created.

### 2. Built the pilot identity and mail foundation
Eight pilot users were created:
- Ava Foster
- Ethan Walker
- Rachel Kim
- Mason Lee
- Emma Reed
- Olivia Chen
- Grace Miller
- Henry Cole

Pilot groups were also created:
- `SG-LIC-M365-E3-PILOT`
- `SG-DEPT-FINANCE-COLLAB`
- `SG-DEPT-OPERATIONS-COLLAB`
- `SG-DEPT-HR-COLLAB`
- `SG-DEPT-SALES-COLLAB`
- `SG-PILOT-EXTERNAL-SHARING`

Microsoft 365 E3 was assigned through `SG-LIC-M365-E3-PILOT`. Specialist admin roles were then assigned:
- Ava Foster -> Exchange Administrator
- Ethan Walker -> SharePoint Administrator
- Rachel Kim -> Teams Administrator
- Mason Lee -> Global Reader

Four shared mailboxes and one distribution group were also created:
- Finance Shared
- Operations Shared
- HR Shared
- Sales Shared
- All Staff Updates

### 3. Built collaboration resources
Four private Teams were created:
- Finance Team
- Operations Team
- HR Team
- Sales Team

Four SharePoint communication sites were created:
- Finance Site
- Operations Site
- HR Site
- Sales Site

Business ownership was aligned to department users:
- Emma Reed -> Finance
- Olivia Chen -> Operations
- Grace Miller -> HR
- Henry Cole -> Sales

### 4. Configured mailbox delegation and external sharing
Shared mailbox delegation was configured with intentional differences:
- Finance Shared -> Emma Reed -> Full Access + Send As
- Operations Shared -> Olivia Chen -> Full Access
- HR Shared -> Grace Miller -> Full Access
- Sales Shared -> Henry Cole -> Full Access + Send As

External sharing was then configured through a controlled SharePoint model:
- organization-level SharePoint sharing allowed a controlled guest pilot
- Sales Site was set to allow external sharing
- Finance Site, Operations Site, and HR Site remained internal-only
- Teams guest access was enabled for the tenant baseline
- one external guest invitation path was validated for Sales Site only

### 5. Validated workload-specific administration
Each specialist admin validated the workload they were meant to own:
- Ava accessed Exchange admin center and reviewed mailbox and group objects
- Ethan accessed SharePoint admin center and reviewed site membership and sharing views
- Rachel accessed Teams admin center and reviewed team ownership and membership
- Mason accessed the main admin centers in a read-only oversight pattern

### 6. Validated delegated mailbox behavior
Department users were then used to validate shared mailbox behavior:
- Emma opened Finance Shared and validated Send As behavior
- Henry opened Sales Shared and validated Send As behavior
- Olivia opened Operations Shared with Full Access only
- Grace opened HR Shared with Full Access only

This proved the delegated mailbox model aligned to the intended business pattern instead of applying the same access everywhere.

## Results & Validation

### Pilot Foundation Results
- 8 pilot users were created successfully
- collaboration and licensing groups were created successfully
- Microsoft 365 E3 was assigned through `SG-LIC-M365-E3-PILOT`
- workload-specific admin roles were assigned correctly
- 4 shared mailboxes were created
- 1 distribution group was created

### Collaboration Resource Results
- 4 private department Teams were created
- 4 department SharePoint communication sites were created
- department ownership was assigned to each Team and site
- the All Staff Updates distribution group was populated with the pilot users

### Delegation and Sharing Results
- mailbox delegation was assigned according to business need
- Finance Shared and Sales Shared included Send As
- Operations Shared and HR Shared were limited to Full Access
- SharePoint org-level sharing supported a restricted external-sharing pilot
- Sales Site was externally shareable
- Finance, Operations, and HR sites remained internal-only
- Teams guest access was enabled

### Workload Validation Results
- Exchange Administrator access was validated
- SharePoint Administrator access was validated
- Teams Administrator access was validated
- Global Reader oversight was validated
- delegated mailbox behavior was validated with the pilot department users

### Evidence Files
Key evidence for this project is stored in:
- `evidence/screenshots/`
- `evidence/cli-output/`
- `evidence/validation-notes/`

Representative evidence includes:
- `group-sg-lic-m365-e3-pilot-license-project4.png`
- `exchange-shared-mailboxes-list-project4.png`
- `exchange-distribution-group-all-staff-updates-project4.png`
- `teams-manage-teams-list-project4.png`
- `sharepoint-active-sites-project4.png`
- `sharepoint-sales-site-sharing-settings-project4.png`
- `teams-guest-access-settings-project4.png`
- `ava-exchange-admin-center-project4.png`
- `ethan-sharepoint-admin-center-project4.png`
- `rachel-teams-admin-center-project4.png`
- `mason-global-reader-m365-admin-project4.png`
- `emma-finance-shared-sendas-project4.png`
- `henry-sales-shared-sendas-project4.png`

## Validation Walkthrough

### Foundation validation
The pilot foundation was validated by confirming:
- all 8 users existed
- collaboration groups existed and contained the intended users
- Microsoft 365 E3 was inherited through the pilot license group
- specialist admin roles were assigned correctly
- shared mailboxes and the distribution group existed

### Collaboration resource validation
The collaboration layer was validated by confirming:
- all 4 Teams existed and were private
- each Team had the correct department owner
- all 4 SharePoint communication sites existed
- each site had the correct owner
- the All Staff Updates distribution group had the full pilot membership baseline

### Delegation and sharing validation
The delegation and sharing layer was validated by confirming:
- mailbox permissions matched the planned role model
- SharePoint organization-level sharing was configured for a controlled pilot
- Sales Site allowed external sharing
- Finance, Operations, and HR sites remained internal-only
- Teams guest access was enabled
- an external guest invitation path existed for Sales Site only

### Workload admin validation
The service-admin model was validated by confirming:
- Ava could manage Exchange objects in Exchange admin center
- Ethan could manage site views and sharing views in SharePoint admin center
- Rachel could manage Teams views in Teams admin center
- Mason could review the major admin centers in a read-only capacity

### Delegated mailbox validation
The delegated mailbox model was validated by confirming:
- Emma could open Finance Shared and use Send As
- Henry could open Sales Shared and use Send As
- Olivia could open Operations Shared
- Grace could open HR Shared
- Send As was only validated where it had been intentionally assigned

### Validation approach
Each major Microsoft 365 workload control produced screenshots and written validation notes. The project was documented as a governed Microsoft 365 admin design rather than just a collection of created objects.

## Key Takeaways
- Microsoft 365 administration is stronger when workload roles are separated by service
- Shared mailbox access should be intentional and not identically assigned across every mailbox
- Collaboration resources need business ownership to avoid orphaned Teams and sites
- External sharing should be approved by scope, not left broadly open
- Teams, SharePoint, Exchange, and the Microsoft 365 admin center all need to be governed together for a realistic MS-102 administration model
- Strong portfolio work shows resource creation, workload governance, validation, and business reasoning together
