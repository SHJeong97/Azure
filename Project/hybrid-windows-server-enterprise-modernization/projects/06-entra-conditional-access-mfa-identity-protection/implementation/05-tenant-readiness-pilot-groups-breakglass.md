# Tenant Readiness, Pilot Groups, and Break-Glass Exclusion

## Purpose

This document records Microsoft Entra tenant readiness, Conditional Access pilot group creation, break-glass account preparation, and exclusion validation.

## Project Context

Project 06 creates a Conditional Access, MFA, and Identity Protection baseline for Summit Ridge Manufacturing Group.

This project does not use Intune or device compliance requirements.

## Tenant Readiness Validation

The following tenant readiness checks were completed:

- Microsoft Graph connection
- Tenant organization details export
- Tenant license SKU export
- Pilot user readiness validation
- Existing Conditional Access policy export
- Security Defaults state documentation
- Tenant readiness summary

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Conditional Access Pilot Group

The pilot group created for Conditional Access testing was:

```text
GRP-CA-Pilot-Users
```

This group contains only the three pilot users.

## Break-Glass Exclusion Group

The break-glass exclusion group created for emergency access protection was:

```text
GRP-CA-Excluded-BreakGlass
```

This group is intended to be excluded from Conditional Access enforcement.

## Emergency Access Account

The lab emergency access account is:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

The account is cloud-only and should not be used for daily administration.

## Role Assignment

The emergency access account was documented for Global Administrator assignment.

In production, at least two emergency access accounts should be maintained and monitored.

## Security Defaults

Security Defaults state was documented.

No change was made to Security Defaults in this batch.

## Safety Decisions

This batch did not:

- Create Conditional Access policies
- Enforce Conditional Access policies
- Disable Security Defaults
- Block any users
- Require compliant devices
- Use Intune
- Assign policies to all users

## Business Risk

Conditional Access can cause administrator lockout or user sign-in disruption if exclusions and pilot scope are not prepared first.

## Risk Treatment

The project reduces risk by creating a pilot group, creating a break-glass exclusion group, documenting emergency access, and validating tenant readiness before policy creation.

## Business Value

This batch creates the identity security foundation required to safely build and test Conditional Access policies in report-only mode before enforcement.
