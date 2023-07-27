#!/bin/zsh

# Find Kubernetes Configuration File for Given Cluster ID
# Example
#       ./KubeConfig_Finder.sh id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka
#
# Paramters
#       1. Cluster Id ( Mandatory ), Error Otherwise
#       2. Pod Plane ( MP or DP ) ( Optional )
#               Defaul to DP
#               If Given Anything which Doesn't Conatin "MP" in Any Case ( Say, XYZ etc ), Default to DP

# Management Plane Pod Name Space
MP_NAME_SPACE="internal-api"

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Context Finder
. ${SCRIPT_PATH}/../Library/Kubernetes/Context_Finder.h

#CLUSTER_ID=id.cluster.realm1.bh-pune-1.gjr4gegelomkfefrgn3439vnfkvfdreghhtjw

CLUSTER_ID=${1}
POD_PLANE=${2}

if [ -z `echo ${POD_PLANE} | grep -i mp` ]
then
	POD_PLANE=DP
fi

echo
info "CLUSTER_ID = ${CLUSTER_ID}"
info "POD_PLANE = ${POD_PLANE}"
echo

KUBE=$(getKubeContext ${CLUSTER_ID} ${POD_PLANE})

if [ -z "$KUBE" ]
then
	echo
	fatal "Kube Config Not Found."
	echo
		exit 1
fi

echo
info "KUBECONFIG = ${KUBE}"
echo
