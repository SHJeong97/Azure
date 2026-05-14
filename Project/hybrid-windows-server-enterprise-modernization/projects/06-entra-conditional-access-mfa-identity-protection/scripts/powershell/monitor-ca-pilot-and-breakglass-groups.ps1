# Project 06 Batch 8
# Monitor CA pilot and break-glass group membership.

Connect-MgGraph -Scopes "Group.Read.All","User.Read.All"

$CAPilotGroupName = "GRP-CA-Pilot-Users"
$BreakGlassGroupName = "GRP-CA-Excluded-BreakGlass"

$CAPilotGroup = Get-MgGroup `
    -Filter "displayName eq '$CAPilotGroupName'" `
    -Property Id,DisplayName `
    -ErrorAction Stop

$BreakGlassGroup = Get-MgGroup `
    -Filter "displayName eq '$BreakGlassGroupName'" `
    -Property Id,DisplayName `
    -ErrorAction Stop

$CAPilotGroupMembers = Get-MgGroupMember -GroupId $CAPilotGroup.Id -All |
ForEach-Object {
    Get-MgUser -UserId $_.Id -Property DisplayName,UserPrincipalName,AccountEnabled
} |
Select-Object `
    @{Name="GroupName";Expression={$CAPilotGroupName}},
    DisplayName,
    UserPrincipalName,
    AccountEnabled

$BreakGlassGroupMembers = Get-MgGroupMember -GroupId $BreakGlassGroup.Id -All |
ForEach-Object {
    Get-MgUser -UserId $_.Id -Property DisplayName,UserPrincipalName,AccountEnabled
} |
Select-Object `
    @{Name="GroupName";Expression={$BreakGlassGroupName}},
    DisplayName,
    UserPrincipalName,
    AccountEnabled

$CAPilotGroupMembers
$BreakGlassGroupMembers