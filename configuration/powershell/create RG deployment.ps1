$ResourceGroupName="ToptalDevOpsAcademy"

# Removes Resource Group
Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Verbose -Force

# Creates Resource Group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"

# Creates 3 tier infrastructure
New-AzureRmResourceGroupDeployment -Name ToptalDevOpsAcademyDeployment -ResourceGroupName $ResourceGroupName -TemplateFile .\rh3tier.json
