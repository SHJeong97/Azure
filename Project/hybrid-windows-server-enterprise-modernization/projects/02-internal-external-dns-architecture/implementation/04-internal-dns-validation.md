# Internal AD-Integrated DNS Validation

## Purpose

This implementation validates the internal DNS foundation for Summit Ridge Manufacturing Group.

The company uses Active Directory-integrated DNS on two domain controllers:

| Server | IP Address | Role |
|---|---:|---|
| DC01 | 10.10.1.10 | AD DS + DNS |
| DC02 | 10.10.1.11 | AD DS + DNS |

## Internal DNS Zone

```text
corp.democompany1016.local
```

The internal DNS zone is used for:

- Domain controller discovery
- Kerberos authentication
- LDAP lookup
- Global Catalog discovery
- Domain join
- Group Policy processing
- SYSVOL access
- NETLOGON access
- Internal server name resolution

## Validation Performed

The following validations were completed from MGMT01:

- MGMT01 DNS client settings verified
- DNS service reachability tested on DC01 and DC02
- DC01, DC02, and MGMT01 name resolution validated
- LDAP SRV records validated
- Kerberos SRV records validated
- Global Catalog SRV records validated
- DNS zones confirmed on DC01 and DC02
- DNS records compared between DC01 and DC02
- DNS forwarders validated
- External DNS resolution tested through both internal DNS servers
- AD replication checked because the DNS zone is AD-integrated

## Business Problem

The company needs reliable internal DNS because Active Directory authentication depends on it.

If internal DNS fails, users may be unable to sign in, access file shares, apply Group Policy, locate domain controllers, or use internal applications.

## Risk

If internal DNS is misconfigured, the company may experience:

- Domain join failures
- Kerberos authentication failures
- LDAP lookup failures
- Group Policy failures
- SYSVOL and NETLOGON access issues
- Unstable domain controller discovery
- Increased helpdesk tickets and troubleshooting time

## Risk Treatment

The risk is reduced by:

- Running DNS on two domain controllers
- Using AD-integrated DNS replication
- Validating SRV records
- Validating name resolution from MGMT01
- Testing external DNS forwarding
- Checking AD replication health

## Business Value

This design provides a reliable and supportable internal DNS foundation for a 250-user hybrid enterprise.

It supports future projects including:

- Custom public domain configuration
- Microsoft 365 domain verification
- Hybrid identity synchronization
- File server migration
- Entra Application Proxy
- Azure Arc management
- Intune endpoint integration
