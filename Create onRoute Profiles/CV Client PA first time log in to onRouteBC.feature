Feature: added CV Client user first time log into onRoute
  As an newly added CV Client user I need to be able to log into onRouteBC for the first time and complete my onRouteBC profile so that I can begin ordering permits for the onRouteBC company I am a member of.

@orv2-907-1
Rule: username must be in onRouteBC and match company BCeID

  Scenario: username in onRouteBC and matches
     Given the username is in onRouteBC
       And they are a member of a company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the profile they are a member of
       And they see the option to finish creating their profile

  Scenario: username in onRouteBC does not match
    Given the username is in onRouteBC
      But they are not a member of a company BCeID
     When they successfully log in using their BCeID credentials
     Then they are directed to the "Universal Unauthorized Access" page

 Scenario: username is not in onRoute member of company BCeID
     Given the username is not in onRouteBC
       But they are a member a company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Universal Unauthorized Access" page

 Scenario: username is not in onRoute not a member of a company BCeID
     Given the username is not in onRouteBC
       And they are not a member of a company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Universal Unauthorized Access" page

@orv2-907-2
Rule: a username must be in onRouteBC





 Scenario: added CV Client PA username is not a member of the BCeID company
     Given the CV Client PA username is in onRoute 
       But it does not match the company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Universal Unauthorized Access" page

@orv2-907-3
Scenario: Complete profile
    Given they are at the "Welcome to onRouteBC" page
      And they choose to finish completing their onRouteBC profile
     When they input all required fields in "My Information"
       | First Name       |
       | Last Name        |
       | Email            |
       | Primary Phone    |
       | Country          |
       | Province / State |
       | City             |
    And choose to finish
   Then their "My Information" details are saved
    And they are assigned the role designated by the CV Client Admin for the CV Client onRoute Profile 
    And they are directed to a "Success" page

@orv2-907-4
Scenario: New CV Client Business BCeID user completed profile setup
    Given the CV Client Business BCeID user has completed their profile
     When they choose to view their profile
     Then they are directed to company information

@orv2-907-5
Scenario: New CV Client Business BCeID user completed profile setup
    Given the CV Client Business BCeID user has completed their profile
     When they choose to apply for a permit
     Then they are directed to applications in progress
