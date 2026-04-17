# Solution Design

## Project Scope
This project implements a cloud-only identity and access baseline for a 75-user Microsoft 365 company.

## Core Design Decisions
- Use Microsoft 365 Business Premium as the primary licensing baseline.
- Use department-based groups to standardize access assignment.
- Use group-based licensing instead of manual per-user assignment.
- Use Conditional Access to enforce stronger sign-in controls.
- Use self-service password reset to reduce help desk dependency.
- Use role separation to reduce reliance on Global Administrator.
- Reserve advanced governance features as an optional expansion path.

## Features in Scope
- Test users
- Security groups
- Dynamic groups where appropriate
- Group-based licensing
- Basic admin role separation
- MFA / Conditional Access baseline
- SSPR rollout
- Validation evidence

## Features Reserved for Optional Expansion
- PIM
- Access Reviews
- Lifecycle Workflows
