#!/bin/zsh

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Default Source Property File
COMMAND_SOURCE=${SCRIPT_PATH}/Hamari.properties

# User Message for Input
INPUT_MESSAGE="Enter Number for get Corresponding Command Or Enter Customized Command Or Press ENTER to Get into Terminal"

# Import Format Utilities
. ${SCRIPT_PATH}/../Utils/Text/Format.h

# Import Property Reader Utilities
. ${SCRIPT_PATH}/../Utils/File/Property_Reader.h

# Import Text Subtitutoe
. ${SCRIPT_PATH}/../Utils/Text/Substitutor.h

# Evertything is Optional here :)
export CLUSTER_ID=${1}
export STATE=${2}

# Get Attributed Parameter
while getopts p: option 
do 
 case "${option}" 
 in 
 p) COMMAND_SOURCE=${OPTARG};; 
 esac 
done

COMMAND=$(getProperty ${COMMAND_SOURCE} ${INPUT_MESSAGE})
COMMAND_VALUE=$(Substitute_Variables ${COMMAND})

echo "${COMMAND_VALUE}"

# Waits for User Confirmation
# User_Confirmation

