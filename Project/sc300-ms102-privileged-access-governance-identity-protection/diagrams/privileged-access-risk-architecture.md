# Privileged Access and Identity Protection Architecture

```text
                     +--------------------------------------------------+
                     | Northstar Advisory Group                         |
                     | 250-User Microsoft 365 Company Model            |
                     +--------------------------+-----------------------+
                                                |
                                                v
                     +--------------------------------------------------+
                     | Microsoft Entra ID / Microsoft 365 E5 Pilot      |
                     +--------------------------+-----------------------+
                                                |
         +--------------------------------------+--------------------------------------+
         |                                      |                                      |
         v                                      v                                      v
+---------------------------+     +----------------------------+      +----------------------------+
| Emergency Access          |     | Privileged Admin Pilot     |      | Risk-Test Users            |
| breakglass-01             |     | Ava Foster                 |      | Emma Reed                  |
| breakglass-02             |     | Ethan Walker               |      | Olivia Chen                |
+-------------+-------------+     | Rachel Kim                 |      +-------------+--------------+
              |                   | Mason Lee                  |                    |
              v                   +-------------+--------------+                    v
+---------------------------+                   |                    +----------------------------+
| Global Administrator      |                   v                    | SG-PILOT-RISK-USERS       |
| Recovery only             |     +----------------------------+      | User/sign-in risk scope   |
+-------------+-------------+     | SG-PILOT-PRIV-ADMINS       |      +-------------+--------------+
              |                   | Admin pilot grouping       |                    |
              v                   +-------------+--------------+                    v
+---------------------------+                   |                    +----------------------------+
| SG-EXCLUDE-EMERGENCY-     |                   v                    | CA02 - User Risk           |
| ACCESS                    |     +----------------------------+      | Require password change /  |
| Excluded from selected    |     | SG-PILOT-PIM-ELIGIBLE      |      | risk remediation          |
| controls                  |     | Ethan Walker               |      +----------------------------+
+---------------------------+     +-------------+--------------+                    |
                                                |                                   v
                                                v                    +----------------------------+
                                   +----------------------------+      | CA03 - Sign-in Risk       |
                                   | Privileged Identity        |      | Require MFA               |
                                   | Management (PIM)           |      +----------------------------+
                                   | Eligible role:             |
                                   | User Administrator         |
                                   +-------------+--------------+
                                                 |
                                                 v
                                   +----------------------------+
                                   | Ethan activates role       |
                                   | MFA + justification        |
                                   | 1 hour max activation      |
                                   +-------------+--------------+
                                                 |
                                                 v
                                   +----------------------------+
                                   | Time-bound active          |
                                   | privileged access          |
                                   +----------------------------+

                     +--------------------------------------------------+
                     | SG-LIC-M365-E5-PILOT                             |
                     | Group-based Microsoft 365 E5 assignment          |
                     +--------------------------+-----------------------+
                                                |
                                                v
                     +--------------------------------------------------+
                     | E5 / Entra ID P2-backed controls                 |
                     | - PIM                                             |
                     | - Identity Protection                             |
                     | - Risk-based Conditional Access                   |
                     +--------------------------+-----------------------+
                                                |
                                                v
                     +--------------------------------------------------+
                     | CA04 - Admins - Require Strong MFA               |
                     | Directory roles targeted                          |
                     | Emergency accounts excluded                       |
                     | Report-only -> On                                 |
                     +--------------------------------------------------+
