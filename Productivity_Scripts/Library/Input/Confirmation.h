#!/bin/zsh

function User_Confirmation()
{
	if [ $# -ne 0 ]
	then
		MESSAGE=${1}
	else
		MESSAGE="\nPress Anything to Continue.\n"
	fi
	
	echo -e "${MESSAGE}"
	
	read CONFIRMATION
}
