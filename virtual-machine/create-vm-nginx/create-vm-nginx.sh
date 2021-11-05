#!/bin/bash

# Create a resource group.
az group create --name rg-LamHT13 --location westeurope

# Create a new virtual machine, this creates SSH keys if not present.
az vm create --resource-group rg-LamHT13 --name LamHT13VM --image UbuntuLTS --generate-ssh-keys

# Open port 80 to allow web traffic to host.
az vm open-port --port 80 --resource-group rg-LamHT13 --name LamHT13VM 

# Use CustomScript extension to install NGINX.
az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name LamHT13VM \
  --resource-group rg-LamHT13 \
  --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx"}'
