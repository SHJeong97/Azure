# Admin Role Mapping

## Business Objective
Administrative access must be separated by function so that the company can reduce risk, limit blast radius, and support auditability.

## Role Design
- Global Administrator: reserved for emergency access only
- Identity Administrator: used for identity configuration and user/group administration
- Helpdesk Administrator: used for password reset and basic user support tasks

## Assigned Accounts in This Batch
- `ava.foster@democompany1016.onmicrosoft.com` -> Identity Administrator
- `ethan.walker@democompany1016.onmicrosoft.com` -> Helpdesk Administrator
- `breakglass-01@democompany1016.onmicrosoft.com` -> Global Administrator
- `breakglass-02@democompany1016.onmicrosoft.com` -> Global Administrator

## Risk Reduction Logic
Using lower-privilege roles for daily administration reduces the chance that a normal support or identity task causes full-tenant impact.

## Business Value
- lower exposure to accidental or malicious changes
- cleaner separation of duties
- better audit posture
- safer future expansion into Conditional Access and governance controls
