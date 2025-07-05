
Feature: View/Edit CV Client Company Information Details

user = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA
auth user = CA, PC, SA, TRAIN, CTPO
non-auth user = PA, FIN, EO, HQA

# page header updates

@orv2-354-1 @orv2-1587-0 @orv2-4002-1 @orv2-3835-29 @orv2-4818-1
Rule: users can view "Company Information"

 Scenario: view only
     When a user chooses the "Profile" page
     Then they are directed to the "Company Information" tab
      And they only see fields that contain data
      And nothing is editable
      But they always see section headers:
        | Doing Business As (DBA) |
        | Mailing Address         |
        | Contact Details         |
        | Primary Contact         |

  Scenario: edit
     When a user chooses to edit their "Company Information"
     Then they are directed to the "Company Information" tab
      And they see the following fields:
       | field                | header                  |
       | Client Name          | Client Name             |
       | DBA                  | Doing Business As (DBA) |
       | Address Line 1       | Mailing Address         |
       | Address Line 2       | Mailing Address         |
       | City                 | Mailing Address         |
       | Province/State       | Mailing Address         |
       | Postal Code/Zip Code | Mailing Address         |
       | Country              | Mailing Address         |
       | Phone                | Contact Details         |
       | Ext                  | Contact Details         |
       | Email                | Contact Details         |
       | First Name           | Primary Contact         |
       | Last Name            | Primary Contact         |
       | Phone                | Primary Contact         |
       | Ext                  | Primary Contact         |
       | Email                | Primary Contact         |
       | Alternative Phone    | Primary Contact         |
     
@orv2-354-3 @orv2-2315-2 @orv2-4818-2
Rule: only authorized users (auth users) can edit company profile contact details

  Scenario: authorized
     When auth user chooses to edit company information
     Then they see the option to edit company information

  Scenario: not authorized
     When non-auth user chooses to edit company information
     Then they do not see the option to edit company information

Scenario: Edit "Company Information"
    When an auth user chooses to edit their "Company Information"
    Then they are directed to the "Company Information" edit page
    And all <my company fields> are displayed
    And have <editable> restrictions 
  
    Examples: 
      | my company fields    | editable |
      | onRouteBC Client No. | No       |
      | Client Name          | Yes      |
      | DBA                  | Yes      |
      | Address Line 1       | Yes      |
      | Address Line 2       | Yes      |
      | City                 | Yes      |
      | Province/State       | Yes      |
      | Postal Code/Zip Code | Yes      |
      | Country              | Yes      |
      | Phone                | Yes      |
      | Ext                  | Yes      |
      | Email                | Yes      |
      | First Name           | Yes      |
      | Last Name            | Yes      |
      | Phone                | Yes      |
      | Ext                  | Yes      |
      | Email                | Yes      |
      | Alternative Phone    | Yes      |
      | City                 | Yes      |
      | Province/State       | Yes      | 

Scenario: Save edits to "Company Information"
    Given a auth user is editing their "Company Information"
    And they save changes 
    Then the changes are saved 
    And they are directed to the "Company Information" page
    And they see "Changes Saved" notification
    And their changes are shown

  Scenario: save edits to client name
     Given a auth user is editing their "Company Information"
     When they change the "Client Name" field
     And they save changes
     Then the changes are saved
     And they are directed to the "Company Information" page
     And they see "Changes Saved" notification
     And the new "Client Name" is shown in the "Company Information" page and the onRouteBC page header

Scenario: Cancel edit "Company Information"
    Given a auth user is editing their "Company Information"
    When they select "Cancel"
    Then the changes are not saved 
    And they are directed to the "Company Information" page

Scenario: Edit company information navigate away from "Company Information" page
    Given a auth user is editing their "Company Information"
    When they make changes to their "Company Information"
    And they navigate away from the "Company Information" page 
    Then the changes are not saved 

@orv2-354-7 @orv2-1587-3 @orv2-1521-3 @orv2-4818-4
Rule: Validate mandatory fields in "Company Information"

Scenario: Indicate mandatory fields    
    Given a auth user is editing their "Company Information"
    When they do not enter valid data into a <mandatory field>  
    And they choose to save changes    
    Then they see <mandatory field error message>     
    And they cannot save their changes

    Examples:  
      | mandatory field            | mandatory field error message  | 
      | Client Name                | This is a required field.      | 
      | Address Line 1             | This is a required field.      | 
      | City                       | This is a required field.      | 
      | Province/Sate              | This is a required field.      | 
      | Postal Code/Zip Code       | This is a required field.      | 
      | Country                    | This is a required field.      | 
      | Phone                      | This is a required field.      | 
      | Email                      | This is a required field.      |
      | Primary Contact First Name | This is a required field.      | 
      | Primary Contact Last Name  | This is a required field.      | 
      | Primary Contact Phone      | This is a required field.      | 
      | Primary Contact Email      | This is a required field.      | 
      | Primary Contact City       | This is a required field.      |      

# Deprecated Rules and Scenarios:

 # @orv2-354-2 @orv2-1587-1 
 # Rule: BCeID company data is displayed

 # Scenario: View BCeID company data
     Given a user is at their "Company Information"
     When they are viewing the "Company Information" page <BCeID data fields>
     Then they see <BCeID Data>
     And they cannot edit these fields

     Examples:
       | BCeID Data fields | BCeID Data          |
       | Client Name       | bceid_business_name |
       | Email             | bceid_email         |

 # @orv2-1587-4 @orv2-3835-9
 # Rule: only authorized staff can cancel edit company

 # Scenario: Cancel edit "Company Information"
      Given PC, SA, TRAIN, CTPO is editing "Company Information"
      When they select "Cancel"
      Then the changes are not saved 
      And they are directed to the "Company Information" page