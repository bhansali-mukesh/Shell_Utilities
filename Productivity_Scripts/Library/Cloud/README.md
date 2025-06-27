
# 1. Set-up

To Set-up this tool, Please fire below commands.

**Note** : Replace __<Repository_Directory>__ with Actual Directory where you want to place this Repository 

        cd <Repository_Directory>;
        git clone ssh://oci.private.devops.scmservice.us-phoenix-1.oci.oracleiaas.com/namespaces/axuxirvibvvo/projects/OMO/repositories/him-automation-tools;
        echo >> ~/.zprofile;
        echo ". $(pwd)/him-automation-tools/Commandor/COMMANDER.sh" >> ~/.zprofile;
__________________________________________________________________________________________________________

# 2. Commands

## Auth : 
Useful while Running in Scripts as Refreshing Session is time Consuming.

Only 6 Refresh is Allowed Per Session, If we Refresh Often, Session will go Invalid

Authenticate Session, If Needed.

Or Refresh the Session, If Needed ( Refresh Extends the Session which is 1 hour from Refresh ).

Or Do Nothing, If Session is Fine and not about to Expire.

Refreshes Session to Set Later Expiry, If Session is Already Valid

Example

               1. Auth
               2. Auth oc16
____________________________________________________________________________________________

## UnAuth : 
Useful while Testing Thing Without Session Where Session's Expiry is Not Near.

It not Just Terminate the Session but clear out things, Related to that


Terminates the Cloud Session

Example

               1. UnAuth
               2. UnAuth oc14
____________________________________________________________________________________________

## ReAuth : 
Useful while Testing Things with the Process of Session Creation.

Re-Authenticate does the Following things

1. Terminates the Existing Session

2. Authenticate Again


Re-Creates Cloud Session

Example

               1. ReAuth
               2. ReAuth oc21
____________________________________________________________________________________________

## AUTH : 
Useful When Your Profile or Other Information in ~/.oci is Corrupted


Refresh the Session, If Session is Valid

Start Session from Scratch for Particular Realm


Creates or Refresh Cloud Session


Example

               1. AUTH
               2. AUTH oc10
____________________________________________________________________________________________

## Refresh : 
Useful When You want to a have a Active Session for a long like when you are On Call, Doing Patching etc.


Keep the Session Active

Refreshes Cloud Session Continuously, If Session is Valid

Example

               1. Refresh
               2. Refresh &
____________________________________________________________________________________________

## A : 
As same as AUTH But Need to Type Less.

Example

               1. A
               2. A oc14
____________________________________________________________________________________________

## R : 
As same as Refresh But Need to Type Less

Example

               1. R
               2. R oc16
____________________________________________________________________________________________

## Session : 
Just type "Session" on Terminal


If "Session" is not followed by any Particular Command/Command-Pattern Displays Help with Pagination for Everything ( Press Enter or Space to Scroll, "q" to Quite )

If "Session" is Followed By Any Command/Command-Pattern then it will Show Help for that/those Command/Command-Pattern, on Match

If you Add or Update any Command in this Utility with Proper Comments, it will Automatically Be Visible in "Session" help as well.

Example

                       1. Session
                       2. Session Auth
                       3. Session A
                       4. Session Session