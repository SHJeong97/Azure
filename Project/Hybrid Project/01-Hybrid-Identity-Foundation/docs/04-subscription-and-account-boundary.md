# Subscription and Account Boundary

## Purpose

This document explains the account separation used in the lab.

## Azure Hosting Account
A personal Azure subscription is used only to host:
- virtual network
- network security group
- Windows Server virtual machines
- storage disks

## Company Identity Tenant
The Microsoft 365 tenant democompany1016.onmicrosoft.com is used for:
- Microsoft Entra ID
- Microsoft 365 administration
- SC-300 related configuration
- MS-102 related configuration
- hybrid identity target for synchronization

## Why this design exists
The company tenant does not currently have Azure subscription access, so the lab uses Azure only as infrastructure hosting.

## Portfolio honesty statement
This project does not claim Azure governance or subscription administration inside the company tenant.
It demonstrates Azure-hosted infrastructure plus hybrid identity integration into a separate Microsoft 365 tenant.

## Business interpretation
This is still a valid engineering exercise because the company problem being solved is identity architecture, not Azure billing ownership.
