Feature: CV Client invited user log into onRouteBC
  As an invited user I need to be able to log into onRouteBC for the first time and complete my onRouteBC profile so that I can begin ordering permits for the onRouteBC company I am a member of.

User = invited cv client basic or business

@orv2-907-1, @orv2-3322-18, @orv2-3228
Rule: credential username must match invited username in onRouteBC

  Scenario: username in onRouteBC and matches 
     Given the credential username matches invited username in onRouteBC
      When a user successfully logs in using their BCeID credentials
      Then they are directed to the welcome page
       And they see the client name for the profile they are invited to
       And they see the option to finish creating their profile

  Scenario: basic username does not match one in onRouteBC
    Given the credential username is not in onRouteBC
      And their credential does not match an existing user in onRouteBC
     When a user successfully logs in using their BCeID credentials
     Then they are directed to the welcome to onRouteBC page 

 Scenario: business username not in onRouteBC, credentials match a company in onRouteBC
     Given the username is not in onRouteBC
       And they are not the first user
       But their credentials match a company in onRouteBC
      When a user successfully logs in using their BCeID credentials
      Then they are directed to the universal unauthorized access page

 Scenario: business username not in onRoute, credentials do not match a company in onRouteBC
     Given the username is not in onRouteBC
       And their credentials do not match a company in onRouteBC
      When a user successfully logs in using their BCeID credentials
      Then they are directed to the welcome to onRouteBC page 
       And they see their credential client name
       And they see the option to create a new profile or claim an existing profile

@orv2-907-2, @orv2-3322-19, @orv2-3228
Rule: a user is assigned the role designated to their username

  Scenario: CA
    Given a user is designated as a company administrator (CA)
     When they successfully complete their profile
     Then they are a CA

  Scenario: PA
    Given a user is designated as a company administrator (CA)
     When they successfully complete their profile
     Then they are a PA

 # could there be a scenario where an invited user is not a member of a company?
 # Scenario: CA username is not a member of company
     Given the CA username is in onRoute 
       But it does not match a company
      When they successfully log in using their BCeID credentials
      Then they are directed to the universal unauthorized access page

 # Scenario: PA username is not a member of company
     Given the PA username is in onRoute 
       But it does not match the company BCeID
      When they successfully log in using their BCeID credentials
      Then they are directed to the universal unauthorized access page

@orv2-907-3, @orv2-3322-20, @orv2-3228
Rule: a new invited user must complete their user contact details   

 Scenario: Complete profile
     Given a user chooses to finish completing their onRouteBC profile
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
     And they are assigned the role designated to their username
     And they are directed to a success page
  
  Scenario: Mandatory fields
    Given a user chooses to finish completing their onRouteBC profile
     When they do not input valid data into any of the following mandatory fields:
       | field            |
       | First Name       |
       | Last name        |
       | Email            |
       | Primary Phone    |
       | Country          |
       | Province / State |
       | City             |
     Then they see "This is a required field" at each field with invalid data
      And fields with invalid data are indicated
