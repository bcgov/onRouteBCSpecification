Feature: CV Client create a New onRouteBC Profile
 As a user I want to log in to onRouteBC using my BCeID credentials so that I can create a new onRouteBC Profile.

User = basic or business

@orv2-369-1, @orv2-3322-7
Rule: a user can create a new onRouteBC profile

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

  Scenario: first user, complete profile creation workflow
    Given the user has successfully completed the profile creation workflow
     When they choose to finish
     Then they are directed to the success page
      And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |
      And they are sent a profile creation confirmation email
      #see orv2-477

@orv2-4312-1
Rule: a user can view and edit their onRouteBC profile contact information

  Scenario: choose not to claim a profile info box
     When a user chooses not to claim a profile
     Then they are directed to the "Create onRouteBC Profile" edit page
     And they see the following information boxes:
        | Client name must be the registered owner (company or individual) of the vehicles being permitted. |

   Scenario: Edit "Company Information"
       When a user chooses to finish creating their profile
       Then they are directed to the "Create onRouteBC Profile" edit page
       And they see the following fields:
         | my company fields    | editable |
         | Client Name          | Yes      |
         | DBA                  | Yes      |
         | First Name           | Yes      |
         | Last Name            | Yes      |
         | Email                | Yes      |
         | Primary Phone        | Yes      |
         | Ext                  | Yes      |
         | Alternate Phone      | Yes      |
         | Ext                  | Yes      |
         | Address Line 1       | Yes      |
         | Address Line 2       | Yes      |
         | Country              | Yes      |
         | Province/State       | Yes      |
         | City                 | Yes      |
         | Postal Code/Zip Code | Yes      |

@orv2-369-2, @orv2-3322-8 @orv2-4312-2
Rule: Validate mandatory fields in the onRouteBC profile creation form
  
    Scenario: business mandatory fields
     When they do not input data into any of the following mandatory fields:
       | Client Name                 |
       | First Name                  |
       | Last Name                   |
       | Primary Phone               |
       | Address (Line 1)            |
       | Country                     |
       | Province / State            |
       | City                        |
       | Postal / Zip Code           |
     Then they see "This is a required field" at each field with invalid data
      And fields without data are indicated
      
  Scenario: basic mandatory fields
    Given a user chooses to finish creating their onRouteBC profile
     When they do not input valid data into any of the following mandatory fields:
       | Client Name                |
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
      And fields without valid data are indicated

@orv2-3228-12 @orv2-4312-3
Rule: email is address is not editable for business users

  Scenario: business user email not editable
     Given a business user has successfully completed the claim challenge
      When they attempt to edit their email address
      Then they see "Email" is not editable
       And they cannot change their email address

Rule: users credential information replaces the "Client Name" and "Email" information in onRouteBC

Rule: a user that successfully creates a new profile is designated as the CV Client Administrator (CA)

  Scenario: success
    Given they successfully log in using their BCeID credentials
     When they successfully complete the new onRouteBC profile creation
     Then they are designated as an admin user

Rule: a user is sent a profile creation confirmation email upon successfully completing their new onRouteBC profile

@orv2-369-13, @orv2-3322-9
Rule: BCeID manages credential and system issues separate of onRouteBC

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page