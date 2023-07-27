#!/bin/zsh

# Set Alias "cloud" to Point to cloud.sh instead of Directly Executing Command
# Example
#               cloud session refresh
# Kind of Command Interceptor
# It Extract Realm and Region From Given Command
# Adds them in Command Line and Execute
# Update Kubernetes Configuration Files to Update Realm and Region, If Needed

# Current Script Path
MY_PATH=`dirname ${(%):-%N}`

# Import Cloud Session_Manager
. ${MY_PATH}/Session_Manager.h

# Import Update Utility for Kubernetes Configuration Files
. ${MY_PATH}/../Kubernetes/UpdateKubeConfig.h

# THINGS IT DO
# 1. Add "profile" & "auth" Parameters Before Running Command, If Needed
# 2. Edit Generated KubeConfig to Add "profile" & "auth" Parameters


function Intercept()
{
	# Run with More Parameters Like
        # profile
        # --auth
        
	# This Logic is Anyway Needed for Getting Region and Realm for Authentication
	for parameter in $(echo $* | tr " " "\n")
        do
        	Realm=`echo $parameter | grep -Eo "realm[0-9]+"`
        	if [ ! -z "$Realm" ]
                then
                	Region=`echo $parameter | cut -d. -f4`
                        break;
                fi
        done
	
	# Authenticate Cloud Session to Connect Cloud Clusters
        Authenticate_Session ${Realm} ${Region}
	
	# If Profile is Empty, Add profile & auth Parameters
	if [[ -z "${PROFILE}" ]]
	then
		\cloud ${*} --profile $Realm --auth token;
	else
		# No Need to Add Anything, Just Run Command as Same as Provided
		\cloud ${*}
	fi

	# Adding Parameters in Generated KubeConfig for
	# --profile
        # --auth
	UpdateKubeConfig $Realm
}
