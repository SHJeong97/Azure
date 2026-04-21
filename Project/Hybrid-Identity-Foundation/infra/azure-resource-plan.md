# Azure Resource Plan

## Goal
Provide low-cost infrastructure hosting for a hybrid identity portfolio lab.

## Planned Resources
- 1 resource group
- 1 virtual network
- 1 subnet
- 1 network security group
- 2 Windows Server VMs
- 2 public IPs only if required for administration
- managed disks
- boot diagnostics enabled if needed

## Cost Discipline Rules
- use small VM sizes
- stop VMs when not in use
- avoid unnecessary premium services
- avoid extra VMs unless justified
- track remaining trial credit regularly

## Security Discipline Rules
- restrict inbound administrative exposure
- document every exception
- use strong passwords and tenant MFA where possible
