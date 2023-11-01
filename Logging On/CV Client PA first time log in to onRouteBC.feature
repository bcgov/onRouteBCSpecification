Feature: CV Client PA log into onRoute
  As a CV Client PA I need to be able to log into onRouteBC and complete "My Information" so that I can begin ordering permits.

@orv2-907-1
Scenario: CV Client PA first time log into onRouteBC
    Given they have valid BCeID credentials
      And they have been added to onRouteBC by a CV Client Admin
    When they successfully log in using their BCeID credentials
    Then they are directed to the "Welcome to onRouteBC" page 
     And they see the company name for the profile they have been added to
     And they see the option to finish creating their onRouteBC profile

@orv2-907-2
Scenario: New user first time log into onRouteBC username does not match that entered by CV Client admin
    Given the CV Client Admin added them to onRouteBC using an incorrect username
     When they successfully log in using their BCeID credentials
     Then they are directed to the "Universal Unauthorized Access" page

@orv2-907-3
Scenario: New user first time log into onRouteBC complete profile
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
