$ResourceGroupName = "ToptalDevOpsAcademy"
$StorageAccountName = "dmoraschiscripts"
$ubuntuscripts = 'ubuntu-scripts'

Set-AzureRmVMCustomScriptExtension -Name 'myCSE' -ContainerName $ubuntuscripts -FileName installnode.sh -StorageAccountName $StorageAccountName -ResourceGroupName $ResourceGroupName -VMName 'jump-vm' -Run installnode.sh -Location "West Europe"

remove-AzureRmVMCustomScriptExtension -Name 'myCSE' -ResourceGroupName $ResourceGroupName -VMName 'jump-vm' -Force