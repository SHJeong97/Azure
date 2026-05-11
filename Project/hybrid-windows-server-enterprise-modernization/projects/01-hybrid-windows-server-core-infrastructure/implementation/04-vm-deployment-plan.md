# VM Deployment Plan

## Purpose

This document records the deployment plan for the first three Windows Server VMs in the Summit Ridge hybrid infrastructure lab.

## Business Problem

The company needs a reliable Windows Server foundation before implementing hybrid identity, internal DNS, file services, application publishing, backup, monitoring, and endpoint management.

## VM Design

| Server | Role | Subnet | Private IP | Public IP |
|---|---|---|---|---|
| DC01 | Primary domain controller and DNS server | snet-domain-controllers | 10.10.1.10 | None |
| DC02 | Secondary domain controller and DNS server | snet-domain-controllers | 10.10.1.11 | None |
| MGMT01 | Management server | snet-management | 10.10.2.10 | Temporary if needed |

## Cost Decision

The lab uses B-series burstable virtual machines to reduce cost while supporting short periods of higher CPU usage during installation and configuration.

## Security Decision

Domain controllers should not receive public IP addresses. Administrative access should go through MGMT01.

If temporary RDP is required, it should be allowed only to MGMT01 and only from the administrator's current public IP address.

## Risk

If domain controllers are exposed directly to the internet, the company increases its attack surface and risks credential attacks, service enumeration, and misconfiguration exposure.

## Risk Treatment

Do not assign public IP addresses to DC01 or DC02. Use MGMT01 as the administrative entry point and restrict RDP to a trusted source IP when direct RDP is required.

## Business Value

This design separates identity infrastructure from administrative access, reduces exposure, supports later AD DS deployment, and keeps the lab cost-controlled.
