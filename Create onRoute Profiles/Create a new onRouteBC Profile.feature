Feature: CV Client create a New onRouteBC Profile
 As a user I want to log in to onRouteBC using my BCeID credentials so that I can create my onRouteBC Profile.

User = basic or business

@orv2-369-1, @orv2-3322
Rule: a user can choose to create a new onRouteBC profile or claim an existing profile

 Scenario: business username not in onRoute and credentials do not match a company in onRouteBC
     Given the username is not in onRouteBC
       And their credentials do not match a company in onRouteBC
      When they successfully log in using their BCeID credentials
      Then they are directed to the welcome page 
       And they see their credential "Client Name"
       And they see the option to create a new profile or claim an existing profile

 Scenario: basic username not in onRoute
     Given the username is not in onRouteBC
      When they successfully log in using their BCeID credentials
      Then they are directed to the welcome page 
       And they see their credential "Client Name"
       And they see the option to create a new profile or claim an existing profile

  Scenario: user credentials do not match
     Given the users credentials do not match a company in onRouteBC
       And they have not been invited
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the following:
         | item                                                                        | description                                       |
         | BCeID Company Name                                                          | that matches their BCeID user credentials         |
         | Has this company purchased a commercial vehicle permit in the last 7 years? | call to actions to claim or not claim the profile |
       And they have the option to try to claim the profile or not claim it

@orv2-369-2, @orv2-3322
Rule: a user can update their contact details
  
    Scenario: business mandatory fields
     When they do not input data into any of the following mandatory fields:
       | contact details             |
       | First Name                  |
       | Last Name                   |
       | Email NOT EDITABLE          |
       | Primary Phone               |
       | Address (Line 1)            |
       | Country                     |
       | Province / State            |
       | City                        |
       | Postal / Zip Code           |
     Then they see "This is a required field" at each field with invalid data
      And fields with no data are indicated
      
  Scenario: basic mandatory fields
    Given a user chooses to finish creating their onRouteBC profile
     When they do not input valid data into any of the following mandatory fields:
       | field                      |
       | First Name                 |
       | Last name                  |
       | Email                      |
       | Primary Phone              |
       | Ext                        |
       | Alternate Phone (optional) |
       | Ext                        |
       | Country                    |
       | Province / State           |
       | City                       |
     Then they see "This is a required field" at each field with invalid data
      And fields with no valid data are indicated

@orv2-369-13, @orv2-3322
Rule: BCeID manages credential and system issues separate of onRouteBC

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page


