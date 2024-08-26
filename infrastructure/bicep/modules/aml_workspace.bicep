param aml_workspace string
param location string
param stoacctid string
param kvid string
param appinsightid string
param crid string
param tags object

// AML workspace
resource amls 'Microsoft.MachineLearningServices/workspaces@2024-07-01-preview' = {
  name: aml_workspace
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    tier: 'basic'
    name: 'basic'
  }
  properties: {
    storageAccount: stoacctid
    keyVault: kvid
    applicationInsights: appinsightid
    containerRegistry: crid
    encryption: {
      status: 'Disabled'
      keyVaultProperties: {
        keyIdentifier: ''
        keyVaultArmId: ''
      }
    }
  }

  tags: tags
}

output amlsName string = amls.name
