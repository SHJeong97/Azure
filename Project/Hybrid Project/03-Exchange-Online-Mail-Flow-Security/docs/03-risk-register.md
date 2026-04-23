# Risk Register

## Risk 1: Uncontrolled shared mailbox access
Problem:
Too many users have unmanaged access to sensitive shared mailboxes.

Impact:
Data exposure and poor accountability.

Decision:
Remediate through role-based mailbox access assignment.

## Risk 2: Weak mail flow governance
Problem:
Messages are delivered without enough transport control or visibility.

Impact:
Business confusion, compliance issues, and poor operational control.

Decision:
Remediate through transport rules and validation.

## Risk 3: Phishing and impersonation exposure
Problem:
Basic mail hygiene controls are not clearly tuned or documented.

Impact:
Credential theft and user compromise.

Decision:
Remediate through security baseline improvements.

## Risk 4: No proof of operational effectiveness
Problem:
Settings may exist, but admins cannot prove they work.

Impact:
Weak troubleshooting and weak audit readiness.

Decision:
Remediate through message trace and test scenarios.

## Final Risk Outcome Summary

### Risk: Uncontrolled shared mailbox access
Status:
Reduced through standardized shared mailbox planning and department-based access design.

### Risk: Weak mail flow governance
Status:
Reduced through visible transport controls such as external tagging, disclaimers, and executable attachment blocking.

### Risk: Phishing and impersonation exposure
Status:
Reduced through Defender anti-phishing and anti-spam policy scoping.

### Risk: No proof of operational effectiveness
Status:
Partially reduced through observable inbox outcomes and test-message behavior, though quarantine and message trace verification were not fully captured for every scenario in this lab run.
