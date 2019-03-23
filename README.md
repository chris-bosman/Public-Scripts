# Public Scripts

This is a collection of bash scripts. Probably could be a gist, but whatever.

## Check-Aks-Ver

**Usage:** `check-aks-ver`

Checks an Azure tenant for the Kubernetes version of all Azure Kubernetes Service (AKS) instances that exist in the subscription and compares those versions with the latest AKS version available.

## Check-Tiller-Ver

**Usage:** `check-tiller-ver`

Checks an Azure tenant for the Tiller(Helm) version of all AKS instances, and compares them with the latest Tiller version available. Changing the $CLUSTERS variable within this script will allow you to collect that information from any list of clusters.

## Clean-ACR

**Usage:** `clean-acr <acr-registry-name>`

This script will clean up all but the 10 newest images from an Azure Container Registry.

## Docker-Cleanup

**Usage:** `docker-cleanup`

Gets a list of all Docker containers and images on the local Docker machine and runs `docker rm` on the containers list and `docker rmi` on the images list. Running containers and in-use images will by default not delete, but still be careful as these are very destructive commands.

## Helm-Bump

**Usage:** `~/helm-repo-dir/helm-bump`, `~/helm-repo-dir/helm-bump 1.1.0`

**Prerequisite:** [Bump](https://github.com/fredshonorio/bump)

If you run this in the directory of a Helm chart with no argument, it'll automatically increment the patch version of the chart by 1, then package and index the chart. If you provide an argument of a SemVer-valid version, it will change the version of the Helm chart to the provided version.

## Kubelet-Connect

**NOTE:** Unfinished

**Usage:** `kubeconnect <cluster-name>`

There are cases where you may need to connect to the nodes within an AKS cluster. This command will automate the process of doing so by:

* Updating a node in the cluster with the machine's public key located at `~/.ssh/id_rsa.pub`
* Creating a "jumpbox" pod within the cluster
* Logging into the jumpbox pod and importing the provided public key (Incomplete)
* Logging into the node from the jumpbox pod (Incomplete)

## Terraform-Bump

**Usage:** `terra-bump`

When using Terragrunt for batch Terraform operations, it's necessary to provide a version tag to the Terragrunt modules so that they may be referenced in the actual resources. This script provides an automated way to ensure agreement between versions. It should be run with every change to a module to keep versions for all components in sync. It does this by going through every Terragrunt resource, incrementing the patch version by one, then tagging the modules with the incremented version number, then committing the changed modules and pushing the commit with the version tag to the repository.