
Feature: View/Edit CV Client Company Information Details
    As a CV Client Business BCeID user in the Admin User Group I want to manage "Company Information" so that I can maintain my company contact details.

Background: The CV Client Business BCeID User Admin (CV Client Admin) has successfully logged into onRouteBC using their business BCeID and completed the creation of their onRouteBC Profile.

@orv2-354-1
Scenario: View "Company Information"
    Given the CV Client Admin is at the onRouteBC home page
    When they select "Profile"
    And they select "Company Information"
    Then they are directed to the "Company Information" page
    And only fields that contain data are displayed
    
@orv2-354-2
Scenario: View BCeID company data
    Given the CV Client Admin is at their "Company Information"
    When they are viewing the "Company Information" page <BCeID data fields>
    Then they see <BCeID Data>
    And they cannot edit these fields

    Examples:
      | BCeID Data fields  | BCeID Data          | 
      | Company Legal Name | bceid_business_name | 
      | Email              | BCeID email         |

@orv2-354-3
Scenario: Edit "Company Information"
    Given the CV Client Admin chooses to edit their "Company Information"
    And they are at the "Company Information" page
    When they select "Edit"
    Then they are directed to the "Company Information" edit page
    And all <my company fields> are displayed
    And have <editable> restrictions 
  
    Examples: 
      | my company fields    | editable | 
      | onRouteBC Client No. | No       | 
      | Company Legal Name   | No       |
     | DBA                   |Yes       | 
      | Address Line 1       | Yes      | 
      | Address Line 2       | Yes      | 
      | City                 | Yes      | 
      | Province/State       | Yes      | 
      | Postal Code/Zip Code | Yes      | 
      | Country              | Yes      | 
      | Phone                | Yes      | 
      | Ext                  | Yes      | 
      | Fax                  | Yes      | 
      | Email                | No       | 
      | First Name           | Yes      | 
      | Last Name            | Yes      | 
      | Phone                | Yes      | 
      | Ext                  | Yes      | 
      | Email                | Yes      | 
      | Alternative Phone    | Yes      | 
      | City                 | Yes      | 
      | Province/State       | Yes      | 

@orv2-354-4
Scenario: Save edits to "Company Information"
    Given the CV Client Admin is at their "Company Information" edit page
    And they save changes 
    Then the changes are saved 
    And they are directed to the "Company Information" page
    And their changes are displayed

@orv2-354-5
Scenario: Cancel edit "Company Information"
    Given the CV Client Admin editing their "Company Information" page
    When they select "Cancel"
    Then the changes are not saved 
    And they are directed to the "Company Information" page

@orv2-354-6
Scenario: Edit company information navigate away from "Company Information" page
    Given the CV Client Admin is at their "Company Information" page
    When they make changes to their "Company Information"
    And they navigate away from the "Company Information" page 
    Then the changes are not saved 

@orv2-354-7
Scenario: Indicate mandatory fields    
    Given the CV Client Admin is editing their "Company Information"
    When they do not enter valid data into a <mandatory field>  
    And they choose to save changes    
    Then they see <mandatory field error message>     
    And they cannot save their changes

    Examples:  
      | mandatory field            | mandatory field error message  | 
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

Feature: View/Edit CV Client user information
    As a CV Client Admin or User I want to manage "My Information" so that I can maintain my contact details.

Background: 

@orv2-353-1
Scenario: View "My Information"
    Given the CV Client Admin or User is at the onRouteBC home page
    When they select "Profile"
    And they select "My Information" 
    Then they are directed to "My Information" page
    And only fields that contain data are displayed

@orv2-353-2
Scenario: Edit "My Information"
    Given the CV Client Admin or User chooses to edit their "My Information"
    When they select "Edit"
    Then they are directed to the "My Information" edit page
    And all <my info fields> are displayed
    And have <editable> restrictions

    Examples: 
      | my info fields    | editable | 
      | First Name        | No       | 
      | Last Name         | No       | 
      | User Group        | No       |
      | Email             | Yes      | 
      | City              | Yes      | 
      | Province/State    | Yes      | 
      | Primary Phone     | Yes      | 
      | Ext               | Yes      | 
      | Alternate Phone   | Yes      | 
      | Ext               | Yes      | 
      | Fax               | Yes      | 
    
@orv2-353-3
Scenario: Save edits to "My Information"
    Given the CV Client Admin or User is at their "My Information" edit page
    When they make changes to their "My Information"
    And they save changes 
    Then the changes are saved 
    And they are directed to their "My Information" page
    And their changes are displayed

@orv2-353-4
Scenario: Indicate mandatory "My Information" fields    
    Given the CV Client Admin or User is editing their "My Information"
    When they do not enter valid data into a <mandatory field>  
    And they choose to save changes    
    Then they see <mandatory field error message>     
    And they cannot save their changes

    Examples:  
      | mandatory field | mandatory field error message | 
      | First Name      | This is a required field      | 
      | Last Name       | This is a required field      |
      | Country         | This is a required field.     | 
      | Province/Sate   | This is a required field.     |
      | City            | This is a required field      | 
      | Primary Phone   | This is a required field      | 
      | Email           | This is a required field      | 

@orv2-353-5
Scenario: Cancel edit "My Information"
    Given the CV Client Admin is editing their "My Information" page
    When they make changes to their user information
    And they select "Cancel"
    Then the changes are not saved 
    And they are directed to their "My Information" page

@orv2-353-6
Scenario: Edit "My Information" navigate away from page
    Given the CV Client Admin or User is at their "My Information" page
    When they make changes to their user information
    And they navigate away from the My Information page 
    Then the changes are not saved 

@orv2-353-7
Scenario: One time populate "My Information" with BCeID user data at first login
    Given the CV Client Admin or User has logged into onRouteBC for the first time
    And they are at the "My Information" page
    When they are viewing the "My Information" page <BCeID data fields>
    Then they see <BCeID Data>

    Examples:
    | BCeID Data fields  | BCeID Data          | 
    | First Name         | BCeID display_name  | 
    | Last Name          | BCeID display_name  | 
    | Email              | BCeID email         |     

