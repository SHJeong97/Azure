# Business Risk and Value Analysis

## Problem Being Solved
Northstar Advisory Group had two linked identity problems: too much standing administrative privilege and no clearly defined response path for risky identities and risky sign-ins.

## Business Risks in the Original State
- administrators kept powerful access active longer than necessary
- compromised privileged accounts could create larger tenant impact
- risky sign-ins might not trigger a consistent response
- identity incidents could take longer to investigate and contain
- emergency recovery could be harder if strong access controls were introduced without a safe fallback path

## Why the Solution Matters
This project reduces privileged-access exposure by moving one admin role into just-in-time activation and builds a pilot risk-response model for risky users, risky sign-ins, and protected admin access.

## Cost of Getting It Wrong
If privileged access remains broadly active and identity risk remains undefined:
- security incidents can have higher blast radius
- investigation time increases
- admin misuse or mistakes become harder to contain
- recovery from policy mistakes becomes riskier
- audit and review effort becomes more difficult

## Value Created by This Design
- reduced standing privilege
- clearer separation between emergency recovery and daily administration
- stronger admin sign-in protection
- structured risk-based policy design
- better evidence for reviews and audits
- safer rollout path for advanced identity controls

## First-Principles Logic
Identity is the control plane for Microsoft 365 administration. If privileged access is overly broad and identity risk is poorly handled, every downstream security control becomes less trustworthy. Reducing standing privilege and defining risk response improves both security and recoverability.
