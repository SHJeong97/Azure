# Identity Protection Policy Model

## Business Objective
The company needs a structured response path for risky users, risky sign-ins, and privileged administrator access.

## Policy Design
This project uses three separate policies:
- a user risk policy
- a sign-in risk policy
- a protected-admin Conditional Access policy

## Why the Policies Are Separated
Risk conditions must be separated so user risk and sign-in risk can be handled with the appropriate remediation path.

## Pilot Scope
- Risk-test users: Emma Reed and Olivia Chen
- Protected-admin pilot users: Ava Foster, Ethan Walker, Rachel Kim, and Mason Lee
- Emergency access accounts remain excluded from protected-admin access controls

## Business Value
The company reduces identity-incident response time by defining what happens when risk is detected and by applying stronger access requirements to privileged users.
