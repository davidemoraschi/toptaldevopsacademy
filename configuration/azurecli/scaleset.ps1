
$ResourceGroupName = "toptaldevopsacademy"
$WestEurope = "westeurope"
$ScaleSetName = "ubuntu-scaleset"
$AdminUser = "dmoraschi"
$outputformat = "table"

#Clean up deployment
@echo deleting resource group
az group delete --name $ResourceGroupName 

# Create a resource group
@echo creating resource group
az group create --name $ResourceGroupName --location $WestEurope --output $outputformat 

# Create a zone-redundant scale set across zones 1, 2, and 3
# This command also creates a 'Standard' SKU public IP address and load balancer
# For the Load Balancer Standard SKU, a Network Security Group and rules are also created
@echo creating scale set
az vmss create --resource-group $ResourceGroupName --name $ScaleSetName --image UbuntuLTS --upgrade-policy-mode automatic --admin-username $AdminUser --generate-ssh-keys --zones 1 2 3 --output $outputformat 

# Apply the Custom Script Extension that installs a basic Nginx webserver
@echo creating extension
az vmss extension set --publisher Microsoft.Azure.Extensions --version 2.0 --name CustomScript --resource-group $ResourceGroupName --vmss-name $ScaleSetName --settings '{"fileUris":"https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx.sh"],"commandToExecute":"./automate_nginx.sh"}' --output $outputformat 
