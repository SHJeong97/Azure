$PilotPlan = @(
    [PSCustomObject]@{
        PilotUser = "emma.wilson"
        Department = "HR"
        CurrentUPN = "emma.wilson@corp.democompany1016.local"
        TargetUPN = "emma.wilson@summitridge-mfg.com"
        RollbackUPN = "emma.wilson@corp.democompany1016.local"
        MigrationType = "Pilot"
        Status = "Planned"
    }
    [PSCustomObject]@{
        PilotUser = "olivia.brown"
        Department = "Finance"
        CurrentUPN = "olivia.brown@corp.democompany1016.local"
        TargetUPN = "olivia.brown@summitridge-mfg.com"
        RollbackUPN = "olivia.brown@corp.democompany1016.local"
        MigrationType = "Pilot"
        Status = "Planned"
    }
    [PSCustomObject]@{
        PilotUser = "sophia.martinez"
        Department = "IT"
        CurrentUPN = "sophia.martinez@corp.democompany1016.local"
        TargetUPN = "sophia.martinez@summitridge-mfg.com"
        RollbackUPN = "sophia.martinez@corp.democompany1016.local"
        MigrationType = "Pilot"
        Status = "Planned"
    }
)

$PilotPlan |
Export-Csv "C:\LabEvidence\Project03\Batch04\batch-04-pilot-upn-plan.csv" -NoTypeInformation