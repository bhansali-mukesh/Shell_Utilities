#!/bin/zsh

# Authenticate the Cloud Session
# Example
#               ./Authenticator.sh
#
# Creates Cloud Session, If Needed
# Refreshes Session to Set Later Expiry, If Session is Already Valid
# ( Cloud Session is Valid for one Hour, If not Refershed )

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Property Reader Utilities
. ${SCRIPT_PATH}/../Library/File/Property_Reader.h

# Import Context Finder
. ${SCRIPT_PATH}/../Library/Cloud/Session_Manager.h

# Region Source for Realm
REALM_REGION=${SCRIPT_PATH}/../Resources/Realm_Region.properties

Realm=$1
Region=$2

if [ -z "${Realm}" ]
then
	Realm=realm1
fi

if [ -z "${Region}" ]
then
        Region=$(getPropertyValue ${REALM_REGION} ${Realm})
	if [ -z "${Region}" ]
	then
		fatal "Region is Empty"
		warn "Neither Provided Nor Found in ${REALM_REGION}"
			exit 1
	fi
fi

Authenticate_Session ${Realm} ${Region}
