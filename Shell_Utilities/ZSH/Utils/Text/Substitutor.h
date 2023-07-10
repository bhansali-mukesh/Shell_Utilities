#!/bin/zsh

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Format Utility
. ${SCRIPT_PATH}/Format.h

# Import Format Utility
. ${SCRIPT_PATH}/../Environment.h

function Substitute_Variables()
{
	# Replace Variables with Values, If Value Present and Return
	echo ${1} | envsubst "$(GetAllNonEmptyExportedVariables)"
}
