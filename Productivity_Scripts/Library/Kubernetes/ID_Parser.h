#!/bin/zsh

# Current Script Path
MY_PATH=`dirname ${(%):-%N}`

# Import Format Utility
. ${MY_PATH}/../Text/Format.h

OPENSEARCH="opensearch"

function Validate()
{
	if [ -z `echo "${1}" | grep ${OPENSEARCH}` ]
        then
                fatal "Parameter is Either EMPTY or NOT a Valid Opensearch Cluster Id"
		fatal "Need Cluster ID as Parameter"
                        exit 1
        fi
}

function getRealm()
{
	echo `echo ${1} | cut -d. -f3`
}

function getRegion()
{
	echo `echo ${1} | cut -d. -f4`
}

function getNameSpacePrefix()
{
	echo `echo ${CLUSTER_ID} | rev | cut -d'.' -f1 | rev`
}
