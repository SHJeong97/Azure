param(
    [string[]]$Users = @(
        "olivia.park@democompany1016.onmicrosoft.com",
        "sophia.brooks@democompany1016.onmicrosoft.com"
    )
)

$results = @()

foreach ($upn in $Users) {
    try {
        $user = Get-MgUser -UserId $upn -ErrorAction Stop
        $memberOf = Get-MgUserMemberOf -UserId $user.Id -All

        foreach ($obj in $memberOf) {
            if ($obj.AdditionalProperties.displayName) {
                $results += [pscustomobject]@{
                    UserPrincipalName = $upn
                    GroupName         = $obj.AdditionalProperties.displayName
                }
            }
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $upn
            GroupName         = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Sort-Object UserPrincipalName, GroupName | Export-Csv "C:\Users\vm1\Desktop\mover-membership-export.csv" -NoTypeInformation
$results
