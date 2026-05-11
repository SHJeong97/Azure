# MGMT01 Domain Join and Management Tooling

## Purpose

This implementation configured MGMT01 as the centralized management server for the Summit Ridge hybrid Windows Server foundation.

## Configuration Summary

| Item | Value |
|---|---|
| Server | MGMT01 |
| Domain | corp.democompany1016.local |
| DNS servers | 10.10.1.10, 10.10.1.11 |
| Management tools | RSAT AD DS, DNS, Group Policy Management |

## Business Problem

The company needs a dedicated management system for administering Active Directory, DNS, Group Policy, and domain-joined infrastructure. Directly administering domain controllers for daily tasks increases operational risk.

## Implementation Summary

MGMT01 was configured to use DC01 and DC02 for DNS resolution, joined to the corp.democompany1016.local domain, and configured with RSAT tools for AD DS, DNS, and Group Policy administration.

## Risk

If administrators manage everything directly from domain controllers, the risk of accidental changes or unnecessary exposure increases.

If MGMT01 cannot resolve AD DNS records, domain administration tools may fail or connect unreliably.

## Risk Treatment

Use MGMT01 as the administrative access point, validate DNS resolution before domain join, install RSAT tools, and confirm management access to AD DS, DNS, Group Policy, SYSVOL, and NETLOGON.

## Business Value

This design centralizes administration, reduces the need for interactive domain controller logons, and prepares the environment for later OU, group, GPO, file service, and hybrid identity configuration.
