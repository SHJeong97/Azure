# Validation Checklist

## Batch 1 Validation
- Project 2 folder structure created
- README shell created
- Business scenario documented
- Architecture decisions documented
- Risk register documented
- App access model documented
- App OU created under Groups
- App access groups created in AD
- App access groups visible in ADUC
- Delta sync triggered
- App access groups visible in Microsoft Entra ID

## Batch 2 Validation
- Enterprise application instance created
- App owners assigned
- App sign-in enabled
- App visibility enabled
- Assignment required enabled
- Users group assigned
- Admins group assigned
- Audit group assigned
- App overview validated
- Owners validated
- Properties validated

## Batch 3 Validation
- Direct user membership added to app groups
- Delta sync completed after membership changes
- SAML selected as the SSO method
- Initial Basic SAML values entered
- Certificate (Raw) downloaded
- Login URL, Microsoft Entra Identifier, and Logout URL copied
- Toolkit-side SAML configuration created
- Toolkit-generated SP Initiated Login URL captured
- Toolkit-generated ACS URL captured
- Basic SAML Configuration updated with final values
- Emma Reed SSO succeeded
- adm.olivia.kim SSO succeeded
- Unassigned user access denied
- My Apps launch validated

## Batch 4 Validation
- Provisioning blade reviewed
- Automatic provisioning support decision documented
- Provisioning scope documented
- Attribute mapping plan documented
- Current app-group baseline exported
- Joiner/mover/leaver script prepared for next batch

## Batch 5 Validation
- Joiner membership change completed
- Mover membership change completed
- Leaver membership change completed
- Delta sync completed after JML changes
- Synced app-group membership validated in Entra
- Liam Brooks gained app access path
- Emma Reed retained access through new group path
- Zoe Turner lost My Apps visibility and enterprise assignment path
- Zoe Turner direct access remained possible because downstream app deprovisioning is not automated in this lab
- Manual lifecycle model documented because automatic provisioning is unsupported
