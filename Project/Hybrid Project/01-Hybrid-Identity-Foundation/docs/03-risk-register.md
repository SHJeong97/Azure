# Risk Register

## Risk 1: Overprivileged administrators
Problem:
Too many broad admin permissions increase blast radius.

Business risk:
Compromise of one admin account can affect the whole tenant.

Decision:
Remediate.

Reason:
The cost of tighter admin segmentation is low compared to the cost of identity compromise.

## Risk 2: Weak identity authority model
Problem:
If source of authority is unclear, user lifecycle actions become inconsistent.

Business risk:
Bad provisioning, duplicate accounts, failed sync, and support burden.

Decision:
Remediate.

Reason:
Identity confusion creates recurring operational cost.

## Risk 3: Sync scope mistakes
Problem:
Wrong OU filtering or bad account design can sync the wrong objects.

Business risk:
Broken access, wasted licenses, troubleshooting overhead.

Decision:
Remediate.

Reason:
This is a preventable design error.

## Risk 4: Password reset overhead
Problem:
Users rely too much on manual IT intervention.

Business risk:
Productivity loss and helpdesk waste.

Decision:
Remediate.

Reason:
SSPR and writeback create clear operational value.

## Risk 5: Azure free-credit overuse
Problem:
Leaving VMs running unnecessarily burns credit.

Business risk:
Lab cost increases or the project stops early due to exhausted credit.

Decision:
Remediate.

Reason:
Cost discipline is easy and should be enforced from the beginning.

## Final Risk Outcome Summary

### Risk: Overprivileged administration
Status:
Reduced through named admin accounts, role separation, and cloud-only emergency accounts.

### Risk: Inconsistent onboarding and licensing
Status:
Reduced through structured OUs, group model, and group-based licensing.

### Risk: Password reset helpdesk dependency
Status:
Reduced through SSPR and password writeback.

### Risk: Hybrid sync misconfiguration
Status:
Reduced through pilot OU filtering and staged rollout.

### Risk: Azure lab cost overrun
Status:
Reduced through minimal VM count, small sizing, and auto-shutdown.
