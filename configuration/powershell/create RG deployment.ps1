$ResourceGroupName="ToptalDevOpsAcademy"

#https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-automate-vm-deployment
$customData = Get-Content -Path .\cloud-init.txt 

# Removes Resource Group
Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Verbose -Force

# Creates Resource Group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"

# Creates 3 tier infrastructure
New-AzureRmResourceGroupDeployment -Name ToptalDevOpsAcademyDeployment -ResourceGroupName $ResourceGroupName -TemplateFile .\azuredeploy.json -adminUsername dmoraschi -customData $customData

del C:\Users\Davide\.ssh\known_hosts

#ssh -oStrictHostKeyChecking=accept-new dmoraschi@dmoraschi-jump.westeurope.cloudapp.azure.com "curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -"

ssh -oStrictHostKeyChecking=accept-new dmoraschi@dmoraschi-jump.westeurope.cloudapp.azure.com ##### "sudo apt-get install -y nodejs"

