# Business Risk and Value Analysis

## Problem Being Solved
Northstar Health Advisors lacked a standardized identity and access model. User onboarding, licensing, password recovery, and administrative access were too manual and too dependent on broad privilege.

## Business Risks in the Original State
- inconsistent onboarding and offboarding
- excess administrative privilege
- license waste and misalignment
- higher chance of account compromise from password-only access
- higher help desk workload for password issues
- greater risk of administrative lockout if identity controls were misconfigured

## Why the Solution Matters
The project creates a repeatable identity baseline that improves security and operational consistency without requiring a large enterprise-scale deployment.

## Cost of Getting It Wrong
If the company keeps the original manual model:
- support time increases
- audit and access review effort becomes harder
- user access mistakes persist longer
- privileged access mistakes have larger blast radius
- password-related downtime remains common

## Value Created by This Design
- standardized onboarding through groups
- cleaner license assignment through group-based licensing
- lower daily use of Global Administrator
- staged MFA rollout with lower deployment risk
- self-service recovery for users
- preserved tenant recovery through emergency access planning

## First-Principles Logic
Identity is the control plane for Microsoft 365 access. If identity administration is inconsistent, every downstream control becomes weaker. Standardizing identity, privilege, authentication, and recovery improves both security and operating efficiency.
