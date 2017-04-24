# First login on SQL-VM-011 and allow remote powershell Enable-PSRemoting -Force. Also for subnet NSG inbound rule add WinRM (TCP/5986)
$nodes = ("SQL-VM-010.cadoe4321.com", "SQL-VM-011.cadoe4321.com")
icm $nodes {Install-WindowsFeature Failover-Clustering -IncludeAllSubFeature -IncludeManagementTools}
New-Cluster -Name SQL_S2D_Cluster -Node $nodes -StaticAddress 10.1.2.20
Enable-ClusterS2D
New-Volume -StoragePoolFriendlyName S2D* -FriendlyName SQLDisk -FileSystem CSVFS_ReFS -Size 2000GB
Get-ClusterSharedVolume