echo 'Checking if Bump is installed for incrementing versioning of YAML files...'
BUMP_PATH=$(which bump)
BUMP_CHECK=$(grep 'CFG = ".bump.yml"' $BUMP_PATH)
if [ -z $BUMP_PATH ]; then
    echo 'Bump not found, installing Bump...'
    pip install PyYAML semantic-version schema
    mkdir /opt/bump
    wget https://raw.githubusercontent.com/fredshonorio/bump/master/bump.py -O /opt/bump/bump.py
    ln -s /opt/bump/bump.py /usr/local/bin/bump
    echo 'Bump installed.'
done
if [ -z $BUMP_CHECK ]; then
    echo 'You are already using the alias Bump for something else, after installing, we will give this code the alias "bump-helm"...'
    echo 'Installing Bump...'
    pip install PyYAML semantic-version schema
    mkdir /opt/bump
    wget https://raw.githubusercontent.com/fredshonorio/bump/master/bump.py -O /opt/bump/bump.py
    ln -s /opt/bump/bump.py /usr/local/bin/bump-helm
done

CHART_HOME=$(helm home)
echo 'Checking your local Chart repository $CHART_HOME for charts...'
for path in $CHART_HOME; do
    [ -d "${path}" ] || continue
    dirname="$(basename "${path}")"
    if [ -f $dirname/Chart.yaml ]; then
        echo "Creating Bump files for any Charts that do not already have them..."
        if [ ! -f $dirname/bump.yml ]; then
            cd $dirname
            cat > ./bump.yml <<EOL
files:
  - path: Chart.yaml
    pattern: "version: (.*)"
exec_before: []
exec_after: []
EOL
        fi
        cd $dirname
        echo "Removing existing Chart tarball..."
        rm *.tgz
        echo "Bumping patch verison number in Chart.yaml..."
        bump patch
        rm *.bkp
        echo "Packaging Chart in $dirname"
        helm package -u .
        echo "Index Chart repository"
        helm repo index ..
done