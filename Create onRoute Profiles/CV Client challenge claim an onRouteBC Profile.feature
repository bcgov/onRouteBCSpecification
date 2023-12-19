Feature: CV Client challenge claim or join an existing onRouteBC Profile
 As a CV Client Business BCeID user I want to claim or join an existing onRouteBC Profile so that I see my profile details and apply for permits.

@orv2-481-1
Rule: A user is provided the option to claim a profile

  Scenario: user credentials do not match an existing onRouteBC profile
     Given the users credentials do not match a company in onRouteBC
       And they have not been invited
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the following:
         | item                                                                        | description                                       |
         | BCeID Company Name                                                          | that matches their BCeID user credentials         |
         | Has this company purchased a commercial vehicle permit in the last 7 years? | call to actions to claim or not claim the profile |
       And they have the option to try to claim the profile or not claim it
 
 Scenario: choose yes
     Given the CV Client is at the "Welcome to onRouteBC" page
     When they choose to claim an existing profile
     Then they are directed to the "Claim an existing profile" page "Verify Profile" in the workflow
     And they see the workflow active step indication "Verify Profile"
     And they see the information boxes:
      | "Where can I find my Client No. and Permit No.?"|
      | "Enter any Permit No. issued to the above Client No. in the last 7 years" |

  Scenario: choose no
     Given the CV Client is at the "Welcome to onRouteBC" page
     When they choose not to claim an existing profile
     Then they are directed to the "Create a new onRouteBC Profile" page 

@orv2-481-11
Rule: A CV Client can cancel or step backwards in the "Claim an existing profile" workflow

  Scenario: Cancel
    Given they have chosen to claim a TPS profile
     When they choose to cancel
     Then they are directed to the "Welcome to onRouteBC" page

  Scenario: Previous
    Given they have completed "Verify Profile"
     When they choose to return to a previous page
     Then they are directed to the previous page in the workflow
      And the workflow step indication reflects the page they are on

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
Rule: A CV Clients BCeID information replaces the "Company Name" and "Company Email" information in onRouteBC

  Scenario: Information exists in onRouteBC
    Given a CV Client profile has information in "Company Information"
     When they pass "Verify Profile"
     Then the following fields are over written by information from their Business BCeID profile:
        | Company Name  |
        | Company Email |

@orv2-481-6
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

@orv2-481-7
Rule: A CV Client must view their onRouteBC Client Number upon successful completion of the claim profile workflow

  Scenario: Successfully completed 
    Given a CV Client has completed "My Information"
     When they choose to complete the workflow
     Then they are directed to a success page
      And their Business BCeID GUID is stored with their onRouteBC Profile
      And they see their onRouteBC Client Number
      And they see options to apply for a permit and view their profile

@orv2-481-10
Rule: Upon completing claim a profile or joining an existing profile a user can view their profile or apply for a permit
@orv2-481-12
Rule: Users that successfully claim or join an existing onRouteBC profile are designated as CV Client Administrators (CA)
@ovr2-481-14
Rule: TPS Office clients that have successfully claimed their onRouteBC Profiles are associated to the first users Business BCeID company GUID
@orv2-481-15
Rule: TPS Office users that have successfully joined an onRouteBC Profile are associated to their BCeID username
@0rv2-481-8
Rule: The navigation bar is not visible until the profile has been successfully claimed