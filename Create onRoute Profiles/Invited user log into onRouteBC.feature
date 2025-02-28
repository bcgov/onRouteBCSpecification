Feature: Invited user log into onRouteBC
  As an newly added CV Client user I need to be able to log into onRouteBC for the first time and complete my onRouteBC profile so that I can begin ordering permits for the onRouteBC company I am a member of.

@orv2-907-1, @orv2-3322
Rule: credential username must match invited username in onRouteBC

  Scenario: username in onRouteBC and matches 
     Given the credential username matches invited username in onRouteBC
      When they successfully log in using their BCeID credentials
      Then they are directed to the welcome page
       And they see the client name for the profile they are invited to
       And they see the option to finish creating their profile

  Scenario: basic username does not match one in onRouteBC
    Given the credential username is not in onRouteBC
      And their credential does not match an existing user in onRouteBC
     When they successfully log in using their BCeID credentials
     Then they are directed to the welcome to onRouteBC page 

 Scenario: business username not in onRouteBC, credentials match a company in onRouteBC
     Given the username is not in onRouteBC
       And they are not the first user
       But their credentials match a company in onRouteBC
      When they successfully log in using their BCeID credentials
      Then they are directed to the universal unauthorized access page

 Scenario: business username not in onRoute, credentials do not match a company in onRouteBC
     Given the username is not in onRouteBC
       And their credentials do not match a company in onRouteBC
      When they successfully log in using their BCeID credentials
      Then they are directed to the welcome to onRouteBC page 
       And they see their credential client name
       And they see the option to create a new profile or claim an existing profile

@orv2-907-2, @orv2-3322
Rule: a new invited user is assigned the role designated to their username

 Scenario: added CV Client PA username is not a member of the BCeID company
     Given the CV Client PA username is in onRoute 
       But it does not match the company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Universal Unauthorized Access" page

@orv2-907-3, @orv2-3322
Rule: a new invited user must complete their user contact details 

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
     And they are directed to a success page
  
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

# @orv2-907-4
Rule: a new PA user can only view company profile information

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to view their profile
      Then they are directed to company information
       But they cannot edit company information

# @orv2-907-5
Rule: a new user can apply for a permit

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to apply for a permit
      Then they are directed to applications in progress
