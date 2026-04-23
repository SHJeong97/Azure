# Risk Register

## Risk 1: Direct per-user app assignment
Problem:
Manual access assignment becomes hard to audit and hard to maintain.

Impact:
Inconsistent onboarding and orphaned access.

Decision:
Remediate through group-based access.

## Risk 2: App admins using normal user identities
Problem:
Administrative activity is mixed with normal user activity.

Impact:
Poor privilege separation and weaker accountability.

Decision:
Remediate through separate app-admin access groups and admin identities.

## Risk 3: SSO works but lifecycle does not
Problem:
Users can authenticate, but provisioning and deprovisioning still require manual effort.

Impact:
Offboarding delays and stale application accounts.

Decision:
Remediate by designing the app access model for provisioning readiness from the start.

## Risk 4: App assignment scope is too broad
Problem:
Too many users are assigned to the app during testing.

Impact:
Unnecessary exposure and messy validation.

Decision:
Remediate through pilot groups first.

## Final Risk Outcome Summary

### Risk: Direct per-user assignment
Status:
Reduced through synced app access groups and group-based enterprise app assignment.

### Risk: Excessive admin concentration
Status:
Reduced through delegated enterprise app ownership.

### Risk: False assumption that SSO equals provisioning
Status:
Reduced through explicit provisioning-readiness review and documentation.

### Risk: Offboarding inconsistency
Status:
Reduced at the Microsoft Entra assignment layer, but not fully eliminated downstream because the target app retains its own local account model in this lab.
