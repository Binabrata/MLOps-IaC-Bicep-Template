# Azure DevOps - Infrastructure as Code - Template

This template project can be impoted in Azure DevOps's repo and then need to create a pipeline to execute the YAML file to create infrastucture in Azure 

Prerequisite:

1. Need to create Service Principle for each environment through Azure Entra ID and then need to provide contributor role to that Service Principle.
2. Need to create a new Azure DevOps project and then need to create a connection with that Service Princinple through the settings of the project.
3. Need to updated the Service Connection Name in the environment configuration yaml file.
