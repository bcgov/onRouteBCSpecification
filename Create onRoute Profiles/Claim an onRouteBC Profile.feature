Feature: Claim an existing onRouteBC Profile
 As a user I want to claim an existing onRouteBC profile by proving I am the legitimate owner or join an existing one so that I can see my profile details and apply for permits.

User = CV Client

@orv2-481-1, @orv2-3322
Rule: A user is provided the option to claim a profile with a challenge

 Scenario: user credentials do not match an existing onRouteBC profile
     Given user has not been invited
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the following:
         | item                                                                        | description                                           |
         | Client Name                                                                 | Basic = first name last name, Business = company name |
         | Has this company purchased a commercial vehicle permit in the last 2 years? | call to action                                        |
       And they have the option to claim the profile or not
 
 Scenario: choose yes
     When a user chooses to claim an existing profile
     Then they are directed to claim an existing profile
     And they see the information boxes:
      | Where can I find my Client No. and Permit No.?                          |
      | Enter any Permit No. issued to the above Client No. in the last 2 years |

 Scenario: choose no
     When a user chooses not to claim an existing profile
     Then they are directed to  create a new onRouteBC profile

@orv2-481-2, @orv2-3322
Rule: If a "Client No." is associated to a "Permit No." then allow a user to proceed

 Scenario: Valid TPS "Client No." and "Permit No."
     Given a user inputs a "Client No." that is in onRouteBC
       And they input a "Permit No." that is associated to the "Client No." 
      When they choose to proceed
      Then they are directed to next step

 Scenario: Invalid TPS "Client No."
     Given a user inputs a "Client No." that is not in onRouteBC
      When they choose to proceed
      Then they see "Client No. not found"
       And "Client No." is indicated
       And they cannot proceed to the next step

 Scenario: Invalid TPS "Permit No."
     Given a user inputs a "Permit No." that is not in onRouteBC
      When they choose to proceed
      Then they see "Permit No. does not match Client No."
       And "Permit No." is indicated
       And they cannot proceed to the next step

 # This can be reversed valid permit no. invalid client no. the behaviour is the same
 Scenario: Valid TPS "Client No." invalid "Permit No."
     Given they input a "Client No." that is in onRouteBC
       And they input a "Permit No." that is not associated to the "Client No."
      When they choose to proceed
      Then they see "Permit No. does not match Client No."
       And "Permit No." is indicated
       And they cannot proceed to the next step in the workflow      

@orv2-481-3, @orv2-3322
Rule: Both "Permit No." and "Client No." are mandatory fields

 Scenario: Only a "Permit No." inputted
    Given a user inputs a "Permit No." that is in onRouteBC
      And they have not inputted a "Client No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Client No." is indicated
      And they cannot proceed to the next step in the workflow     

 Scenario: Only a "Client No." inputted
    Given a user inputs a "Client No." that is in onRouteBC
      And they have not inputted a "Permit No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Permit No." is indicated
      And they cannot proceed to the next step in the workflow

 Scenario: "Client No." and "Permit No." not inputted
     Given a user does not input a "Client No."
       And they do not input a "Permit No."
      When they choose to proceed
      Then they see "This is a required field"
       And "Permit No." is indicated 
       And "Client No." is indicated
       And they cannot proceed to the next step in the workflow

@orv2-481-4, @orv2-3322
Rule: A user can view and update their claimed "Client No." profile contact details

  Scenario: success
     When a user has successfully completed the challenge
     Then they see the following information boxes:
        | Client name must be the registered owner (company or individual) of the vehicles being permitted. |

  Scenario: basic mandatory fields
     When they do not input data into any of the following mandatory fields:
       | contact details             |
       | First Name                  |
       | Last Name                   |
       | Email                       |
       | Primary Phone               |
       | Address (Line 1)            |
       | Country                     |
       | Province / State            |
       | City                        |
       | Postal / Zip Code           |
     Then they see "This is a required field" at each field with invalid data
      And fields with no data are indicated

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

@orv2-481-5
Rule: A first users credential information replaces the "Client Name" and "Email" information in onRouteBC

  Scenario: information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their BCeID credential:
        | Client Name |
        | Email       |

# @orv2-481-6
# Rule: A CV Client must update their "My Information"

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

@orv2-481-12, @orv2-3322
Rule: first users that successfully claim an existing onRouteBC profile are designated as CV Client Administrators (CA)

  Scenario: first user
    Given they successfully log in using their BCeID credentials
     When they successfully complete the claim challenge
      And finish updating their contact details
     Then they are designated as an admin user

  Scenario: second+ basic user
    Given they successfully log in using their basic BCeID credentials
      And they are not the first user
      And they are not invited
     When they successfully complete the claim challenge
     Then they are directed to the universal unauthorized access page

@ovr2-481-14
Rule: TPS Office business users that have successfully claimed their onRouteBC Profiles are associated to the first users Business BCeID company GUID
@orv2-481-15
Rule: TPS Office business users that have successfully joined an onRouteBC Profile are associated to their BCeID username

# if no BCeID and company claimed by staff then a new user goes through the challenge workflow

# staff needs to buy a permit on behalf of company, TPS migrated to onRouteBC, onRouteBC profile not claimed by client yet, when staff finds a company and selects the profile link they go to no challenge company information

