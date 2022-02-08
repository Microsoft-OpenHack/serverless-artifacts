param win10sku string = '20h2-pro'

var resourcePrefix = 'soh'
var virtualNetworkName = '${resourcePrefix}-vnet'
var nicName = '${resourcePrefix}-jumpbox-nic'
var vnetAddressPrefix = '10.0.0.0/16'
var jumpboxSubnetName = 'jumpbox'
var jumpboxSubnetAddress = '10.0.0.0/24'
var receiptEventProcessingSubnetName = 'receipt-processing'
var receiptEventProcessingSubnetAddress = '10.0.1.0/24'
var salesEventProcessingSubnetName = 'sale-processing'
var salesEventProcessingSubnetAddress = '10.0.2.0/24'
var pubsubSubnetName = 'pub-sub-messages'
var pubsubSubnetAddress = '10.0.3.0/24'
var bastionSubnetAddress = '10.0.4.0/26'
var bastionPublicIpAddressName = '${resourcePrefix}-bastion-pip'
var bastionHostName='${resourcePrefix}-bastion-host'
var virtualMachineName = '${resourcePrefix}-jumpbox'
var virtualMachineAdminUsername = 'serverless'
var virtualMachineAdminPassword = 'Serverless4All!'
var vmDiagnosticStorageAccountName = '${resourcePrefix}vmdiag${uniqueString(resourceGroup().id)}'
var publicIPAddressName = '${resourcePrefix}-jumpbox-pip'
var dnsLabelPrefix = '${resourcePrefix}-jump-${uniqueString(resourceGroup().id)}'
var jumpboxNsgName_var = '${resourcePrefix}-jumpbox-nsg'
var salesDataStorageAccountName_var = '${resourcePrefix}sales${uniqueString(resourceGroup().id)}'

resource vmDiagnosticStorageAccount 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: vmDiagnosticStorageAccountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  properties: {}
}

resource salesDataStorageAccountName 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: salesDataStorageAccountName_var
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'None'
      virtualNetworkRules: [
        {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, receiptEventProcessingSubnetName)
          action: 'Allow'
        }
        {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, jumpboxSubnetName)
          action: 'Allow'
        }
      ]
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource salesDataStorageAccountName_default_receipts 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-04-01' = {
  name: '${salesDataStorageAccountName_var}/default/receipts'
  dependsOn: [
    salesDataStorageAccountName
  ]
}

resource salesDataStorageAccountName_default_receipts_high_value 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-04-01' = {
  name: '${salesDataStorageAccountName_var}/default/receipts-high-value'
  dependsOn: [
    salesDataStorageAccountName
  ]
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2019-03-01' = {
  name: virtualMachineName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2_v3'
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: virtualMachineAdminUsername
      adminPassword: virtualMachineAdminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-10'
        sku: win10sku
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Nework/networkInterfaces', nicName)
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: vmDiagnosticStorageAccount.properties.primaryEndpoints.blob
      }
    }
  }
  dependsOn: [
    nic
  ]
}

resource shutdown_computevm_virtualMachineName 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-${virtualMachineName}'
  location: resourceGroup().location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '1900'
    }
    timeZoneId: 'UTC'
    notificationSettings: {
      status: 'Disabled'
    }
    targetResourceId: virtualMachine.id
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-07-01' = {
  name: virtualNetworkName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: receiptEventProcessingSubnetName
        properties: {
          addressPrefix: receiptEventProcessingSubnetAddress
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: salesEventProcessingSubnetName
        properties: {
          addressPrefix: salesEventProcessingSubnetAddress
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
          delegations: [ ]
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: pubsubSubnetName
        properties: {
          addressPrefix: pubsubSubnetAddress
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: jumpboxSubnetName
        properties: {
          addressPrefix: jumpboxSubnetAddress
          networkSecurityGroup: {
            id: jumpboxNsgName.id
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
    enableVmProtection: false
  }
}

resource azureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: '${virtualNetworkName}/AzureBastionSubnet'
  properties: {
    addressPrefix: bastionSubnetAddress
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: bastionPublicIpAddressName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2021-02-01' = {
  name: bastionHostName
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConfig'
        properties: {
          subnet: {
            id: azureBastionSubnet.id
          }
          publicIPAddress: {
            id: bastionPublicIp.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2018-11-01' = {
  name: nicName
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, jumpboxSubnetName)
          }
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource jumpboxNsgName 'Microsoft.Network/networkSecurityGroups@2019-04-01' = {
  name: jumpboxNsgName_var
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'Block_RDP_Internet'
        properties: {
          description: 'Block RDP'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 101
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2018-11-01' = {
  name: publicIPAddressName
  location: resourceGroup().location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
}
