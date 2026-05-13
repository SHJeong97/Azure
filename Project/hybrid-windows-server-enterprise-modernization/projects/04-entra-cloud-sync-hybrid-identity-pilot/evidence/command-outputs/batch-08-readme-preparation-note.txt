Project 04 Batch 8 — README Preparation Note

Project:
Microsoft Entra Cloud Sync for Hybrid Identity Pilot

Final project result:
Selected on-premises AD pilot users were synchronized into Microsoft Entra ID using Microsoft Entra Cloud Sync.

Pilot users:
- emma.wilson@summitridge-mfg.com
- olivia.brown@summitridge-mfg.com
- sophia.martinez@summitridge-mfg.com

Key implementation results:
- Provisioning agent installed on MGMT01
- KDS/gMSA issue resolved during installation
- Cloud Sync configuration created
- Scope limited to GRP-EntraCloudSync-Pilot
- Nested groups avoided
- Password hash sync enabled
- Pilot users synchronized to Microsoft Entra ID
- UsageLocation validated or set to US
- Licensing deferred to Project 05
- Exchange mailbox enablement deferred to Project 05
- Rollback and monitoring controls documented

README should emphasize:
- Why sync was needed after Project 03
- Why scoped pilot sync was safer than full-directory sync
- How Cloud Sync solved the AD-to-cloud identity gap
- What risks were controlled
- What business value was created

Evidence location:
C:\LabEvidence\Project04\Batch08
