## Leaver
User:
- zoe.turner@democompany1016.onmicrosoft.com

Change:
- Removed from all BusinessPortal access groups

Expected:
- Loses enterprise app assignment
- No longer sees the app in My Apps

Observed:
- My Apps visibility was removed as expected
- Direct access to the Toolkit app could still succeed because the target application retains its own local user account model

Interpretation:
- Microsoft Entra assignment lifecycle worked correctly
- Downstream account deactivation did not occur automatically because BusinessPortal - Entra SAML Toolkit does not support out-of-the-box automatic provisioning in this lab
