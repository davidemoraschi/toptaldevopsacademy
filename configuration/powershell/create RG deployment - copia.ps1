$ResourceGroupName="ToptalDevOpsAcademy3"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"

New-AzureRmResourceGroupDeployment -Name ToptalDevOpsAcademyDeployment -ResourceGroupName $ResourceGroupName -TemplateFile C:\Toptal\powershell\rh3tier.json -adminUsername davidem 
