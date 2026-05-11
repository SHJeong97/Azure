# OU, User, Group, Admin, and Service Account Baseline

## Purpose

This implementation created the initial Active Directory operating structure for Summit Ridge Manufacturing Group.

## Business Problem

The company needs a clean identity structure before implementing Group Policy, hybrid identity sync, file share permissions, Azure Files migration, application publishing, and endpoint management.

Without an OU and group model, access control becomes inconsistent, user administration becomes manual, and future automation becomes harder.

## OU Design

The SRMG root OU contains separate OUs for:

- Admin accounts
- Security groups
- Service accounts
- Department users
- Workstations
- Servers
- Disabled objects
- Staging

## Group Design

The group model includes:

- Department groups
- File access groups
- Admin role groups
- Future cloud licensing groups

## Admin Model

Dedicated admin accounts were created instead of using standard user accounts for privileged operations.

Admin tiers:

- Tier 0: Domain administration
- Tier 1: Server administration
- Tier 2: Helpdesk administration

## Service Account Design

Service account placeholders were created in a dedicated OU and left disabled until needed.

This prevents unused service accounts from becoming active risk.

## Risk

Poor OU and group design can lead to excessive permissions, inconsistent access control, failed delegation, difficult troubleshooting, and higher lateral movement risk.

## Risk Treatment

The environment uses structured OUs, role-based groups, separate admin accounts, disabled service account placeholders, and documented naming standards.

## Business Value

This design gives the company a scalable identity foundation for a 250-user environment. It supports future file access control, hybrid identity sync, Microsoft 365 licensing, Group Policy, delegated administration, and endpoint management.
