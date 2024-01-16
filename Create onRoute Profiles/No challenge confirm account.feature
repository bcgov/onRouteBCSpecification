Feature: No challenge confirm existing onRouteBC profile
 As a CV Client with an existing onRouteBC profile I want to be able to log into onRouteBC and complete my onRouteBC profile.

@orv2-1637-1
Rule: TPS migrated users that successfully claim or join an existing onRouteBC profile are designated as CV Client Administrators (CA)

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
Rule: A user can claim a matching existing onRouteBC profile if they are the first user without a challenge

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
Rule: A user can join a matching existing onRouteBC profile if they are not the first user

  Scenario: not the first user, credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does have existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the complete "My Information" workflow

@orv2-1637
Rule: Rule: A CV Client must view and update their claimed profile "Company Information"

  Scenario: Info boxes
      Given a CV Client is at "Company Information"
       When they view "Company Information"
       Then they see the following information boxes:
          | Please note, unless stated otherwise, all fields are mandatory.                         |
          | The Company Primary Contact will be contacted for all onRouteBC client profile queries. |

  Scenario: Mandatory fields
    Given a CV Client chooses to proceed to "My Information"
     When they do not input valid data into any of the following mandatory fields:
        | field             | type                    |
        | Address (Line 1)  | User Details            |
        | Country           | User Details            |
        | Province / State  | User Details            |
        | City              | User Details            |
        | Postal / Zip Code | User Details            |
        | Phone             | Company Contact Details |
        | First Name        | Company Primary Contact |
        | Last name         | Company Primary Contact |
        | Email             | Company Primary Contact |
        | Primary Phone     | Company Primary Contact |
        | Country           | Company Primary Contact |
        | Province / State  | Company Primary Contact |
        | City              | Company Primary Contact |
     Then they see "This is a required field" at each field with invalid data
      And fields with invalid data are indicated

  Scenario: Company contact details email uneditable
    Given a CV Client is at "Company Information" in the workflow
     When they view company contact details
     Then they see the email address from their Business BCeID profile
      And they cannot edit it

@orv2-1637
Rule: A CV Client must update their "My Information"

  Scenario: Info boxes
    Given a CV Client has completed "Company Information"
     When they choose to proceed to "My Information"
     Then they see the following information boxes:
        | Please note, unless stated otherwise, all fields are mandatory.                         |
      And they see "Company Profile" completed success indication

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
@orv2-1637
Rule:A CV Clients credential information replaces the "Company Name" and "Company Email" information in onRouteBC

  Scenario: Information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their Business BCeID profile:
        | Company Name  |
        | Company Email |

@orv2-1637
Rule: A CV Client must view their onRouteBC Client Number upon successful completion of the claim profile workflow

  Scenario: Successfully completed 
    Given a CV Client has completed "My Information"
     When they choose to complete the workflow
     Then they are directed to a success page
     And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |
      And they are sent a profile creation confirmation email
      #see orv2-477
@orv2-1637
Rule: Upon completing claim a profile or joining an existing profile a user can view their profile or apply for a permit
@orv2-1637
Rule: A user can cancel or step backwards in the "Claim an existing profile" workflow

  Scenario: Cancel
    Given they have chosen to claim a TPS profile
     When they choose to cancel
     Then they are directed to the "Welcome to onRouteBC" page

  Scenario: Previous
    Given they have completed "Verify Profile"
     When they choose to return to a previous page
     Then they are directed to the previous page in the workflow
      And the workflow step indication reflects the page they are on

@orv2-1637
Rule: The navigation bar is not visible until the profile has been successfully claimed