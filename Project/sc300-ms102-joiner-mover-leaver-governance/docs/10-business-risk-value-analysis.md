# Business Risk and Value Analysis

## Problem Being Solved
Crestview Manufacturing Services lacked a standardized joiner-mover-leaver process. User onboarding, internal access changes, and offboarding were too manual and too dependent on individual memory.

## Business Risks in the Original State
- new hires may not receive the correct access on time
- movers may retain old department access after role changes
- leavers may remain licensed or retain resource access longer than intended
- support and admin effort increases because access changes are handled case by case
- audit evidence is weak because lifecycle actions are not documented consistently

## Why the Solution Matters
This project creates a repeatable lifecycle model where identity, licensing, group access, and shared resource access are updated in a controlled sequence.

## Cost of Getting It Wrong
If lifecycle governance remains manual:
- onboarding delays reduce productivity
- privilege creep increases over time
- offboarding failures increase access risk
- unnecessary licenses stay assigned
- audit remediation takes longer and costs more administrative time

## Value Created by This Design
- standardized onboarding through defined access paths
- controlled mover handling that removes old access
- consistent offboarding focused on containment first
- clearer evidence for reviews and audits
- lower operational dependence on tribal knowledge

## First-Principles Logic
Identity is the access control plane for Microsoft 365. If identity lifecycle handling is inconsistent, every downstream access decision becomes weaker. Standardizing joiner, mover, and leaver operations improves both security and operational reliability.
