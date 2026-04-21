# Risk Register

## Risk 1: Overprivileged admins
Problem:
Too many people holding Global Administrator or broad rights.

Impact:
High blast radius if an admin account is compromised.

Mitigation:
Use role segmentation, least privilege, and privileged admin accounts separated from normal user accounts.

Decision:
Remediate. The cost of compromise is much higher than the cost of tighter admin design.

## Risk 2: Password reset friction
Problem:
Users depend on helpdesk for resets.

Impact:
Support burden, downtime, user frustration.

Mitigation:
Enable SSPR and hybrid writeback.

Decision:
Remediate. This creates clear operational value.

## Risk 3: Sync misconfiguration
Problem:
Wrong OU scope, duplicate objects, or bad UPN mapping.

Impact:
Broken sign-in, license waste, failed onboarding.

Mitigation:
Use pilot OU design, validation testing, staged rollout logic, and documentation.

Decision:
Remediate. Identity errors are expensive to unwind.

## Risk 4: Lab cost overrun in Azure
Problem:
Leaving VMs running unnecessarily.

Impact:
Consumes trial credit and can create avoidable charges.

Mitigation:
Use small VM sizes, stop VMs when idle, track usage in Azure portal, avoid unnecessary public exposure.

Decision:
Remediate. Easy cost control with operational discipline.
