Feature: Business no challenge confirm existing onRouteBC profile
 As a business user that has used TPS Online previously and with an existing migrated onRouteBC profile I want to be able to log into onRouteBC and complete my onRouteBC profile.

@orv2-1637-1
Rule: TPS migrated business users that successfully claim or join an existing onRouteBC profile are designated as CV Client Administrators (CA)

  Scenario: first user
    Given they successfully log in using their BCeID credentials
     When they successfully complete the no challenge claim workflow
     Then they are designated as an admin user

  Scenario: not first user
    Given they successfully log in using their BCeID credentials
      And they are not the first user
     When they successfully complete the no challenge "My Information" workflow
     Then they are designated as an admin user

@orv2-1637-2
Rule: A first business user can claim a matching existing onRouteBC profile without a challenge

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
    Given the user has successfully completed the "My Information" step of the workflow
     When they choose to proceed
     Then they are directed to the success page
      And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |
      And they are sent a profile creation confirmation email
      #see orv2-477

@orv2-1637-3
Rule: A second+ business user can join a matching existing onRouteBC profile

  Scenario: not the first user, credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does have existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the complete "My Information" workflow

@orv2-1637-4
Rule: A first business user can view and update their claimed "Client No." profile contact details

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

@orv2-1637-5
Rule: A second+ business user can update their user details

  Scenario: andatory fields
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

@orv2-1637-6
Rule: A first business users credential information replaces the "Client Name" and "Email" information in onRouteBC

  Scenario: information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their BCeID credential:
        | Client Name |
        | Email       |

@orv2-1637-7    
Rule: A first business user is sent a profile creation confirmation email