
Feature: View/Edit CV Client Company Information Details
    As a CV Client Business BCeID user in the Admin User Group I want to manage "Company Information" so that I can maintain my company contact details.

Background: The CV Client Business BCeID User Admin (CA) has successfully logged into onRouteBC using their business BCeID and completed the creation of their onRouteBC Profile.

@orv2-354-1
Scenario: View "Company Information"
    Given the CA is at the onRouteBC home page
    When they select "Profile"
    And they select "Company Information"
    Then they are directed to the "Company Information" page
    And only fields that contain data are displayed
    
@orv2-354-2
Scenario: View BCeID company data
    Given the CA is at their "Company Information"
    When they are viewing the "Company Information" page <BCeID data fields>
    Then they see <BCeID Data>
    And they cannot edit these fields

    Examples:
      | BCeID Data fields  | BCeID Data          | 
      | Company Legal Name | bceid_business_name | 
      | Email              | BCeID email         |

@orv2-354-3 @orv2-2315-2 @orv2-4818-1
Rule: only authorized users can edit company profile contact details

  Scenario: authorized
     When CA chooses to edit company information
     Then they see the option to edit company information

  Scenario: not authorized
     When PA chooses to edit company information
     Then they do not see the option to edit company information

Scenario: Edit "Company Information"
    Given the CA chooses to edit their "Company Information"
    And they are at the "Company Information" page
    When they select "Edit"
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
      | Fax                  | Yes      |
      | Email                | Yes      |
      | First Name           | Yes      |
      | Last Name            | Yes      |
      | Phone                | Yes      |
      | Ext                  | Yes      |
      | Email                | Yes      |
      | Alternative Phone    | Yes      |
      | City                 | Yes      |
      | Province/State       | Yes      | 

@orv2-354-4
Scenario: Save edits to "Company Information"
    Given the CA is at their "Company Information" edit page
    And they save changes 
    Then the changes are saved 
    And they are directed to the "Company Information" page
    And their changes are displayed

@orv2-354-5
Scenario: Cancel edit "Company Information"
    Given the CA editing their "Company Information" page
    When they select "Cancel"
    Then the changes are not saved 
    And they are directed to the "Company Information" page

@orv2-354-6
Scenario: Edit company information navigate away from "Company Information" page
    Given the CA is at their "Company Information" page
    When they make changes to their "Company Information"
    And they navigate away from the "Company Information" page 
    Then the changes are not saved 

@orv2-354-7 @orv2-4818-2
Scenario: Indicate mandatory fields    
    Given the CA is editing their "Company Information"
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

