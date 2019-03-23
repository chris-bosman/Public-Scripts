function acr-clean {
	REPO=$(printf "%q" $1)
	if [ -z $REPO ]; then
		echo "Error. No repository name given."
		exit
	else
		STALE_IMAGES=$(az acr repisitory show-tags -n predictiveindexacr --repository $REPO --detail --query '[].createdTime,name]' -o tsv | sort -k1 | tail -r | tail -n +10 | awk '{print $2}')
		for image in $STALE_IMAGES; do
			az acr login -n predictiveindexacr
			az acr repository delete -n predictiveindexacr -t $REPO:$image -y
		done
	fi
}