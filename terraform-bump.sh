function terra-bump {
	GIT_TAG=""
	cwd=$(pwd)
	cd $TERRA_HOME/live
	for tfvars_file in `find . -not -path "*cache*" -name "*.tfvars"`; do
		if grep "ref=v" "$tfvars_file"; then
			LINE=$(grep "ref=v" "$tfvars_file")
			VERSION=$(echo "$LINE" | sed -e 's/.*[?ref=v] *//')
			OLD_PATCH=$(echo $VERSION | cut -d '.' -f3)
			CUT_OLD_PATCH=$(echo $OLD_PATCH | cut -d '"' -f1)
			NEW_PATCH="$((CUT_OLD_PATCH + 1))"
			sed -i'.bk' -e "s/ref=v0.0.$CUT_OLD_PATCH/ref=v0.0.$NEW_PATCH/g" $tfvars_file
			grep "ref=v" "$tfvars_file"
			GIT_TAG=$NEW_PATCH
		fi
	done
	git tag -a "v0.0.$GIT_TAG" -m "Version Bump"
	git push --follow-tags
	cd $cwd
}