Project 07 Batch 8 — README Preparation Note

Project:
Privileged Identity Management, Admin Roles, and Access Reviews

Final project result:
Project 07 created a privileged access governance baseline using Microsoft Entra PIM, admin role inventory, eligible role assignments, activation testing, manual access review documentation, audit monitoring, rollback controls, and privacy-safe evidence handling.

Key implementation results:
- Validated tenant and licensing readiness
- Exported active Microsoft Entra role assignments
- Reviewed standing privileged access
- Preserved emergency access
- Created eligible PIM assignments for Sophia Martinez
- Tested PIM activation workflow
- Documented User Administrator eligible-only state during deactivation review
- Activated and deactivated Helpdesk Administrator
- Created manual access review evidence due to portal scoping limitation
- Exported privileged audit logs with sanitized fields
- Exported privileged sign-in logs without IP/location fields
- Created rollback and operational runbooks
- Created monitoring scripts

Important project decisions:
- Emergency access was not removed
- No Global Administrator assignment was changed
- No privileged assignments were removed
- No access review results were auto-applied
- Manual access reviews were documented because exact portal scope was not available
- IP/location fields were excluded from evidence

README should emphasize:
- Least privilege
- Just-in-time privileged access
- PIM eligible assignments
- Activation and deactivation workflow
- Emergency access preservation
- Manual access review evidence and portal limitation
- Audit monitoring
- Rollback readiness
- Privacy-safe evidence

Evidence location:
C:\LabEvidence\Project07\Batch08
