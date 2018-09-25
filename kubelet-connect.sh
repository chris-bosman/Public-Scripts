function kubeconnect {
    CLUSTER_NAME=$(printf "%q" $1)
    AKS_RESOURCE_GROUP=$(az resource list -n $CLUSTER_NAME --query [].resourceGroup -o tsv)
    NODE_RESOURCE_GROUP=$(az aks show -g $AKS_RESOURCE_GROUP --n $CLUSTER_NAME --query nodeResourceGroup -o tsv)
    VM_NAME=$(az vm list -g $NODE_RESOURCE_GROUP --query [0].name | tr -d '"')
    VM_IP=$(az vm list-ip-addresses -g $NODE_RESOURCE_GROUP -n $VM_NAME --query [].virtualMachine.network.privateIpAddresses[0] -o tsv)

    az vm user update -g $NODE_RESOURCE_GROUP -n $VM_NAME -u azureuser --ssh-key-value ~/.ssh/id_rsa.pub
    az aks get-credentials -g $AKS_RESOURCE_GROUP -n $CLUSTER_NAME
    kubectl run -it --rm aks-ssh -l "app=ssh" --image=ssh
}