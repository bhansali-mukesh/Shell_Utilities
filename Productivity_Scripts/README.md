
Pre-Requisite :
Put Below 2 Lines in Your "$HOME/.zprofile" file

# Productivity Aliases
. ~/Productivity_Scripts/Words.sh 


Usage :
This Package Provides Shell Utilities for Many Purpose.
We tried to Make them Generic and Moduler.
Here are few of them

1. Environment Related Utilities ( Non Empty Environment Variable etc. )
2. Object Utilities ( Map, Ordered Map etc. )
3. File Utilities ( Creating Map From Properties Files etc. )
4. User Input ( Waits for user Inputs )
5. Kubernetes Helper 
	a. Find Right Context from Multiple Kubernetes Objects for your Resource
	b. Get Resource Details from Kubernetes and Responds to you
	c. Parses Your Resources into Multiple Part and Provide Meaning
	d. Update Your Context with Needed Details like Authentication etc.
6. Create/Refresh Authentication as and when Needed Automatically
7. Intercept Command for Pre-Processing and Fire with Added things
8. Format, UnFormat, Color and re-Direct Text Based on Requirement
9. Provide Automatic or vone Word Access to All Major functionality
10. Dynamic Documentation, Parses Comment and Generate Documentation

Map, Ordeed Map, Property Reader, Kubernetes Informer, text Formatter, Substitutor etc with Example

# c : 
/* Clear Screen */

Karta : 
/* Get Kubenetes Result from Pods
	Example :
			Karta -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -p MP
 Paramters
       1. -c Cluster Id ( Optional ),
               If Not Passed, Just Shows Data Plane Commands and Exits
               If Given, Defaults to MP
       2. -p Pod Plane ( Optional ) Either MP or DP

 It Helps on Commands on Showing Appropriate Command Lists
 	a. You Can choose any Number from Given List
	b. You Can Provide Custom Commands as well
	c. You Can Press ENTER
 It Enquires Relevant Pod for the Given Command & Shows you Relevant Results
 In Case, You Don't Provide Anything and Just Press Enter, It will take you to Pod Terminal */

cloud : 
/* Set Alias "cloud" to Point to cloud.sh instead of Directly Executing Command
 Example
		cloud session refresh
 Kind of Command Interceptor
 It Extract Realm and Region From Given Command
 Adds them in Command Line and Execute
 Update Kubernetes Configuration Files to Update Realm and Region, If Needed */

Auth : 
/* Authenticate the Cloud Session
 Example
		Auth

 Creates Cloud Session, If Needed
 Refreshes Session to Set Later Expiry, If Session is Already Valid
 ( Cloud Session is Valid for one Hour, If not Refershed ) */

Connect : 
/* Get Kubenetes Result from Pods
 Example
 		Connect ~/.kube/DEV_MUMBAI_DP id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka DP "ls -l; df -h; free -m"

 Paramters
 	1. Kube Config File Path ( Mandatory ), Error Otherwise
	2. Cluster Id ( Optional ), If Not Passed, Opens Terminal for MP Pod
	3. Pod Plane ( MP or DP ) ( Optional )
		If Not Given, If Cluster Id is Present, Set Pod Plane = DP, Otherwise MP
		If Given Anything which Doesn't Conatin "DP" in Any Case ( Say, XYZ etc ), Default to MP
	4. Command List ( Optional )
		Can be Given List of Commands but in Double Quotes ("") Separate them By Semicolon */

Find : 
/* Find Kubernetes Configuration File for Given Cluster ID
 Example
	Find id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka DP

 Paramters
 	1. Cluster Id ( Mandatory ), Error Otherwise
	2. Pod Plane ( MP or DP ) ( Optional )
		Defaul to DP
		If Given Anything which Doesn't Conatin "MP" in Any Case ( Say, XYZ etc ), Default to DP */

Commandor : 
 List Available Commands to Choose from
 Example
 		Commandor -c id.cluster.realm1.uj-samarkand-6.mkfefrgpgkpensdnjfkn3439vnfkvfdoka -r ~/Productivity_Scripts/Resources/Example.properties -p MP -s Deleting

 Paramters
       1. -c Cluster Id ( Optional )
		Replaces Value of Variable ${CLUSTER_ID} in Selected Command
		If Not Passed, Lists Data Plane Commands to Choose From, Otherwise management Plane
	2. -r Resource Property File Path ( Optional )
		Shows Commands to choose from that file instead of Default
	3. -p Pod_Plane ( MP or DP ) ( Optional )
               If Cluster Id is NOT Given, Set to DP
               If Cluster Id is Given, Set to MP
	4. -s State ( Optional )
		State of the Cluster
		Replaces Value of Variable ${STATE} in Selected Command */

Refresh : 
/* Refreshes Cloud Session, If Session is Valid */

Update_Kube : 
/* Add Profile and Auth Parameters in KubeConfig File Under $HOME/.kube Directory
 Example
		Update_Kube realm5

 Paramters
	1. Realm ( Optional )
		If Not Given, Defaults to realm1 */

kubectl : 
/* Authenticate Before Firing kubectl Commands
 Intercepts kubectl Command
 Create A Cloud Session, If Not Created
 Refreshes Cloud Session, If Session is Already Created */

Words : 
/* Open Myself */

Dharta : 
 Just type "Dharta" on Terminal
 If Dharta is Followed By Some Special Command then it will Show Help for that Command
 Else Displaying Help with Pagination ( Press Enter or Space to Scroll, "q" to Quite )
 If you Add, Update and Command in this Utility with Proper Comment, it will Automatically Be Visible in Dharta as well.
 Example
 1. Dharta
 2. Dharta Find */

Dharta_Document : 
/* Utility Function which Parses this File and Generates The Dharta Documents to Help,
 The Command "Dharta" Generating Help Document from the Source on Runtime */
