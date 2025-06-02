location=${1:-""} 
subscription=${2:-""}
echo "Subscription: $subscription - Region: $location";
az account set -s "$subscription";
for vnet in $(az network vnet list --query "[?location=='$location']" -o json | jq -r .[].id); do
  echo "Creating flow-logs for vNet: $vnet";
  az network watcher flow-log create --location $location --resource-group 'vnetflowlogs-$location' --name "FL-$(basename $vnet)_" --vnet "$vnet"  --storage-account '/subscriptions/9bd7ff15-396a-4478-a89b-4d8ae7e302b6/resourceGroups/vnetflowlogs-westus2/providers/Microsoft.Storage/storageAccounts/flstrgzh6vouaebr4qe';
done;
