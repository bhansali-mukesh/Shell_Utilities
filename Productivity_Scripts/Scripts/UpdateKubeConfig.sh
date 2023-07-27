#!/bin/zsh

# Add Profile and Auth Parameters in KubeConfig File Under $HOME/.kube Directory
# Example
#               ./UpdateKubeConfig.sh realm5
# 
# Paramters
#       1. Realm ( Optional )
#               If Not Given, Defaults to realm1
#       2. Region ( Optional )
#               If Not Given, Defaults to us-ashburn-1

# Current Script Path
SCRIPT_PATH=`dirname ${0}`

# Import Update Utility for Kubernetes Files
. ${SCRIPT_PATH}/../Library/Kubernetes/UpdateKubeConfig.h

if [ $# -gt 0 ]
then
	Realm=$1
else
	Realm=realm1
fi

UpdateKubeConfig $Realm
