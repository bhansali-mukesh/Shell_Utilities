#!/bin/zsh

ME=${(%):-%N}
export BHANSALI=`dirname ${ME}`

# Clear Screen
alias c=clear

# Get Kubenetes Result from Pods
#	Example : 
#			Karta -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -p MP
# Paramters
#       1. -c Cluster Id ( Optional ),
#               If Not Passed, Just Shows Data Plane Commands and Exits
#               If Given, Defaults to MP
#       2. -p Pod Plane ( Optional ) Either MP or DP
#
# It Helps on Commands on Showing Appropriate Command Lists
# 	a. You Can choose any Number from Given List
#	b. You Can Provide Custom Commands as well
#	c. You Can Press ENTER
# It Enquires Relevant Pod for the Given Command & Shows you Relevant Results
# In Case, You Don't Provide Anything and Just Press Enter, It will take you to Pod Terminal
alias Karta='$BHANSALI/Scripts/Karta.sh'

# Set Alias "cloud" to Point to cloud.sh instead of Directly Executing Command
# Example 
#		cloud session refresh
# Kind of Command Interceptor
# It Extract Realm and Region From Given Command
# Adds them in Command Line and Execute
# Update Kubernetes Configuration Files to Update Realm and Region, If Needed
alias cloud=$BHANSALI/Scripts/Command_Interceptor.sh

# Authenticate the Cloud Session
# Example
#		Auth
# 
# Creates Cloud Session, If Needed
# Refreshes Session to Set Later Expiry, If Session is Already Valid
# ( Cloud Session is Valid for one Hour, If not Refershed )
alias Auth='$BHANSALI/Scripts/Authenticator.sh'

# Get Kubenetes Result from Pods
# Example
# 		Connect ~/.kube/DEV_MUMBAI_DP id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka DP "ls -l; df -h; free -m"
#
# Paramters
# 	1. Kube Config File Path ( Mandatory ), Error Otherwise
#	2. Cluster Id ( Optional ), If Not Passed, Opens Terminal for MP Pod
#	3. Pod Plane ( MP or DP ) ( Optional )
#		If Not Given, If Cluster Id is Present, Set Pod Plane = DP, Otherwise MP
#		If Given Anything which Doesn't Conatin "DP" in Any Case ( Say, XYZ etc ), Default to MP
#	4. Command List ( Optional )
#		Can be Given List of Commands but in Double Quotes ("") Separate them By Semicolon
alias Connect='$BHANSALI/Scripts/Connector.sh'

# Find Kubernetes Configuration File for Given Cluster ID
# Example
#	Find id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka DP
#
# Paramters
# 	1. Cluster Id ( Mandatory ), Error Otherwise
#	2. Pod Plane ( MP or DP ) ( Optional )
#		Defaul to DP
#		If Given Anything which Doesn't Conatin "MP" in Any Case ( Say, XYZ etc ), Default to DP
alias Find='$BHANSALI/Scripts/KubeConfig_Finder.sh'

# List Available Commands to Choose from
# Example
# 		Commandor -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -r ~/Productivity_Scripts/Resources/Example.properties -p MP -s Deleting
# 
# Paramters
#       1. -c Cluster Id ( Optional )
#		Replaces Value of Variable ${CLUSTER_ID} in Selected Command
#		If Not Passed, Lists Data Plane Commands to Choose From, Otherwise management Plane
#	2. -r Resource Property File Path ( Optional )
#		Shows Commands to choose from that file instead of Default
#	3. -p Pod_Plane ( MP or DP ) ( Optional )
#               If Cluster Id is NOT Given, Set to DP
#               If Cluster Id is Given, Set to MP
#	4. -s State ( Optional )
#		State of the Cluster
#		Replaces Value of Variable ${STATE} in Selected Command
alias Commandor=$BHANSALI/Scripts/Commandor.sh

# Refreshes Cloud Session, If Session is Valid
alias Refresh='. $BHANSALI/Library/Cloud/Session_Manager.h; Refresh_Session'

# Add Profile and Auth Parameters in KubeConfig File Under $HOME/.kube Directory
# Example
#		Update_Kube realm5
# 
# Paramters
#	1. Realm ( Optional )
#		If Not Given, Defaults to realm1
alias Update_Kube='$BHANSALI/Scripts/UpdateKubeConfig.sh'

# Authenticate Before Firing kubectl Commands
# Intercepts kubectl Command
# Create A Cloud Session, If Not Created
# Refreshes Cloud Session, If Session is Already Created
alias kubectl='$BHANSALI/Scripts/Authenticator.sh; \kubectl'

# Open Myself
alias Words="vi $BHANSALI/Words.sh"

# Just type "Dharta" on Terminal
# If Dharta is Followed By Some Special Command then it will Show Help for that Command
# Else Displaying Help with Pagination ( Press Enter or Space to Scroll, "q" to Quite )
# If you Add, Update and Command in this Utility with Proper Comment, it will Automatically Be Visible in Dharta as well.
        # Example
                # 1. Dharta
                # 2. Dharta Find
alias Dharta='function JASOL() { Document=`Dharta_Document`; if [ M"$1" = "M" ]; then echo "$Document"| less; return; fi;  echo ""; echo "$Document" | sed -n "/^"$1"/,/^$/p"; }; JASOL'


# Utility Function which Parses this File and Generates The Dharta Documents to Help,
# The Command "Dharta" Generating Help Document from the Source on Runtime
alias Dharta_Document='function MB() { Comment_Character="#"; Alias_Character="alias"; Help=""; Alias=""; while read line; do if [[ $line == $Comment_Character* ]]; then Help="$Help""\n""$line"; else Alias_Found=`echo "$line"| grep $Alias_Character`; if [[ M"$Alias_Found" != "M" ]]; then Alias=`echo "$line"| cut -d"=" -f1 | tr -s " "| cut -d" " -f2`; if [[ M"$Alias" != "M" ]]; then echo -e "\n$Alias" : "$Help"; Help=""; fi; else Help=""; fi; fi; done < "$ME"; }; MB'
