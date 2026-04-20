# Leaver Workflow

## Business Objective
When an employee leaves the company, access must be removed in a controlled sequence so the user cannot continue to access company resources and the organization can prove cleanup occurred.

## Leaver Scenarios in This Project
- Sophia Brooks leaves after moving from Sales to HR
- Jackson Reed leaves after joining the Operations department

## Control Logic
Each leaver event must include:
- sign-in disablement
- session revocation
- removal from group-based license path
- removal from department and workflow groups
- removal of shared mailbox access where assigned
- inclusion in leaver validation tracking

## Business Value
A controlled leaver process reduces unauthorized access risk, license waste, and audit gaps while preserving a clear record of what was removed and when.
