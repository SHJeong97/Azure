# AD DS, DNS, and Forest Deployment

## Purpose

This implementation deployed the core Active Directory Domain Services and DNS foundation for the Summit Ridge hybrid Windows Server lab.

## Domain Design

| Item | Value |
|---|---|
| Internal AD DS domain | corp.democompany1016.local |
| NetBIOS name | CORP |
| Primary domain controller | DC01 |
| Secondary domain controller | DC02 |
| DNS model | AD-integrated DNS |
| DNS servers | 10.10.1.10, 10.10.1.11 |

## Business Problem

The company needs centralized identity, authentication, authorization, DNS, and policy control before implementing hybrid identity, Microsoft 365 integration, file services, application publishing, backup, monitoring, and endpoint management.

## Implementation Summary

DC01 was promoted as the first domain controller in a new forest named corp.democompany1016.local. DNS was installed as an AD-integrated service.

DC02 was joined to the domain and promoted as a second domain controller with DNS installed. This provides redundancy for authentication and internal name resolution.

The Azure VNet was updated to use DC01 and DC02 as custom DNS servers.

## Risk

If DNS or domain controller promotion is misconfigured, users and servers may fail to authenticate, join the domain, apply Group Policy, or locate domain services.

## Risk Treatment

The environment uses two domain controllers, AD-integrated DNS replication, DNS forwarders, replication validation, and health checks through repadmin and dcdiag.

## Business Value

The company now has a reusable identity foundation that supports future hybrid identity, Microsoft 365, Azure Files, Application Proxy, Azure Arc, backup, and endpoint integration projects.
