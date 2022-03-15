

targetScope = 'subscription'
param myResourceGroup string = 'Test-Zelly10'
param location string = 'eastus'



@description('Username for the Virtual Machine.')
param adminUsername string = 'zellyadmin'

@description('Password for the Virtual Machine.')
@minLength(12)

param adminPassword string = 'Pophouse1234%'

@description('Unique DNS Name for the Public IP used to access the Virtual Machine.')
param dnsLabelPrefix string = toLower('${vmName}')

@description('Name for the Public IP used to access the Virtual Machine.')
param publicIpName string = 'myPublicIP'

@description('Allocation method for the Public IP used to access the Virtual Machine.')
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'

@description('SKU for the Public IP used to access the Virtual Machine.')
@allowed([
  'Basic'
  'Standard'
])
param publicIpSku string = 'Basic'

@description('The Windows version for the VM. This will pick a fully patched Gen2 image of this given Windows version.')
@allowed([
 '2019-datacenter-gensecond'
 '2019-datacenter-core-gensecond'
 '2019-datacenter-core-smalldisk-gensecond'
 '2019-datacenter-core-with-containers-gensecond'
 '2019-datacenter-core-with-containers-smalldisk-g2'
 '2019-datacenter-smalldisk-gensecond'
 '2019-datacenter-with-containers-gensecond'
 '2019-datacenter-with-containers-smalldisk-g2'
 '2016-datacenter-gensecond'
])
param OSVersion string = '2019-datacenter-gensecond'

@description('Size of the virtual machine.')
param vmSize string = 'Standard_D2s_v3'



@description('Name of the virtual machine.')
param vmName string = 'Prod-VM01'

param storageAccountName string = 'mystorage010'
param nicName string = 'myVMNic'
param addressPrefix string = '10.0.0.0/16'
param subnetName string = 'Subnet'
param  subnetPrefix string = '10.0.0.0/24'
param virtualNetworkName string = 'MyVNET'
param networkSecurityGroupName string = 'mynsg010'



resource myRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: myResourceGroup
  location: location
}



module vm  'server.bicep' = {
  name: 'vm'
  scope: myRG
  params: {
    location: location
    OSVersion: OSVersion
    vmSize: vmSize
    vmName: vmName
    publicIPAllocationMethod: publicIPAllocationMethod
    storageAccountName: storageAccountName
    nicName: nicName
    subnetName: subnetName
    publicIpSku: publicIpSku
    networkSecurityGroupName: networkSecurityGroupName
    adminPassword: adminPassword
    adminUsername: adminUsername
    addressPrefix: addressPrefix
    virtualNetworkName: virtualNetworkName
    publicIpName: publicIpName
    subnetPrefix: subnetPrefix
    dnsLabelPrefix: dnsLabelPrefix
  }
  
}
