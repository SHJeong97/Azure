# Joiner-Mover-Leaver Process Architecture

```text
                    +---------------------------------------------+
                    | Crestview Manufacturing Services            |
                    | 100-User Microsoft 365 Company Model        |
                    +----------------------+----------------------+
                                           |
                                           v
                    +---------------------------------------------+
                    | Microsoft Entra ID / Microsoft 365          |
                    +----------------------+----------------------+
                                           |
         +---------------------------------+---------------------------------+
         |                                 |                                 |
         v                                 v                                 v
+---------------------+       +--------------------------+       +--------------------------+
| Baseline Users      |       | Shared Resources         |       | Lifecycle Control        |
| 12 pilot users      |       | HR / Finance / Sales /   |       | Joiner / Mover / Leaver |
| across 6 depts      |       | Operations shared        |       | validation groups        |
+----------+----------+       | mailboxes                |       +------------+-------------+
           |                  +------------+-------------+                    |
           v                               |                                  v
+--------------------------+               |                    +----------------------------+
| Department Groups        |               |                    | SG-JOINER-PILOT            |
| SG-DEPT-HR               |               |                    | SG-MOVER-PILOT             |
| SG-DEPT-FINANCE          |               |                    | SG-LEAVER-PILOT            |
| SG-DEPT-SALES            |               |                    +----------------------------+
| SG-DEPT-OPERATIONS       |               |
| SG-DEPT-IT               |               |
| SG-DEPT-EXEC             |               |
+------------+-------------+               |
             |                             |
             v                             v
+--------------------------+    +-------------------------------+
| SG-LIC-M365-E3           |    | Department Shared Mailboxes   |
| Group-based licensing    |    | HR Shared                     |
+------------+-------------+    | Finance Shared                |
             |                  | Sales Shared                  |
             v                  | Operations Shared             |
+--------------------------+    +-------------------------------+
| Microsoft 365 E3         |
| Baseline employee access |
+--------------------------+

JOINER FLOW
-----------
New user created
   -> add to SG-LIC-M365-E3
   -> add to correct department group
   -> add to SG-JOINER-PILOT
   -> grant correct shared mailbox access
   -> validate account, license, group, mailbox access

MOVER FLOW
----------
Existing user changes department
   -> update department attribute
   -> remove old department group
   -> add new department group
   -> add to SG-MOVER-PILOT
   -> remove old mailbox access
   -> grant new mailbox access
   -> validate old access removed and new access added

LEAVER FLOW
-----------
Existing user leaves company
   -> disable account
   -> revoke sessions
   -> remove from SG-LIC-M365-E3
   -> remove from department/workflow groups
   -> remove shared mailbox access
   -> add to SG-LEAVER-PILOT
   -> validate disabled state and entitlement removal
