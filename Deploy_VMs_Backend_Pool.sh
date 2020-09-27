{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww26140\viewh19060\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs38 \cf0 # Script to create the Backend Pool Virtual Machines (VMs) - VM-01, VM-02, VM-03\
\
az group create \\\
--name RG-12-APPGW \\\
--location westeurope\
\
az network vnet create \\\
--resource-group RG-12-APPGW \\\
--name AZ104-vNET \\\
--address-prefix 10.0.0.0/16 \\\
--subnet-name APPGW-SUBNET \\\
--subnet-prefix 10.0.0.0/24\
\
az network vnet subnet create \\\
--address-prefixes 10.0.1.0/24 \\\
--name BACKEND-SUBNET \\\
--vnet-name AZ104-vNET \\\
--resource-group RG-12-APPGW\
\
# NSG for VM-01\
az network nsg create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-01\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-01-ALLOW-HTTP \\\
  --nsg-name NSG-VM-01 \\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 80 \\\
  --access allow \\\
  --priority 200\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-01-ALLOW-SSH \\\
  --nsg-name NSG-VM-01\\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 22 \\\
  --access allow \\\
  --priority 100\
\
# Deploy VM-01\
\
az vm create \\\
  --resource-group RG-12-APPGW \\\
  --name VM-01 \\\
  --admin-username adminuser \\\
  --admin-password adminadmin123! \\\
  --image UbuntuLTS \\\
  --vnet-name AZ104-vNET \\\
  --nsg NSG-VM-01 \\\
  --subnet BACKEND-SUBNET\
\
az vm extension set \\\
  --publisher Microsoft.Azure.Extensions \\\
  --version 2.0 \\\
  --name CustomScript \\\
  --vm-name VM-01 \\\
  --resource-group RG-12-APPGW \\\
  --settings '\{"commandToExecute":"apt-get -y update && apt-get -y install apache2 && rm -rf /var/www/html && git clone https://github.com/XaaSTechnologies/AppGw-Default-Web-Page.github.io.git /var/www/html/"\}'\
\
# NSG for VM-02\
az network nsg create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-02\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-02-ALLOW-HTTP \\\
  --nsg-name NSG-VM-02 \\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 80 \\\
  --access allow \\\
  --priority 200\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-02-ALLOW-SSH \\\
  --nsg-name NSG-VM-02\\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 22 \\\
  --access allow \\\
  --priority 100\
\
# Deploy VM-02\
\
az vm create \\\
  --resource-group RG-12-APPGW \\\
  --name VM-02 \\\
  --admin-username adminuser \\\
  --admin-password adminadmin123! \\\
  --image UbuntuLTS \\\
  --vnet-name AZ104-vNET \\\
  --nsg NSG-VM-02 \\\
  --subnet BACKEND-SUBNET\
\
az vm extension set \\\
  --publisher Microsoft.Azure.Extensions \\\
  --version 2.0 \\\
  --name CustomScript \\\
  --vm-name VM-02 \\\
  --resource-group RG-12-APPGW \\\
  --settings '\{"commandToExecute":"apt-get -y update && apt-get -y install apache2 && rm -rf /var/www/html && git clone https://github.com/XaaSTechnologies/AppGw-Images-Web-Server.github.io.git /var/www/html/"\}'\
\
\
# NSG for VM-03\
az network nsg create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-03\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-03-ALLOW-HTTP \\\
  --nsg-name NSG-VM-03 \\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 80 \\\
  --access allow \\\
  --priority 200\
\
az network nsg rule create \\\
  --resource-group RG-12-APPGW \\\
  --name NSG-VM-03-ALLOW-SSH \\\
  --nsg-name NSG-VM-03\\\
  --protocol tcp \\\
  --direction inbound \\\
  --source-address-prefix '*' \\\
  --source-port-range '*' \\\
  --destination-address-prefix 'VirtualNetwork' \\\
  --destination-port-range 22 \\\
  --access allow \\\
  --priority 100\
\
# Deploy VM-02\
\
az vm create \\\
  --resource-group RG-12-APPGW \\\
  --name VM-03 \\\
  --admin-username adminuser \\\
  --admin-password adminadmin123! \\\
  --image UbuntuLTS \\\
  --vnet-name AZ104-vNET \\\
  --nsg NSG-VM-03 \\\
  --subnet BACKEND-SUBNET\
\
az vm extension set \\\
  --publisher Microsoft.Azure.Extensions \\\
  --version 2.0 \\\
  --name CustomScript \\\
  --vm-name VM-03 \\\
  --resource-group RG-12-APPGW \\\
  --settings '\{"commandToExecute":"apt-get -y update && apt-get -y install apache2 && rm -rf /var/www/html && git clone https://github.com/XaaSTechnologies/AppGw-Video-Web-Server.github.io.git /var/www/html/"\}'\
\
}