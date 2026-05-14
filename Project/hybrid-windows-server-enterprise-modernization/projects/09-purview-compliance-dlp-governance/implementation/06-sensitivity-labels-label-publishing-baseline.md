# Sensitivity Labels and Label Publishing Baseline

## Purpose

This document records the Microsoft Purview sensitivity label design, label creation, pilot label publishing policy, and label visibility validation for Project 09.

## Project Context

Project 09 builds the final Microsoft Purview compliance, DLP, and data governance baseline for the portfolio project series.

Batch 3 focuses on Microsoft Purview Information Protection by creating a simple classification model and publishing labels to pilot users only.

## Pilot Users

| User | Department | UPN |
|---|---|---|
| Emma Wilson | HR | emma.wilson@summitridge-mfg.com |
| Olivia Brown | Finance | olivia.brown@summitridge-mfg.com |
| Sophia Martinez | IT | sophia.martinez@summitridge-mfg.com |

## Sensitivity Label Model

The project used a simple four-label classification model.

| Label | Purpose | Protection Intent |
|---|---|---|
| Public | Content approved for broad sharing | No encryption |
| Internal | Standard internal business content | Internal handling |
| Confidential | Sensitive internal business content | Classification and user awareness |
| Highly Confidential | Restricted business content | Strict handling guidance |

## Label Design Decision

The label model was intentionally simple.

The goal was to demonstrate classification and user-awareness controls without creating a complex label hierarchy, forced encryption, mandatory labeling, or automatic labeling behavior.

## Labels Created or Confirmed

The following labels were created or confirmed in Microsoft Purview:

| Label | Result |
|---|---|
| Public | Created or confirmed |
| Internal | Created or confirmed |
| Confidential | Created or confirmed |
| Highly Confidential | Created or confirmed |

## Label Configuration Approach

The labels were configured for:

- Files and emails
- Manual user selection
- Classification only
- No encryption enforcement
- No auto-labeling
- No mandatory labeling
- No default label requirement

## Pilot Label Publishing Policy

A pilot label publishing policy was created or confirmed.

| Item | Value |
|---|---|
| Policy name | P09-Pilot-Label-Publishing |
| Scope | Pilot users only |
| Published labels | Public, Internal, Confidential, Highly Confidential |
| Default label | None |
| Mandatory labeling | No |
| Justification required to downgrade/remove label | No |
| Tenant-wide publishing | No |

## Label Visibility Validation

Label visibility was reviewed using a Microsoft 365 app or Outlook on the web.

Expected labels:

- Public
- Internal
- Confidential
- Highly Confidential

If labels were not immediately visible, the result was documented as expected propagation delay.

Sensitivity label publishing can require time before labels appear to users in Microsoft 365 apps.

## Privacy-Safe Evidence Handling

The following data was not exported:

```text
IpAddress
Location
City
State
CountryOrRegion
Private document content
Private email body content
Message body
Full message headers
Search result previews
Sensitive document previews
Sensitive message previews
```

Screenshots must be cropped or blurred if they show:

- Private document text
- Private email content
- Message previews
- Public IP address
- Location
- Device details
- Session metadata
- Sensitive file names
- Message IDs

## Safety Decisions

This batch did not:

- Create DLP policies
- Create retention labels
- Create retention policies
- Create eDiscovery searches
- Enable encryption enforcement
- Enable auto-labeling
- Enable mandatory labeling
- Publish labels tenant-wide
- Export private document content
- Export private email body content
- Export public IP address fields
- Export location fields

## Business Risk

A poorly designed sensitivity label rollout can confuse users, apply classification too broadly, or create operational friction.

Encryption and mandatory labeling can also affect user productivity if enabled before validation.

## Risk Treatment

The project reduced risk by using a simple four-label model, publishing labels only to pilot users, avoiding encryption enforcement, avoiding mandatory labeling, and documenting propagation behavior.

## Business Value

This batch demonstrates practical Microsoft Purview Information Protection administration.

It shows how to design, create, publish, and validate sensitivity labels safely using pilot scope and privacy-safe evidence handling.
