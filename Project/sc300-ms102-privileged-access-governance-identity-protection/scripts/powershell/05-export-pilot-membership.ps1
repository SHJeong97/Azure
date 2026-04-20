param(
    [string[]]$Users = @(
        "breakglass-01@democompany1016.onmicrosoft.com",
        "breakglass-02@democompany1016.onmicrosoft.com",
        "ava.foster@democompany1016.onmicrosoft.com",
        "ethan.walker@democompany1016.onmicrosoft.com",
        "rachel.kim@democompany1016.onmicrosoft.com",
        "mason.lee@democompany1016.onmicrosoft.com",
        "emma.reed@democompany1016.onmicrosoft.com",
        "olivia.chen@democompany1016.onmicrosoft.com"
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

$results | Sort-Object UserPrincipalName, GroupName | Export-Csv "C:\Users\vm1\Desktop\pilot-membership-export.csv" -NoTypeInformation
$results
