Feature: CV Client claim an existing onRouteBC Profile
As a CV Client Business BCeID user I want to claim my profile information so that I can see all of my current permit data.

@orv2-481-1
Rule: A CV Client is provided the option to claim a profile

 Scenario: Choose yes
     Given the CV Client is at the "Welcome to onRouteBC" page
     When they choose to claim an existing profile
     Then they are directed to the "Claim an existing profile" page "Verify Profile" in the workflow
     And they see the workflow active step indication "Verify Profile"
     And they see the information boxes:
      | "Where can I find my Client No. and Permit No.?"|
      | "Enter any Permit No. issued to the above Client No. in the last 7 years" |

@orv2-481-6
Rule: A CV Client can cancel or step backwards in the "Claim an existing profile" workflow

  Scenario: Cancel
    Given they have chosen to claim a TPS profile
     When they choose to cancel
     Then they are directed to the "Welcome to onRouteBC" page

  Scenario: Previous
    Given they have chosen to claim a TPS profile
     When they choose to return to a previous page
     Then they are directed to the previous page in the workflow
      And they workflow step indication reflects the page they are on

@orv2-481-2
Rule: If a "Client No." is associated to a "Permit No." then allow a CV Client to proceed to the next step in the workflow "Company Information"

 Scenario: Valid TPS "Client No." and "Permit No."
     Given they input a "Client No." that is in onRouteBC
       And they input a "Permit No." that is associated to the "Client No." 
      When they choose to proceed
      Then they are directed to next step in the workflow "Company Information"
       And they see "Verify Profile" completed success indication

 Scenario: Invalid TPS "Client No."
     Given they input a "Client No." that is not in onRouteBC
      When they choose to proceed
      Then they see "Client No. not found"
       And "Client No." is indicated
       And they cannot proceed to the next step in the workflow

 # This can be reversed valid permit no. invalid client no. the behaviour is the same
 Scenario: Valid TPS "Client No." invalid "Permit No."
     Given they input a "Client No." that is in onRouteBC
       And they input a "Permit No." that is not associated to the "Client No."
      When they choose to proceed
      Then they see "Permit No. does not match Client No."
       And "Permit No." is indicated
       And they cannot proceed to the next step in the workflow      

@orv2-481-3
Rule: Both "Permit No." and "Client No." are mandatory fields

 Scenario: Only a "Permit No." inputted
    Given they input a "Permit No." that is in onRouteBC
      And they have not inputted a "Client No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Client No." is indicated
      And they cannot proceed to the next step in the workflow     

 Scenario: Only a "Client No." inputted
    Given they input a "Client No." that is in onRouteBC
      And they have not inputted a "Permit No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Permit No." is indicated
      And they cannot proceed to the next step in the workflow

 Scenario: "Client No." and "Permit No." not inputted
     Given they do not input a "Client No."
       And they do not input a "Permit No."
      When they attempt to proceed in the workflow
      Then they see "This is a required field"
       And "Permit No." is indicated 
       And "Client No." is indicated

@orv2-481-4
Rule: A CV Client can view and update their claimed TPS "Client No." profile information

  Scenario: 
    Given 
     When 
     Then 

@orv2-481-5
Rule: A CV Clients BCeID information replaces the "Company Name" and "Company Email" information in onRouteBC

  Scenario: 
    Given 
     When 
     Then 



@orv2-481-6
Rule: A CV Client can update their "My Information"

@orv2-481-7
Rule: A CV Client can view their assigned onRouteBC Client Number and 

@orv2-481-8


@orv2-481-9


@orv2-481-10
