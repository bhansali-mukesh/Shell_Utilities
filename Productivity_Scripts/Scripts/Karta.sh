#!/bin/zsh

# Get Kubenetes Result from Pods
#       Example :
#                       ./Karta.sh -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -p MP
# Paramters
#       1. -c Cluster Id ( Optional ),
#               If Not Passed, Just Shows Data Plane Commands and Exits
#               If Given, Defaults to MP
#	2. -p Pod Plane ( Optional ) Either MP or DP         
#
# It Helps on Commands on Showing Appropriate Command Lists
#       a. You Can Choose any Number from Given List
#       b. You Can Provide Custom Commands as well
#       c. You Can Press ENTER
# It Enquires Relevant Pod for the Given Command & Shows you Relevant Results
# In Case, You Don't Provide Anything and Just Press Enter, It will take you to Pod Terminal

# Management Plane Pod Name Space
MP_NAME_SPACE="internal-api"

# Container Name
CONTAINER_NAME="opensearch"

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Context Finder
. ${SCRIPT_PATH}/../Library/Kubernetes/Context_Finder.h

# Import Text Format Utility
. ${SCRIPT_PATH}/../Library/Text/Format.h

# Import ID Parser Utility
. ${SCRIPT_PATH}/../Library/Kubernetes/ID_Parser.h

# Import Kubernetes Informer
. ${SCRIPT_PATH}/../Library/Kubernetes/Informer.h

# Get Attributed Parameter
while getopts c:p: option 
do 
 case "${option}" 
 in
 c) export CLUSTER_ID=${OPTARG};;
 p) POD_PLANE=${OPTARG};;
 esac 
done

echo
info "CLUSTER_ID = ${CLUSTER_ID}"

Debug "POD = ${POD_PLANE}"
POD_PLANE=$(getPodPlane ${POD_PLANE})
Debug "POD = ${POD_PLANE}"

COMMAND=`${SCRIPT_PATH}/Commandor.sh $*`
echo
info "COMMAND = ${COMMAND}"

KUBE=$(getKubeContext ${CLUSTER_ID} ${POD_PLANE})
Debug "KUBECONFIG = ${KUBE}"

if [[ ! -f "$KUBE" ]]
then
	echo
        fatal "Kubebernetes Configuration File Not Found for Cluster : ${CLUSTER_ID}"
	echo
                exit 1
fi

echo
Debug "Running ${SCRIPT_PATH}/Connector.sh ${KUBE} ${CLUSTER_ID} ${POD_PLANE} ${COMMAND}"

RESULT=`${SCRIPT_PATH}/Connector.sh ${KUBE} ${CLUSTER_ID} ${POD_PLANE} ${COMMAND}`

echo	
warn "Command Result : "
echo
info "${RESULT}"
