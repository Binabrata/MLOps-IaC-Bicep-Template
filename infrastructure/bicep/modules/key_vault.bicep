param key_vault string
param location string
param tags object

// Key Vault
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: key_vault
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []
  }

  tags: tags
}

output kvOut string = kv.id
