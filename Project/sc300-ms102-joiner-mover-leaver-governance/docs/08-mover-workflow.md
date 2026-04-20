# Mover Workflow

## Business Objective
When an employee changes departments, their access must be updated in a controlled way so they gain the new access they need and lose the old access they no longer require.

## Mover Scenarios in This Project
- Olivia Park moves from Finance to Operations
- Sophia Brooks moves from Sales to HR

## Control Logic
Each mover event must include:
- user department update
- removal from old department group
- addition to new department group
- removal of old shared mailbox access
- addition of new shared mailbox access
- inclusion in mover validation tracking

## Business Value
A controlled mover process reduces privilege creep, prevents old-access retention, and improves auditability.
