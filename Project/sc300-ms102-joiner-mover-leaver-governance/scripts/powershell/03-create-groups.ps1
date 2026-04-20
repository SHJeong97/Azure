param(
    [string]$CsvPath = ".\data\groups\planned-groups.csv"
)

$groups = Import-Csv $CsvPath
$results = @()

foreach ($g in $groups) {
    try {
        $existing = Get-MgGroup -Filter "displayName eq '$($g.GroupName)'" -ConsistencyLevel eventual

        if ($existing) {
            $results += [pscustomobject]@{
                GroupName = $g.GroupName
                Status    = "AlreadyExists"
                Notes     = "Group already present"
            }
            continue
        }

        $mailNickname = (($g.GroupName -replace '[^a-zA-Z0-9]', '').ToLower())

        New-MgGroup `
            -DisplayName $g.GroupName `
            -Description $g.Purpose `
            -MailEnabled:$false `
            -MailNickname $mailNickname `
            -SecurityEnabled:$true | Out-Null

        $results += [pscustomobject]@{
            GroupName = $g.GroupName
            Status    = "Created"
            Notes     = "Group created"
        }
    }
    catch {
        $results += [pscustomobject]@{
            GroupName = $g.GroupName
            Status    = "Failed"
            Notes     = $_.Exception.Message
        }
    }
}

$results | Export-Csv ".\evidence\cli-output\baseline-groups-created.csv" -NoTypeInformation
$results
