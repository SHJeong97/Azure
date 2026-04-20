
# Identity and Access Architecture

```text
                           +----------------------------------+
                           |  Northstar Health Advisors       |
                           |  75-User Company Model           |
                           +----------------+-----------------+
                                            |
                                            v
                         +--------------------------------------+
                         | Microsoft Entra ID / Microsoft 365   |
                         +----------------+---------------------+
                                          |
              +---------------------------+---------------------------+
              |                           |                           |
              v                           v                           v
   +--------------------+      +----------------------+     +----------------------+
   | Pilot Users        |      | Admin Accounts       |     | Emergency Accounts   |
   | 12 test users      |      | Ava / Ethan          |     | breakglass-01 / 02   |
   +---------+----------+      +----------+-----------+     +----------+-----------+
             |                            |                            |
             v                            v                            v
   +--------------------+      +----------------------+     +----------------------+
   | Department Groups  |      | Admin Helper Groups  |     | SG-EXCLUDE-          |
   | HR / Finance /     |      | SG-ADMIN-HELPDESK    |     | EMERGENCY-ACCESS     |
   | Sales / Ops / IT / |      | SG-ADMIN-IDENTITY*   |     +----------------------+
   | Exec               |      | *(design helper)     |
   +---------+----------+      +----------+-----------+
             |                            |
             +-------------+--------------+
                           |
                           v
                +--------------------------+
                | SG-LIC-M365-E3           |
                | Group-based licensing    |
                +------------+-------------+
                             |
                             v
                +--------------------------+
                | Microsoft 365 E3         |
                | Baseline employee access |
                +--------------------------+

                             |
                             v

                +-------------------------------+
                | SG-PILOT-CA-MFA               |
                | 6 pilot users                 |
                +---------------+---------------+
                                |
                                v
                  +-----------------------------+
                  | Authentication Methods      |
                  | - Microsoft Authenticator   |
                  | - SMS backup                |
                  +---------------+-------------+
                                  |
                                  v
                  +-----------------------------+
                  | SSPR                         |
                  | Scoped to pilot users       |
                  +---------------+-------------+
                                  |
                                  v
                  +-----------------------------+
                  | Conditional Access          |
                  | CA01 - Require MFA for      |
                  | Office 365                  |
                  | Include: pilot group        |
                  | Exclude: emergency group    |
                  +-----------------------------+
