# Emergency Access Design

## Purpose
The company needs emergency access accounts to recover administrative control if normal authentication paths fail or if conditional access policy configuration blocks standard admin access.

## Business Reason
Without emergency access, a misconfiguration in identity policy could create an administrative lockout. The remediation cost would be high because tenant recovery would become slower, riskier, and more dependent on vendor escalation.

## Design Decisions
- Two cloud-only emergency access accounts will exist.
- These accounts will not be used for daily administration.
- These accounts will be excluded from future Conditional Access enforcement through a dedicated exclusion group.
- These accounts will use strong unique credentials stored in a secured process outside normal end-user workflows.
- Sign-in activity for these accounts must be monitored.
- These accounts are design-only in this batch and will be implemented later.

## Planned Accounts
- breakglass-01@YOURTENANT.onmicrosoft.com
- breakglass-02@YOURTENANT.onmicrosoft.com

## Control Objective
Maintain recoverable administrative access without weakening normal identity security for the rest of the organization.
