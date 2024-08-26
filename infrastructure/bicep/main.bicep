targetScope = 'subscription'

param location string = 'westus2'
param namespace string
param env string 

param resource_group string
param storage_account string
param key_vault string
param application_insights string
param container_registry string
param aml_workspace string


param ownerTag string
param projectTag string

param tags object = {
  Owner: ownerTag
  Project: projectTag
  Environment: env
  Toolkit: 'bicep'
  Name: namespace
}


resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resource_group
  location: location

  tags: tags
}

// Storage Account
module st 'modules/storage_account.bicep' = {
  name: 'st'
  scope: resourceGroup(rg.name)
  params: {
    //baseName: '${uniqueString(rg.id)}${env}'
    storage_account: storage_account
    location: location
    tags: tags
  }
}

// Key Vault
module kv 'modules/key_vault.bicep' = {
  name: 'kv'
  scope: resourceGroup(rg.name)
  params: {
    key_vault: key_vault
    location: location
    tags: tags
  }
}

// App Insights
module appi 'modules/application_insights.bicep' = {
  name: 'appi'
  scope: resourceGroup(rg.name)
  params: {
    application_insights: application_insights
    location: location
    tags: tags
  }
}

// Container Registry
module cr 'modules/container_registry.bicep' = {
  name: 'cr'
  scope: resourceGroup(rg.name)
  params: {
    //baseName: '${uniqueString(rg.id)}${env}'
    container_registry: container_registry
    location: location
    tags: tags
  }
}

// AML workspace
module amlw 'modules/aml_workspace.bicep' = {
  name: 'amlw'
  scope: resourceGroup(rg.name)
  params: {
    aml_workspace: aml_workspace
    location: location
    stoacctid: st.outputs.stoacctOut
    kvid: kv.outputs.kvOut
    appinsightid: appi.outputs.appinsightOut
    crid: cr.outputs.crOut
    tags: tags
  }
}

// AML compute cluster
module mlwcc 'modules/aml_computecluster.bicep' = {
  name: 'mlwcc'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    workspaceName: amlw.outputs.amlsName
  }
}
