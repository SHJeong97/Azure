# Conditional Access Design

## Business Objective
Protect Microsoft 365 access with stronger authentication while minimizing rollout risk.

## Policy Strategy
The first Conditional Access policy is deployed in Report-only mode to evaluate impact before enforcement.

## Policy Scope
- Include: SG-PILOT-CA-MFA
- Exclude: SG-EXCLUDE-EMERGENCY-ACCESS

## Target Resources
- Office 365

## Planned Control
- Require multifactor authentication strength or equivalent MFA requirement for the pilot group

## Rollout Logic
The company uses a pilot-first rollout so authentication enforcement can be tested and validated before broader deployment.

## Risk Control
Emergency access accounts are excluded so tenant recovery remains possible if normal policy design creates access issues.
