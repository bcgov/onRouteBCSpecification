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
     When they choose to claim an existing profile
     Then they are directed to claim an existing profile
     And they see the information boxes:
      | Where can I find my Client No. and Permit No.?                          |
      | Enter any Permit No. issued to the above Client No. in the last 2 years |

 Scenario: choose no
     When they choose not to claim an existing profile
     Then they are directed to  create a new onRouteBC profile

@orv2-481-2
Rule: If a "Client No." is associated to a "Permit No." then allow a CV Client to proceed to the next step in the workflow "Company Information"

 Scenario: Valid TPS "Client No." and "Permit No."
     Given they input a "Client No." that is in onRouteBC
       And they input a "Permit No." that is associated to the "Client No." 
      When they choose to proceed
      Then they are directed to next step in the workflow "Company Information"
       And they see "Verify Profile" completed success indication

 Scenario: Invalid TPS "Client No."
     Given they input a "Client No." that is not in onRouteBC
      When they choose to proceed
      Then they see "Client No. not found"
       And "Client No." is indicated
       And they cannot proceed to the next step in the workflow

 # This can be reversed valid permit no. invalid client no. the behaviour is the same
 Scenario: Valid TPS "Client No." invalid "Permit No."
     Given they input a "Client No." that is in onRouteBC
       And they input a "Permit No." that is not associated to the "Client No."
      When they choose to proceed
      Then they see "Permit No. does not match Client No."
       And "Permit No." is indicated
       And they cannot proceed to the next step in the workflow      

@orv2-481-3
Rule: Both "Permit No." and "Client No." are mandatory fields

 Scenario: Only a "Permit No." inputted
    Given they input a "Permit No." that is in onRouteBC
      And they have not inputted a "Client No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Client No." is indicated
      And they cannot proceed to the next step in the workflow     

 Scenario: Only a "Client No." inputted
    Given they input a "Client No." that is in onRouteBC
      And they have not inputted a "Permit No." 
     When they choose to proceed
     Then they see "This is a required field"
      And "Permit No." is indicated
      And they cannot proceed to the next step in the workflow

 Scenario: "Client No." and "Permit No." not inputted
     Given they do not input a "Client No."
       And they do not input a "Permit No."
      When they choose to proceed
      Then they see "This is a required field"
       And "Permit No." is indicated 
       And "Client No." is indicated
       And they cannot proceed to the next step in the workflow

@orv2-481-4
Rule: A CV Client must view and update their claimed "Client No." profile information

  Scenario: Info boxes
    Given a CV Client passed "Verify Profile"
     When they choose to proceed to "Company Information"
     Then they see the following information boxes:
        | Please note, unless stated otherwise, all fields are mandatory.                         |
        | The Company Primary Contact will be contacted for all onRouteBC client profile queries. |
      And they see "Verify Profile" completed success indication

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
    Given a CV Client passed "Verify Profile"
     When they view company contact details
     Then they see the email address from their Business BCeID profile
      And they cannot edit it

@orv2-481-5
Rule: A CV Clients credential information replaces the "Company Name" and "Company Email" information in onRouteBC

  Scenario: Information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their Business BCeID profile:
        | Company Name  |
        | Company Email |

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

@orv2-481-12
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

# @ovr2-481-14
# Rule: TPS Office clients that have successfully claimed their onRouteBC Profiles are associated to the first users Business BCeID company GUID
# @orv2-481-15
# Rule: TPS Office users that have successfully joined an onRouteBC Profile are associated to their BCeID username

# if no BCeID and company claimed by staff then a new user goes through the challenge workflow

# staff needs to buy a permit on behalf of company, TPS migrated to onRouteBC, onRouteBC profile not claimed by client yet, when staff finds a company and selects the profile link they go to no challenge company information

