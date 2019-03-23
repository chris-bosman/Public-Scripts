function helm-bump {
    VERSION=$(printf "%q" $1)
	rm *.tgz
	if [ $VERSION = "''" ]; then
		bump patch
	else
		bump $VERSION
	fi
	rm *.bkp
	helm package -u .
        helm repo index ..
}