$ResourceGroupName="ToptalDevOpsAcademy"
$StorageAccountName = "dmoraschiscripts"
$ubuntuscripts = 'ubuntu-scripts'

$StorageAccount = New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -SkuName 'Standard_GRS' -Kind 'Storage' -Location "West Europe"
$context = $StorageAccount.Context
Set-AzureRmCurrentStorageAccount -Context $Context
New-AzureStorageContainer -name $ubuntuscripts
Set-AzureStorageBlobContent -File 'C:\Toptal\node-3tier-app\configuration\powershell\installnode.sh' -container $ubuntuscripts
