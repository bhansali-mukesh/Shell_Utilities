#!/bin/zsh

# Set Alias for Command "cloud" to Point to cloud.sh instead of Directly Executing Command
#
# Kind of Command Interceptor
# It Extract Realm and Region From Given Command
# Adds them in Command Line and Execute
# Update Kubernetes Configuration Files to Update Realm and Region, If Needed

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Context Finder
. ${SCRIPT_PATH}/../Library/Cloud/Command_Interceptor.h

Intercept $*
