﻿$ResourceGroupName="toptaldevopsacademy"

#https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-automate-vm-deployment
$customDataWeb = Get-Content -Raw -Path .\cloud-init-web.txt 
$customDataApi = Get-Content -Raw -Path .\cloud-init-api.txt 

# Removes Resource Group
Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Verbose -Force

# Creates Resource Group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"

# Creates 3 tier infrastructure
New-AzureRmResourceGroupDeployment -Name ToptalDevOpsAcademyDeployment -ResourceGroupName $ResourceGroupName -TemplateFile .\azuredeploy.json -adminUsername dmoraschi -customDataWeb $customDataWeb -customDataApi $customDataApi

# del C:\Users\Davide\.ssh\known_hosts
$FileName = "C:\Users\Davide\.ssh\known_hosts"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

ssh -oStrictHostKeyChecking=accept-new dmoraschi@node-3tier-mgm-dmoraschi.westeurope.cloudapp.azure.com

