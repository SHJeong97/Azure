# Emergency Access Design

## Purpose
The tenant needs emergency access accounts so administrative recovery remains possible if privileged access configuration or risk-based policies cause normal admin access issues.

## Design Decisions
- Two cloud-only emergency access accounts will exist
- These accounts will not be used for daily administration
- These accounts will be added to SG-EXCLUDE-EMERGENCY-ACCESS
- These accounts will hold Global Administrator for recovery only
- These accounts will stay outside the standard employee license path in this project

## Business Reason
Emergency access accounts reduce tenant lockout risk during privileged-access and identity-protection rollout.
