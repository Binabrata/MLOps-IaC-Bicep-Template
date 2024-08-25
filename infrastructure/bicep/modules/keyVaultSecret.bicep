param key_vault string
param key string
param value string


// Key Vault
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: key_vault
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: kv
  name: key
  properties: {
    value: value
  }
}
