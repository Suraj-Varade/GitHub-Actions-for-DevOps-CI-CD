
// based on the environment, your storage account name should be different.
// i will create a params

param storage_account_name_prefix string
param location string = resourceGroup().location
param container_registry_name string = 'newdemoacr'
param azure_service_bus_name string = 'newdemoservicebus'
param app_name string = 'newdemoappname'
param service_plan_name string = 'ASP-${app_name}'
var st_acct_name = '${storage_account_name_prefix}${uniqueString(resourceGroup().id)}'


// uniqueString - Creates a deterministic hash string based on the values provided as parameters. 
// The returned value is 13 characters long.

resource storage_account 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: st_acct_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource container_registry 'Microsoft.ContainerRegistry/registries@2025-05-01-preview' = {
  name: container_registry_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties:{
    adminUserEnabled:true
  }
}


resource service_bus 'Microsoft.ServiceBus/namespaces@2025-05-01-preview' = {
  name: azure_service_bus_name
  location: location
}

resource servicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: service_plan_name
  location: location
  kind: 'linux'
  sku: {
    tier: 'Basic'
    name: 'B1'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  dependsOn: []
}


resource name_resource 'Microsoft.Web/sites@2024-11-01' = {
  name: app_name
  location: location
  tags: {}
  properties: {
    serverFarmId: servicePlan.id
    clientAffinityEnabled:false
    httpsOnly:true
  }
}


// to test =>
// 1) az login
// 2) az deployment group create --resource-group user-zzgptqiljtyh --template-file deploy_env.bicep

// response =>> 
/*
az deployment group create --resource-group user-zzgptqiljtyh --template-file deploy_env.bicep

Please provide string value for 'storage_account_name_prefix' (? for help): learntech
{
  "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Resources/deployments/deploy_env",
  "location": null,
  "name": "deploy_env",
  "properties": {
    "correlationId": "16edf6c6-b1d4-4949-b689-738ff59b724a",
    "debugSetting": null,
    "dependencies": [
      {
        "dependsOn": [
          {
            "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Web/serverfarms/ASP-learningtechappname",
            "resourceGroup": "user-zzgptqiljtyh",
            "resourceName": "ASP-learningtechappname",
            "resourceType": "Microsoft.Web/serverfarms"
          }
        ],
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Web/sites/learningtechappname",
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceName": "learningtechappname",
        "resourceType": "Microsoft.Web/sites"
      }
    ],
    "diagnostics": null,
    "duration": "PT53.7854765S",
    "error": null,
    "extensions": null,
    "mode": "Incremental",
    "onErrorDeployment": null,
    "outputResources": [
      {
        "apiVersion": null,
        "extension": null,
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.ContainerRegistry/registries/learningtechacr",
        "identifiers": null,
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceType": null
      },
      {
        "apiVersion": null,
        "extension": null,
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.ServiceBus/namespaces/learningtechservicebus",
        "identifiers": null,
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceType": null
      },
      {
        "apiVersion": null,
        "extension": null,
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Storage/storageAccounts/learntechp7m27cvs5ipdm",
        "identifiers": null,
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceType": null
      },
      {
        "apiVersion": null,
        "extension": null,
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Web/serverfarms/ASP-learningtechappname",
        "identifiers": null,
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceType": null
      },
      {
        "apiVersion": null,
        "extension": null,
        "id": "/subscriptions/475069f1-ec8f-4699-be2f-18ad05853311/resourceGroups/user-zzgptqiljtyh/providers/Microsoft.Web/sites/learningtechappname",
        "identifiers": null,
        "resourceGroup": "user-zzgptqiljtyh",
        "resourceType": null
      }
    ],
    "outputs": null,
    "parameters": {
      "app_name": {
        "type": "String",
        "value": "learningtechappname"
      },
      "azure_service_bus_name": {
        "type": "String",
        "value": "learningtechservicebus"
      },
      "container_registry_name": {
        "type": "String",
        "value": "learningtechacr"
      },
      "location": {
        "type": "String",
        "value": "eastus"
      },
      "service_plan_name": {
        "type": "String",
        "value": "ASP-learningtechappname"
      },
      "storage_account_name_prefix": {
        "type": "String",
        "value": "learntech"
      }
    },
    "parametersLink": null,
    "providers": [
      {
        "id": null,
        "namespace": "Microsoft.Storage",
        "providerAuthorizationConsentState": null,
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "storageAccounts",
            "zoneMappings": null
          }
        ]
      },
      {
        "id": null,
        "namespace": "Microsoft.ContainerRegistry",
        "providerAuthorizationConsentState": null,
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "registries",
            "zoneMappings": null
          }
        ]
      },
      {
        "id": null,
        "namespace": "Microsoft.ServiceBus",
        "providerAuthorizationConsentState": null,
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "namespaces",
            "zoneMappings": null
          }
        ]
      },
      {
        "id": null,
        "namespace": "Microsoft.Web",
        "providerAuthorizationConsentState": null,
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "serverfarms",
            "zoneMappings": null
          },
          {
            "aliases": null,
            "apiProfiles": null,
            "apiVersions": null,
            "capabilities": null,
            "defaultApiVersion": null,
            "locationMappings": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "sites",
            "zoneMappings": null
          }
        ]
      }
    ],
    "provisioningState": "Succeeded",
    "templateHash": "15806345913245436850",
    "templateLink": null,
    "timestamp": "2025-10-22T09:20:44.655739+00:00",
    "validatedResources": null,
    "validationLevel": null
*/
