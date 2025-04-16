Feature: Staff no challenge confirm existing onRouteBC profile
 As staff I need to claim a migrated onRouteBC profile so that I can assist CV Clients with purchasing permits.

User = PC, SA, Train, CTPO

# if no BCeID and company claimed by staff then a new cv client user goes through the challenge workflow
# can update company name and email address

@orv2-1637-1, @orv2-3228
Rule: A user can claim an existing onRouteBC profile on behalf of a CV Client

  Scenario: unclaimed profile
    Given staff find an unclaimed onRouteBC profile
     When they choose to view the profile
     Then they are directed to complete the profile contact details

@orv2-1637-2, @orv2-3228
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
    Given the user has successfully completed the "My Information" step of the workflow
     When they choose to proceed
     Then they are directed to the success page
      And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |
      And they are sent a profile creation confirmation email
      #see orv2-477

@orv2-1637-4, @orv2-3228
Rule: A first user can view and update their claimed "Client No." profile contact details

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

@orv2-1637-6, @orv2-3228
Rule: A first users credential information replaces the "Client Name" and "Email" information in onRouteBC

  Scenario: information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their BCeID credential:
        | Client Name |
        | Email       |

@orv2-1637-7, @orv2-3228
Rule: A first business user is sent a profile creation confirmation email
@orv2-481-15, @orv2-3228
Rule: users that have successfully joined an onRouteBC Profile are associated to their BCeID username