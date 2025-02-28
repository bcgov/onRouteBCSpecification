Feature: Common features for profile creation workflows

User = CV Client

@orv2-481-1
Rule: A user is provided the option to claim a profile with a challenge

  Scenario: user credentials do not match an existing onRouteBC profile
     Given user has not been invited
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the following:
         | item                                                                        | description                                           |
         | Client Name                                                                 | Basic = first name last name, Business = company name |
         | Has this company purchased a commercial vehicle permit in the last 2 years? | call to action                                        |
       And they have the option to claim the profile or not
 
 Scenario: choose yes
     When they choose to claim an existing profile
     Then they are directed to claim an existing profile
     And they see the information boxes:
      | Where can I find my Client No. and Permit No.?                          |
      | Enter any Permit No. issued to the above Client No. in the last 2 years |

  Scenario: choose no
     When they choose not to claim an existing profile
     Then they are directed to  create a new onRouteBC profile

Rule: The navigation bar is not visible to CV Clients until the profile has been successfully claimed

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following steps:
       | steps |
       | welcome to onroutebc - claim profile or not choice |
       | verify profile | 
       | company information |
       | my information |
     Then the navigation bar is not visible

Rule: a new user must complete their "My Information"

  Scenario: Mandatory fields
    Given a CV Client chooses to proceed to "My Information"
     When they do not input valid data into any of the following mandatory fields:
        | field            | type         |
        | First Name       | User Details |
        | Last name        | User Details |
        | Email            | User Details |
        | Primary Phone    | User Details |
        | Country          | User Details |
        | Province / State | User Details |
        | City             | User Details |
     Then they see "This is a required field" at each field with invalid data
      And fields with invalid data are indicated

@orv2-369-9
Rule: contact details are not saved until the workflow is finished

 Scenario: CV Client Business BCeID navigates away from create new onRouteBC profile workflow
     Given they are at "Company Information" or "My Information" in the workflow
     When they navigate away from the page
     Then the onRouteBC account is not created
      And no information is saved

  Scenario: CV Client Business BCeID user added to a company profile first time sign in accept add to onRouteBC profile
      Given the CV Client Business BCeID user is at the invitation welcome page
      When they accept the invitation
      Then they are directed to the "My Information" page in the workflow
      And they are removed from the "Pending User" list of the company that added them
      And they are designated as an "Active User" 

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page

@orv2-907-2
Rule: a new invited user is assigned the role designated to their username

 Scenario: added CV Client PA username is not a member of the BCeID company
     Given the CV Client PA username is in onRoute 
       But it does not match the company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Universal Unauthorized Access" page

@orv2-907-3
Rule: a new invited user must complete their user details 

 Scenario: Complete profile
     Given they are at the "Welcome to onRouteBC" page
       And they choose to finish completing their onRouteBC profile
      When they input all required fields
        | First Name       |
        | Last Name        |
        | Email            |
        | Primary Phone    |
        | Country          |
        | Province / State |
        | City             |
     And choose to finish
    Then their user details are saved
     And they are assigned the role designated by the CV Client Admin for the CV Client onRoute Profile 
     And they are directed to a "Success" page

@orv2-907-4
Rule: a new PA user can only view company profile information

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to view their profile
      Then they are directed to company information
       But they cannot edit company information

@orv2-907-5
Rule: a new user can apply for a permit

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to apply for a permit
      Then they are directed to applications in progress