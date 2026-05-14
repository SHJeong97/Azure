# Audit Monitoring and Admin Activity Review

## Purpose

This document records privileged access audit monitoring, PIM activity review, sign-in monitoring, emergency access monitoring, and privacy-safe evidence handling for Project 07.

## Project Context

Project 07 builds a privileged access governance baseline using Microsoft Entra Privileged Identity Management, admin role inventory, access review planning, audit monitoring, rollback controls, and operational documentation.

Batch 6 focuses on monitoring and evidence collection.

## Monitoring Scope

The monitoring scope included:

- Privileged audit logs
- PIM-specific audit activity
- Role management audit activity
- Access review audit activity
- Privileged target sign-ins
- Emergency access sign-ins
- Microsoft Entra audit log portal review
- Microsoft Entra sign-in log portal review

## Monitored Accounts

| Account | Purpose |
|---|---|
| srmgadmin@democompany1016.onmicrosoft.com | Existing lab administrator and reviewer |
| emergency.access01@democompany1016.onmicrosoft.com | Emergency access account |
| sophia.martinez@summitridge-mfg.com | PIM activation pilot user |

## Audit Evidence Exported

The following sanitized audit exports were created:

| Evidence | Purpose |
|---|---|
| Privileged audit logs | Review privileged activity |
| PIM audit logs | Review PIM activation and eligibility activity |
| Role management audit logs | Review role assignment and role management activity |
| Access review audit logs | Review access review activity |
| Privileged target sign-ins | Review sign-ins for admin-related accounts |
| Emergency access sign-ins | Review emergency access usage separately |

## Emergency Access Monitoring

Emergency access sign-ins should be rare and explainable.

The emergency access account was monitored separately:

```text
emergency.access01@democompany1016.onmicrosoft.com
```

No emergency access assignment was removed or changed during this batch.

## Access Review Monitoring

Because Batch 5 used manual documented access reviews due to portal scoping limitations, access review audit logs may be blank.

That is acceptable for this lab because manual review records, reviewer decisions, and portal limitation notes were created in Batch 5.

## Privacy-Safe Evidence Handling

The following fields were not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
```

Screenshots must be cropped or blurred if the portal displays public IP address, location, device details, browser details, or session metadata.

## Safety Decisions

This batch did not:

- Remove emergency access
- Remove privileged assignments
- Apply access review results
- Modify Global Administrator assignments
- Modify PIM assignments
- Export public IP address fields
- Export location fields

## Monitoring Findings

Monitoring evidence was collected using sanitized fields.

The review focused on whether privileged activity was explainable and whether emergency access usage appeared rare and controlled.

## Business Risk

Privileged activity that is not monitored can hide risky admin behavior, unexpected role changes, excessive standing privilege, or emergency account misuse.

## Risk Treatment

The project reduces risk by exporting sanitized audit evidence, monitoring emergency access separately, reviewing PIM and role management activity, and documenting portal review results.

## Business Value

This batch demonstrates how privileged access governance can be monitored after PIM activation testing and access review planning.
