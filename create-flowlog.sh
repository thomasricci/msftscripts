location=${1:-""} 
subscription=${2:-""}
storage_account=${3:-""}
echo "Subscription: $subscription - Region: $location";
az account set -s "$subscription";
for vnet in $(az network vnet list --query "[?location=='$location']" -o json | jq -r .[].id); do
  echo "Creating flow-logs for vNet: $vnet";
  az network watcher flow-log create --location $location --resource-group 'vnetflowlogs-$location' --name "FL-$(basename $vnet)_" --vnet "$vnet"  --storage-account $storage_account;
done;
