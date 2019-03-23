function tiller-ver-check {
	CLUSTERS=$(az aks list --query [].name -o tsv)
	CLIENT_TILLER_VER=$(helm version -c | sed -e 's/.*SemVer:"\(.*\)GitCommit.*/\1/' | rev | cut -c 4- | rev)
	LATEST_TILLER_VER=$(curl -is https://api.github.com/repos/helm/helm/releases/latest | grep tag_name | sed -e 's/.*: "\(.*\)",.*/\1/')
	for cluster in $CLUSTERS; do
		kubectl config use-context $cluster
		CLUSTER_TILLER_VER=$(helm version -s | sed -e 's/.*SemVer:"\(.*\)GitCommit.*/\1/' | rev | cut -c 4- | rev)
		echo "$cluster: $CLUSTER_TILLER_VER"
	done
	echo "Client Tiller Version: $CLIENT_TILLER_VER"
	echo "Latest Tiller Version: $LATEST_TILLER_VER"
}