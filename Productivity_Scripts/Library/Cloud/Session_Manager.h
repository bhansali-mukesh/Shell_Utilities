#!/bin/zsh

# Authenticate the Cloud Session
# Example
#               Auth
#
# Creates Cloud Session, If Needed
# Refreshes Session to Set Later Expiry, If Session is Already Valid
# ( Cloud Session is Valid for one Hour, If not Refershed )

function Authenticate_Session()
{
	if [ $# -lt 2 ]
	then
		# Default Values
		Realm=realm1
		Region=bh-pune-1
	else
		Realm=${1}
		Region=${2}
	fi

	# Validate Authentication Session But Don't Create one here
	printf "%s\n" "n" | cloud session validate --profile=${Realm}

	if [ $? -ne 0 ]
	then
		# Authenticate Session for realm1 ( Or Whichever Realm You Want to Authenticate with, You can change below printf inputs accordingly )
		# printf "%s\n" "${Region}" "${Realm}" | cloud session authenticate --profile ${Realm} --auth token

		# This way is Better as Many Regions are not Available in Pop-up
		cloud session authenticate --config-location $HOME/.cloud/config_generated --profile-name ${Realm} --region ${Region} --profile ${Realm} --auth token
	else
		cloud session refresh --profile ${Realm} --profile realm1 --auth token
	fi
}

function Refresh_Session()
{
	if [ $# -lt 1 ]
        then
                # Default Values
                Realm=realm1
        else
                Realm=${1}
        fi

	cloud session refresh --profile ${Realm} --auth token
}
