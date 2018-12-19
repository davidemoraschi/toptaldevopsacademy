$ResourceGroupName="toptaldevopsacademy"

az vm create --resource-group $ResourceGroupName --name myVM --image ubuntults --admin-username azureuser --generate-ssh-keys

ssh azureuser@13.80.153.184

az vm deallocate --resource-group $ResourceGroupName --name myVM
az vm generalize --resource-group $ResourceGroupName --name myVM

az image create --resource-group $ResourceGroupName --name myImage --source myVM

az vmss create --resource-group $ResourceGroupName --name myScaleSet --image myImage --admin-username azureuser --generate-ssh-keys

az network lb rule create --resource-group $ResourceGroupName --name myLoadBalancerRuleWeb --lb-name myScaleSetLB --backend-pool-name myScaleSetLBBEPool --backend-port 80 --frontend-ip-name loadBalancerFrontEnd --frontend-port 80 --protocol tcp