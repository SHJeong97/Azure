param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\planned-groups.csv"
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
                Notes     = "Group already present in tenant"
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
            Notes     = "Group created successfully"
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

$results | Export-Csv "C:\Users\vm1\Desktop\groups-created.csv" -NoTypeInformation
$results
