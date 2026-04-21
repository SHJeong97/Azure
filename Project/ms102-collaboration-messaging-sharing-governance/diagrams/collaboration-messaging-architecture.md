# Collaboration, Messaging, and External Sharing Architecture

```text
                    +--------------------------------------------------+
                    | Summit Advisory Services                         |
                    | 200-User Microsoft 365 Company Model            |
                    +--------------------------+-----------------------+
                                               |
                                               v
                    +--------------------------------------------------+
                    | Microsoft 365 / Microsoft Entra ID               |
                    +--------------------------+-----------------------+
                                               |
         +-------------------------------------+--------------------------------------+
         |                                     |                                      |
         v                                     v                                      v
+---------------------------+     +----------------------------+      +----------------------------+
| Pilot Users               |     | Specialist Admin Roles     |      | Collaboration Groups       |
| 8 pilot users             |     | Ava  -> Exchange Admin     |      | SG-LIC-M365-E3-PILOT      |
| 4 workload admins         |     | Ethan -> SharePoint Admin  |      | SG-DEPT-FINANCE-COLLAB    |
| 4 department users        |     | Rachel -> Teams Admin      |      | SG-DEPT-OPERATIONS-COLLAB |
+-------------+-------------+     | Mason -> Global Reader     |      | SG-DEPT-HR-COLLAB         |
              |                   +-------------+--------------+      | SG-DEPT-SALES-COLLAB      |
              |                                 |                     | SG-PILOT-EXTERNAL-SHARING  |
              v                                 |                     +----------------------------+
+---------------------------+                    |
| Microsoft 365 E3          |                    v
| Group-based licensing     |      +----------------------------+
| via SG-LIC-M365-E3-PILOT  |      | Admin Centers              |
+-------------+-------------+      | - Microsoft 365 admin      |
              |                    | - Exchange admin center    |
              v                    | - SharePoint admin center  |
+---------------------------+      | - Teams admin center       |
| Workload Access           |      +----------------------------+
| Exchange / Teams / SPO    |
+-------------+-------------+
              |
              +---------------------------+----------------------------+-----------------------------+
              |                           |                            |
              v                           v                            v
+---------------------------+   +----------------------------+   +-----------------------------+
| Exchange Online           |   | Microsoft Teams            |   | SharePoint Online           |
| Shared mailboxes          |   | 4 private department Teams |   | 4 communication sites       |
| - Finance Shared          |   | - Finance Team             |   | - Finance Site              |
| - Operations Shared       |   | - Operations Team          |   | - Operations Site           |
| - HR Shared               |   | - HR Team                  |   | - HR Site                   |
| - Sales Shared            |   | - Sales Team               |   | - Sales Site                |
| Distribution group        |   +----------------------------+   +-----------------------------+
| - All Staff Updates       |                                                    |
+-------------+-------------+                                                    |
              |                                                                  |
              v                                                                  v
+---------------------------+                                  +----------------------------------+
| Mailbox Delegation Model  |                                  | External Sharing Model           |
| Finance Shared  -> Emma   |                                  | Org-level sharing enabled for    |
| Operations Shared->Olivia |                                  | controlled pilot                 |
| HR Shared       -> Grace  |                                  | Sales Site = external guest pilot|
| Sales Shared    -> Henry  |                                  | Other sites = internal only      |
| Send As only where needed |                                  | Teams guest access enabled       |
+---------------------------+                                  +----------------------------------+
