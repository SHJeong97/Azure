# Architecture Decisions

## Decision 1: Use Azure-hosted VMs instead of local virtualization
Reason:
This avoids dependency on local hardware and creates a more portable and repeatable lab.

Business outcome:
Lower build friction and easier evidence collection for a portfolio project.

## Decision 2: Use a single forest and single domain
Reason:
This is realistic for a 75-user company and avoids unnecessary complexity.

Business outcome:
Lower administrative overhead and simpler troubleshooting.

## Decision 3: Use separate Azure infrastructure hosting and Microsoft 365 tenant identity target
Reason:
The company tenant does not have Azure subscription access, but a personal Azure subscription is available for infrastructure hosting.

Business outcome:
Enables low-cost lab infrastructure without blocking hybrid identity implementation.

Lab note:
Azure resources exist in a personal subscription, while identity synchronization targets democompany1016.onmicrosoft.com.

Production gap:
A production company would normally prefer organization-owned Azure subscriptions aligned to the same tenant for governance, billing, and access control consistency.

## Decision 4: Start with Password Hash Sync
Reason:
This is simpler than more infrastructure-dependent options and is appropriate for a small hybrid environment.

Business outcome:
Faster deployment, fewer moving parts, simpler support model.

## Decision 5: Use one domain controller for the portfolio lab
Reason:
This is a lab simplification to reduce cost.

Business outcome:
Sufficient to demonstrate implementation skill.

Production gap:
A real company should normally use more than one domain controller for resiliency.

## Decision 6: Use E5 capabilities only for a limited privileged/admin subset
Reason:
Higher-value security features should be demonstrated where risk is highest.

Business outcome:
Shows cost-aware security design instead of wasteful blanket licensing.

## Final Production Gap Notes

This project intentionally used a simplified lab design:
- one domain controller instead of multiple domain controllers
- Azure public RDP access for administration instead of a more mature access path such as Bastion or VPN
- pilot user scope rather than full population rollout
- personal Azure subscription hosting instead of organization-owned Azure subscription governance

These simplifications were accepted for cost and lab practicality, but they were documented clearly and did not change the core hybrid identity architecture being demonstrated.
