# DNS Architecture Decision

## Decision

The company will use a split DNS architecture.

## Internal DNS

Internal DNS will run on:

| Server | IP Address | Role |
|---|---:|---|
| DC01 | 10.10.1.10 | AD DS + DNS |
| DC02 | 10.10.1.11 | AD DS + DNS |

Internal DNS zone:

```text
corp.democompany1016.local
