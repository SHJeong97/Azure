# License Check

## Evidence Source
License inventory was reviewed in the Microsoft 365 admin center and captured in:

- `evidence/screenshots/license-overview.png`

## Observed Tenant License Inventory

| Product | Total Seats Observed | Assigned | Available | Notes |
|---|---:|---:|---:|---|
| Microsoft 365 E3 | 25 | 1 | 24 | Enterprise productivity and identity baseline for standard users |
| Microsoft 365 E5 | 25 | 0 | 25 | Higher-tier enterprise license available in tenant but not currently assigned |
| Microsoft 365 E5 (no Teams) | 25 | 0 | 25 | Alternate E5 SKU available in tenant but not currently assigned |
| Microsoft Entra ID P2 | 25 | 1 | 24 | Advanced identity/security license available for scoped users |

## Initial Interpretation
This tenant has more licensing capability than the original Business Premium baseline assumed for the project.

The current screenshot confirms:
- At least one Microsoft 365 E3 license is assigned.
- At least one Microsoft Entra ID P2 license is assigned.
- Microsoft 365 E5 and Microsoft 365 E5 (no Teams) licenses are present but currently unassigned.
- The screenshot alone does not confirm whether the E3-assigned user and the P2-assigned user are the same account.

## Project Impact

### Features Allowed for This Project Now
The following project features are in scope for the lab implementation:
- Cloud-only user and group deployment
- Department-based security groups
- Group-based licensing
- Dynamic group design
- Conditional Access baseline policies
- MFA rollout for scoped users
- Self-service password reset for scoped users
- Administrative role separation
- Pilot use of advanced P2-backed identity controls for selected accounts

### Features That Can Be Demonstrated with Available Licensing
Because this tenant has E3, E5, and P2 inventory available, the portfolio can support:
- Standard user implementation on Microsoft 365 E3
- Advanced admin or high-risk user scenarios using Microsoft Entra ID P2
- Optional premium testing with Microsoft 365 E5 or Microsoft 365 E5 (no Teams) if needed for later expansion

### Features Not Yet Confirmed for Broad Use
The following items should be treated as out of scope unless separately validated or added:
- Company-wide use of advanced governance workflows across a full 75-user population
- Broad access review or lifecycle workflow implementation without confirming Governance coverage
- Any design that assumes all 75 modeled users are fully licensed in this tenant at the premium tier

## Lab Design Decision
This portfolio will represent a **75-user company design** but implement a **12-user pilot** in the tenant.

That decision is intentional:
- It keeps the lab realistic for a small-to-mid-size company scenario.
- It avoids overbuilding unnecessary objects.
- It allows the project to prove architecture, policy logic, access design, and validation quality without requiring 75 actual test accounts.

## Licensing Strategy for This Portfolio
The implementation will use:
- **Microsoft 365 E3** as the standard employee baseline for most test users
- **Microsoft Entra ID P2** for selected admin or advanced security demonstration accounts
- **Microsoft 365 E5 / E5 (no Teams)** only if later project phases need additional premium Microsoft 365 security or compliance capabilities

## Portfolio Scope Decision
Based on the observed licensing, the project can proceed without waiting for additional subscriptions.

Approved for next phase:
- User creation
- Group creation
- Group-based license design
- Conditional Access baseline planning
- SSPR planning
- Role separation design

Deferred unless specifically added later:
- Full governance-heavy expansion project
- Large-scale access review program
- Lifecycle workflow-driven joiner/mover/leaver automation for the full modeled company

## Validation Note
License inventory was checked before implementation to ensure the project design matches actual tenant capability rather than assumed subscription capability.
