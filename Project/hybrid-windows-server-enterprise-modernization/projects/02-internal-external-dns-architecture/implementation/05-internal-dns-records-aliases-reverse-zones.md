# Internal DNS Records, Aliases, and Reverse Lookup Zones

## Purpose

This implementation added internal DNS records, user-friendly aliases, and reverse lookup zones for the Summit Ridge hybrid Windows Server environment.

## DNS Zone

```text
corp.democompany1016.local
```

## Reverse Lookup Zones

Reverse lookup zones were created for the lab network subnets:

| Subnet | Reverse Zone |
|---|---|
| 10.10.1.0/24 | 1.10.10.in-addr.arpa |
| 10.10.2.0/24 | 2.10.10.in-addr.arpa |
| 10.10.3.0/24 | 3.10.10.in-addr.arpa |
| 10.10.4.0/24 | 4.10.10.in-addr.arpa |

## Planned A Records

| Hostname | IP Address | Purpose |
|---|---:|---|
| fs01.corp.democompany1016.local | 10.10.3.10 | Future Windows file server |
| app01.corp.democompany1016.local | 10.10.3.20 | Future internal application server |

## Friendly CNAME Aliases

| Alias | Target | Purpose |
|---|---|---|
| files.corp.democompany1016.local | fs01.corp.democompany1016.local | User-friendly file server name |
| intranet.corp.democompany1016.local | app01.corp.democompany1016.local | User-friendly internal app name |

## Business Problem

Users and administrators should not have to remember server names or IP addresses for common services.

A friendly DNS alias such as `files.corp.democompany1016.local` is easier to document, migrate, and support than pointing users directly to a server name or IP address.

## Why CNAME Aliases Matter

CNAME aliases make future migration easier.

For example, users can access:

```text
\\files.corp.democompany1016.local
```

Instead of:

```text
\\fs01.corp.democompany1016.local
```

If the file server changes later, the alias can be repointed without changing user documentation or mapped drive paths.

## Risk

If DNS records are missing or inaccurate, users may fail to reach internal services.

If aliases are not used, future migrations can require changing scripts, GPOs, shortcuts, documentation, and user instructions.

## Risk Treatment

The project uses planned A records, friendly aliases, reverse lookup zones, and DNS validation from both DC01 and DC02.

## Business Value

This design improves usability, reduces migration complexity, supports future file server and internal application projects, and creates a cleaner internal namespace for a 250-user company.
