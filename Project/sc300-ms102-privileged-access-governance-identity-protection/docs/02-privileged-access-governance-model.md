# Privileged Access Governance Model

## Governance Objective
Privileged access must be tightly scoped, time-bound where possible, and validated so that administrative power is available when needed without remaining active unnecessarily.

## Core Design Principles
- use least privilege for daily administration
- separate emergency access from normal admin access
- prefer eligible role access over permanent active access
- require stronger controls for privileged activation
- document and validate all privileged access paths

## Operational Model
The project will use a small pilot group of privileged and security-relevant users to model a larger 250-user company.

## Control Logic
- emergency access accounts are separate from normal admin accounts
- privileged admin roles are assigned intentionally
- PIM is used to reduce standing admin access
- Identity Protection and risk-based Conditional Access are used to respond to identity risk
