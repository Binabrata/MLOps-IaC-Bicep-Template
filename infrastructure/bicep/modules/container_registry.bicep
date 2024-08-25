param container_registry string
param location string
param tags object

resource cr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: container_registry
  location: location
  sku: {
    name: 'Standard'
  }

  properties: {
    adminUserEnabled: true
  }

  tags: tags
}

output crOut string = cr.id
