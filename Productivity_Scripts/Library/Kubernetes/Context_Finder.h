#!/bin/zsh

# Kube Configs Parent Directory Path
STARTING_PATH="$HOME/.kube"

# Management Plane Pod Name Space
MP_NAME_SPACE="internal-api"

# Current Script Path
MY_PATH=`dirname ${(%):-%N}`

# Import ID Parser
. ${MY_PATH}/ID_Parser.h

# Import Format Utility
. ${MY_PATH}/../Text/Format.h

# Import Cloud Session_Manager
. ${MY_PATH}/../Cloud/Session_Manager.h

# Import Kubernetes Informer
. ${SCRIPT_PATH}/../Library/Kubernetes/Informer.h

function getKubeContext()
{
	if [ $# -lt 1 ]
	then
		fatal
		fatal "Need At Least 1 Parameter."
		fatal
	
		warn "Valid Parameters and Usage"
		warn "1. Cluster Id ( ${RED} Required ${NC} )"  >&2
		warn "2. MP/DP ( ${GREEN} Optional ${NC}, Management Plane Pod or Data Plane Pod, ${GREEN}Default is DP${NC})"  >&2
		warn
			exit 1
	fi

	CLUSTER_ID="${1}"

	# Check Whether it is a Valid Opensearch Cluster ID
	Validate ${CLUSTER_ID}
	
	POD_PLANE=$(getPodPlane ${2})
	# Extracting Namspace Prefix for Data Plane Cluster from Cluster Id
	# Management Plance has Fixed Name Space, i. e. MP_NAME_SPACE="internal-api"
	if [ ${POD_PLANE} = "DP" ]
	then
		NAME_SPACE_PREFIX=$(getNameSpacePrefix)
	else
		NAME_SPACE=${MP_NAME_SPACE}
	fi

	REALM=$(getRealm ${CLUSTER_ID})
	REGION=$(getRegion ${CLUSTER_ID})

	# Authenticate Cloud Session to Connect Cloud Clusters
	Authenticate_Session ${REALM} ${REGION}

	CONTEXT=""
	for context in `grep -lr ${REGION} ${STARTING_PATH} | grep -v cache`
	do
		#Debug "${context}"
	
		IS_EXPECTED_REALM=`grep -l ${REALM} ${context}`
	
		if [ -z "${IS_EXPECTED_REALM}" ]
		then
			continue;
		fi

		export KUBECONFIG=${context}
		if [ ${POD_PLANE} = DP ]
		then
			NAME_SPACE=$(getDataPlaneNameSpace ${NAME_SPACE_PREFIX})
			if [ ! -z "${NAME_SPACE}" ]
                	then
				CONTEXT=${context}
				break;
                	fi
		else
			MP_POD=$(getPodName ${NAME_SPACE} "internal")

			# Empty If it is not an MP Cluster
			if [ ! -z "${MP_POD}" ]
			then
				# Validation is Required as this Internal Pod May be from Different Tenancy ( DEV instead of PROD etc. )
				VALIDATION="curl -sk https://127.0.0.1:28212/internal/cluster/${CLUSTER_ID} | jq '.name'"

				DISPLAY_NAME=$(getResult ${NAME_SPACE} ${MP_POD} ${VALIDATION})
				DISPLAY_NAME=$(getUnFormattedText ${DISPLAY_NAME})

				# Returns "null", If It Doesn't Manage Given Data Plane Cluster ( In Case of Different Tenancy or Cluster doesn't Exist, Deleted etc. )
				if [ "${DISPLAY_NAME}" != "null" ]
				then
					CONTEXT=${context}
					break;	
				fi
			fi
		fi
	done

	# Return Value
	echo ${CONTEXT}
}

function getPodPlane()
{
	DP=`echo ${1} | grep -i  DP`
        if [ ! -z "${DP}" ]
        then
                # Default is Data Plane
                POD_PLANE="DP"
        else
                POD_PLANE="MP"
        fi
	# Return Value 
	echo ${POD_PLANE}
}
