# deploy on azure 

## container app
```bash
location=southeastasia
group=v2ray
az group create --location $location --name $group
az config set defaults.location=$location defaults.group=$group
environment=production
az containerapp env create --name $environment
az containerapp create --name wss --environment $environment --yaml azure.yaml
```
