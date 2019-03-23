function aks-ver-check {
	CLUSTER_VERSIONS=$(az aks list --query [].[name,kubernetesVersion] -o tsv)
	LATEST_AKS_VERSION=$(az aks get-versions -l eastus --query orchestrators[?upgrades==null].orchestratorVersion -o tsv)
	echo $CLUSTER_VERSIONS
	echo "Latest AKS Version: $LATEST_AKS_VERSION"
}