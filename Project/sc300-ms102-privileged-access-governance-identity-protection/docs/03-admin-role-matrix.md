# Admin Role Matrix

## Planned Role Design

| Role | Purpose | Access Model |
|---|---|---|
| Global Administrator | emergency-only tenant recovery | active on break-glass accounts only |
| Privileged Role Administrator | manage privileged role assignments and PIM settings | active pilot admin |
| Security Administrator | review and respond to security and identity-risk events | active pilot admin |
| User Administrator | manage users, groups, and license operations | eligible or active based on later design |
| Global Reader | read-only administrative visibility | active pilot admin |

## Business Logic
The role model must reduce dependency on Global Administrator for normal work while still preserving a recoverable admin path.
