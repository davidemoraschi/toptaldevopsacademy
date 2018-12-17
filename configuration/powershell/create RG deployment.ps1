$ResourceGroupName="ToptalDevOpsAcademy"

#https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-automate-vm-deployment
$customData = "#cloud-config
package_upgrade: true
packages:
  - nginx
  - nodejs
  - npm
  - nodejs-legacy
write_files:
  - owner: www-data:www-data
  - path: /etc/nginx/sites-available/default
    content: |
      server {
        listen 80;
        location / {
          proxy_pass http://localhost:3000;
          proxy_http_version 1.1;
          proxy_set_header Upgrade `$http_upgrade;
          proxy_set_header Connection keep-alive;
          proxy_set_header Host $host;
          proxy_cache_bypass `$http_upgrade;
        }
      }
  - owner: azureuser:azureuser
  - path: /home/azureuser/myapp/index.js
    content: |
      var express = require('express')
      var app = express()
      var os = require('os');
      app.get('/', function (req, res) {
        res.send('Hello World from host ' + os.hostname() + '!')
      })
      app.listen(3000, function () {
        console.log('Hello world app listening on port 3000!')
      })
runcmd:
  - service nginx restart
  - cd '/home/azureuser/myapp'
  - npm init
  - npm install express -y
  - nodejs index.js
  
# Capture all subprocess output into a logfile
# Useful for troubleshooting cloud-init issues
output: {all: '| tee -a /var/log/cloud-init-output.log'}"

# Removes Resource Group
Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Verbose -Force

# Creates Resource Group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location "West Europe"

# Creates 3 tier infrastructure
New-AzureRmResourceGroupDeployment -Name ToptalDevOpsAcademyDeployment -ResourceGroupName $ResourceGroupName -TemplateFile .\azuredeploy.json -adminUsername dmoraschi -customData $customData

del C:\Users\Davide\.ssh\known_hosts

#ssh -oStrictHostKeyChecking=accept-new dmoraschi@dmoraschi-jump.westeurope.cloudapp.azure.com "curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -"

ssh -oStrictHostKeyChecking=accept-new dmoraschi@dmoraschi-jump.westeurope.cloudapp.azure.com ##### "sudo apt-get install -y nodejs"

