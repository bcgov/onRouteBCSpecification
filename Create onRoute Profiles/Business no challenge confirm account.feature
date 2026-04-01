Feature: Business no challenge confirm existing onRouteBC profile
 As a business user that has used TPS Online previously and with an existing migrated onRouteBC profile I want to be able to log into onRouteBC and complete my onRouteBC profile.

first user = migrated business user that is the first user of the onRouteBC profile
second+ user = migrated business user that is not the first user of the onRouteBC profile

@orv2-1637-2, @orv2-3228-2
Rule: A first user can claim a matching existing onRouteBC profile without a challenge

  Scenario: first user, credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does not have any existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the option to complete their profile 

  Scenario: first user, complete profile
    Given the user has chosen to complete their profile
     When they choose to complete their profile 
     Then they are directed to the "Company Information" step of the workflow

  Scenario: first user, complete no challenge workflow
    Given the user has successfully completed the no challenge workflow
     When they choose to finish
     Then they are directed to the success page
      And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |
      And they are sent a profile creation confirmation email
      #see orv2-477

@orv2-1637-3, @orv2-3228-3
Rule: A second+ user can join a matching existing onRouteBC profile

  Scenario: not the first user, credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does have existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the complete "My Information" workflow

@orv2-1637-4, @orv2-3228-4 @orv2-4312-7
Rule: A first user can view and edit their claimed "Client No." profile contact details

  Scenario: choose finish creating profile info box
     When a user has successfully completed the challenge
     Then they are directed to the "Create onRouteBC Profile" edit page
      And they see the following information boxes:
        | Client name must be the registered owner (company or individual) of the vehicles being permitted. |

   Scenario: Edit "Company Information"
       When a first user chooses to finish creating their profile
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

@ovr2-4312-8
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

@orv2-3228-12 @orv2-4312-9
Rule: email is address is not editable for business users

  Scenario: business user email not editable
     Given a business user has successfully completed the claim challenge
      When they attempt to edit their email address
      Then they see "Email" is not editable
       And they cannot change their email address

@orv2-1637-5, @orv2-3228-5
Rule: A second+ user can update their user details

  Scenario: mandatory fields
    Given a user chooses to finish creating their onRouteBC profile
     When they do not input valid data into any of the following mandatory fields:
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

@orv2-1637-6, @orv2-3228-6
Rule: A first users credential information replaces the "Client Name" and "Email" information in onRouteBC

  Scenario: information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their BCeID credential:
        | Client Name |
        | Email       |

@orv2-1637-7, @orv2-3228-7
Rule: A first business user is sent a profile creation confirmation email
@orv2-481-15, @orv2-3228-8
Rule: users that have successfully joined an onRouteBC Profile are associated to their BCeID username
@orv2-1637-1, @orv2-3228-1
Rule: users that successfully claim or join an existing onRouteBC profile are designated as CV Client Administrators (CA)

  Scenario: first user
    Given they successfully log in using their BCeID credentials
     When they successfully complete the no challenge claim workflow
     Then they are designated as an admin user

  Scenario: second+ user
    Given they successfully log in using their BCeID credentials
      And they are not the first user
     When they successfully complete the no challenge "My Information" workflow
     Then they are designated as an admin user

Rule: BCeID manages credential and system issues separate of onRouteBC

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page