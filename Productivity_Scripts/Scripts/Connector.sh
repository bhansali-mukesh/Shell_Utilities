#!/bin/zsh

# Get Kubenetes Result from Pods
# Example
#               ./Connector.sh ~/.kube/DEV_MUMBAI_DP id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka DP "ls -l; df -h; free -m"
#
# Paramters
#       1. Kube Config File Path ( Mandatory ), Error Otherwise
#       2. Cluster Id ( Optional ), If Not Passed, Opens Terminal for MP Pod
#       3. Pod Plane ( MP or DP ) ( Optional )
#               If Not Given, If Cluster Id is Present, Set Pod Plane = DP, Otherwise MP
#               If Given Anything which Doesn't Conatin "DP" in Any Case ( Say, XYZ etc ), Default to MP
#       4. Command List ( Optional )
#               Can be Given List of Commands but in Double Quotes ("") Separate them By Semicolon

# Management Plane Pod Name Space
MP_NAME_SPACE="internal-api"

# Container Name
MP_CONTAINER_NAME="internal-api"
DP_CONTAINER_NAME="opensearch"

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Text Format Utility
. ${SCRIPT_PATH}/../Library/Text/Format.h

# Import Kubernetes Informer
. ${SCRIPT_PATH}/../Library/Kubernetes/Informer.h

# Import ID Parser
. ${SCRIPT_PATH}/../Library/Kubernetes/ID_Parser.h

function getPodPlaneIfValidParameters()
{
        KUBE=$1
        CLUSTER_ID=$2
        POD_PLANE=$3
	
	if [[ ! -f "$KUBE" ]]
        then
                fatal "Kubenetes Configuration File not Found : ${KUBE}"
                        exit 1
        fi

        if [ ! -z "${CLUSTER_ID}" ]
        then
                # If Cluster Id is NOT EMPTY, Validate it.
                Validate ${CLUSTER_ID}
        fi

	if [ -z "${POD_PLANE}" ] 
        then
	        	
		if [ -z "${CLUSTER_ID}" ]
	 	then
			# If Pod Plane is EMPTY and Cluster Id is also EMPTY
			POD_PLANE=MP
		else
			# If Pod Plane is EMPTY but Cluster Id is also NOT EMPTY
			POD_PLANE=DP
		fi
	elif [ -z `echo ${POD_PLANE} | grep -i DP` ]
	then
		# If Pod Plane is NOT EMPTY and Pod Plane is NOT Containing DP in Any Case
		POD_PLANE=MP
	else
		# If Pod Plane is NOT EMPTY and Pod Plane is Containing DP in Any Case
		POD_PLANE=DP
	fi

	if [ "${POD_PLANE}" = DP ] && if [ -z "${CLUSTER_ID}" ]
	then
		# If Pod Plane is DP and Cluster Id is EMPTY, Can not Connect
                Debug "KUBE = $KUBE"
        	Debug "CLUSTER_ID = $CLUSTER_ID"
        	Debug "POD_PLANE = $POD_PLANE"
		
		Debug ""
		fatal "Need Cluster ID to Connect to Data Plane"
                	exit 1
	fi
        
	# Return Pod Plane
        echo ${POD_PLANE}
}

function IsConnectable()
{
	if [ $# -lt 3 ]
	then
		Debug "NAME_SPACE = ${1}"
		Debug "POD NAME = ${2}"
		Debug "COMMAND_OR_CONTAINER_NAME = ${3}"

		fatal "Not Able to Connect"
		warn "Check Name Space, Pod Name and Command Or Container Name Again"
			exit 1
	fi

	echo "YES"
}

KUBE=${1}
CLUSTER_ID=${2}
POD_PLANE=${3}
COMMAND="${@:4}"

POD_PLANE=$(getPodPlaneIfValidParameters $KUBE ${CLUSTER_ID} $POD_PLANE)
#Debug "POD_PLANE = $POD_PLANE"

if [ -z "${POD_PLANE}" ]
then
	fatal "Pod Plane Can not be Determined"
		exit 1
fi

#Debug "POD_PLANE = ${POD_PLANE}"

${SCRIPT_PATH}/Authenticator.sh

export KUBECONFIG=${KUBE}
if [ "${POD_PLANE}" = DP ]
then 
	NAME_SPACE_PREFIX=$(getNameSpacePrefix ${CLUSTER_ID})
	
	NAME_SPACE=$(getDataPlaneNameSpace ${NAME_SPACE_PREFIX})

	POD_NAME=$(getPodName ${NAME_SPACE} "master-0")

	CONTAINER_NAME=${DP_CONTAINER_NAME}
else
	NAME_SPACE=${MP_NAME_SPACE}

	POD_NAME=$(getPodName ${NAME_SPACE} "internal")

	CONTAINER_NAME=${MP_CONTAINER_NAME}
fi

Debug "NAME_SPACE = ${NAME_SPACE}"
Debug "POD_NAME = ${POD_NAME}"
Debug "COMMAND = ${COMMAND}"
Debug "CONTAINER_NAME = ${CONTAINER_NAME}"

IsConnectable=$(IsConnectable ${NAME_SPACE} ${POD_NAME} ${COMMAND} ${CONTAINER_NAME})
if [ -z "$IsConnectable" ]
then
	fatal "Can not Connect"
	fatal "Please Check Details Again"
		exit 1
fi

if [ ! -z "${COMMAND}" ]
then
	RESULT=$(getResult ${NAME_SPACE} ${POD_NAME} ${COMMAND})

	echo "${RESULT}"
else
	Debug "Opening Shell Terminal ..."
	getTerminal ${NAME_SPACE} ${POD_NAME} ${CONTAINER_NAME}
fi
