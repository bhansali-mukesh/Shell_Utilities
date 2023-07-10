#!/bin/zsh

# Current Script Path
MY_PATH=`dirname ${(%):-%N}`

# Import Format Utility
. ${MY_PATH}/../Text/Format.h

# Import Ordered_Map
. ${MY_PATH}/../Object/Map/ZSH/Ordered_Map.h

# Default Input Message
DEFAULT_INPUT_MESSAGE="Input Corrosponding Number or Customer Command"

# Read Property File and Get Value for the Indexed Key
function getProperty()
{
	# Calculate Source Property File
	if [ $# -eq 0 ]
	then
		echo >&2
		fatal "Parameter Needed for Property File" >&2
		info "Example : ${0} internal.properties"
			exit 1
	else
		SOURCE=${1}
		INPUT_MESSAGE=${2} # Optional
	fi

	# Create Map Object
	Ordered_Map map
	map.populate ${SOURCE}

	if [ -z "${INPUT_MESSAGE}" ] # As This is Optional Parameter
        then
                INPUT_MESSAGE=${DEFAULT_INPUT_MESSAGE}
        fi

	echo >&2
	info "${INPUT_MESSAGE}" >&2
	echo >&2

	map.keys >&2

	read REQUEST

        if [ -z "${REQUEST}" ]
        then
                # If User Input is Empty, Command is also Empty
                COMMAND=${REQUEST}
        else
		# Get Value From Property Map
		COMMAND=$(map.getByIndex ${REQUEST})

		if [ -z "${COMMAND}" ]
		then
			# If Value Not Found, Consider User Input as Custom Value
			COMMAND=${REQUEST}
		fi
	fi

	# Return Value
	echo ${COMMAND}
}
