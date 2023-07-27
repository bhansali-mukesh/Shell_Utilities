#!/bin/zsh

# List Available Commands to Choose from
# Example
#               ./Commandor -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -r ~/Productivity_Scripts/Resources/Example.properties -p MP -s Deleting
# 
# Paramters
#       1. -c Cluster Id ( Optional )
#               Replaces Value of Variable ${CLUSTER_ID} in Selected Command
#               If Not Passed, Lists Data Plane Commands to Choose From, Otherwise management Plane
#       2. -r Resource Property File Path ( Optional ) 
#               Shows Commands to choose from that file instead of Default
#       3. -p Pod_Plane ( MP or DP ) ( Optional )
#               If Cluster Id is NOT Given, Set to DP
#               If Cluster Id is Given, Set to MP
#       4. -s State ( Optional )
#               State of the Cluster
#               Replaces Value of Variable ${STATE} in Selected Command

# Usage
# Paramters
#       1. Cluster Id ( Optional )
#		Replaces Value in Selected Command
#		If Not Passed, Lists Data Plane Commands to Choose From
#		If Given, Lists Management Plane Commands to Choose From
#       2. Pod Plane ( MP or DP ) ( Optional )
#		Shows Command List Accordingly
#               If Not Given, If Cluster Id is Present, Set Pod Plane = MP, Otherwise DP
#               If Given Anything which Doesn't Conatin "MP" in Any Case ( Say, XYZ etc ), Default to DP
#       3. Resource Property File Path ( Optional )
#               Shows Command List from that Property File
#	4. State ( Optional ) Replace Value in Selected Command

# Current Script Path
SCRIPT_PATH=`dirname ${(%):-%N}`

# Default MP Source Property File
MP_COMMAND_SOURCE=${SCRIPT_PATH}/../Resources/Internal.properties

# Default DP Command Source
DP_COMMAND_SOURCE=${SCRIPT_PATH}/../Resources/OpenSearch_API.properties

# User Message for Input
INPUT_MESSAGE="Enter Number for get Corresponding Command Or Enter Customized Command Or Press ENTER to Get into Terminal"

# Import Format Utilities
. ${SCRIPT_PATH}/../Library/Text/Format.h

# Import Property Reader Utilities
. ${SCRIPT_PATH}/../Library/File/Property_Reader.h

# Import Text Subtitutoe
. ${SCRIPT_PATH}/../Library/Text/Substitutor.h

# Evertything is Optional here :)

# Get Attributed Parameter
while getopts c:p:r:s: option 
do 
 case "${option}" 
 in
 c) export CLUSTER_ID=${OPTARG};;
 p) POD_PLANE=${OPTARG};;
 r) COMMAND_SOURCE=${OPTARG};;
 s) export STATE=${OPTARG};;
 esac 
done

#Debug "CLUSTER_ID ${CLUSTER_ID}"
#Debug "STATE ${STATE}"
#Debug "POD PLANE ${POD_PLANE}"
#Debug "COMMAND_SOURCE ${COMMAND_SOURCE}"

if [ -z "${COMMAND_SOURCE}" ]
then
	# If Pod Plane is Empty
        if [ -z "${POD_PLANE}" ]
	then
		if [ -z "${CLUSTER_ID}" ]
		then
			COMMAND_SOURCE=${DP_COMMAND_SOURCE}
		else
			COMMAND_SOURCE=${MP_COMMAND_SOURCE}
		fi
	# If Anything Containing mP in Any Case is Provided as Parameter
	elif [ ! -z `echo ${POD_PLANE} | grep -i MP` ]
	then
		COMMAND_SOURCE=${MP_COMMAND_SOURCE}
	else
		COMMAND_SOURCE=${DP_COMMAND_SOURCE}
	fi	
fi

#Debug COMMAND_SOURCE ${COMMAND_SOURCE}

COMMAND=$(getProperty ${COMMAND_SOURCE} ${INPUT_MESSAGE})
COMMAND_VALUE=$(Substitute_Variables ${COMMAND})

echo "${COMMAND_VALUE}"

# Waits for User Confirmation
# User_Confirmation
