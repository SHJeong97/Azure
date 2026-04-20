param(
    [string]$CsvPath = ".\data\users\mover-users.csv"
)

$movers = Import-Csv $CsvPath
$results = @()

foreach ($m in $movers) {
    try {
        $user = Get-MgUser -UserId $m.CurrentUserPrincipalName -ErrorAction Stop

        Update-MgUser -UserId $user.Id -Department $m.NewDepartment

        $results += [pscustomobject]@{
            UserPrincipalName = $m.CurrentUserPrincipalName
            Action            = "DepartmentUpdated"
            Status            = "Success"
            Notes             = "Department changed to $($m.NewDepartment)"
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $m.CurrentUserPrincipalName
            Action            = "DepartmentUpdated"
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv ".\evidence\cli-output\mover-department-update-results.csv" -NoTypeInformation
$results
