# Architecture Decisions

## Decision 1: Use Azure-hosted IaaS VMs instead of local virtualization
Reason:
This reduces home-lab dependency and makes the project portable, repeatable, and easier to document.

Business impact:
The design simulates a cloud-hosted infrastructure pattern that many small companies use when they do not maintain a physical server room.

## Decision 2: Use single forest / single domain
Reason:
This is the simplest realistic topology for a 75-user company and aligns with a common supported hybrid identity pattern.

Business impact:
Lower complexity, lower admin overhead, easier troubleshooting.

## Decision 3: Use Password Hash Sync instead of Pass-Through Authentication for the first project
Reason:
This keeps the environment simpler and more resilient for a small company lab while still supporting hybrid identity.

Business impact:
Lower infrastructure dependency during sign-in, easier support model, faster implementation.

## Decision 4: Use E5 only for privileged/admin test accounts
Reason:
This controls licensing consumption while still allowing demonstration of higher-value security controls.

Business impact:
Better cost efficiency while preserving security coverage where risk is highest.

## Decision 5: Accept lab simplification of one domain controller
Reason:
This is not production-grade high availability, but it is cost-effective for a portfolio lab.

Business impact:
Good enough to demonstrate design and implementation capability.
Production gap:
A real environment should normally use multiple domain controllers and stronger resiliency controls.
