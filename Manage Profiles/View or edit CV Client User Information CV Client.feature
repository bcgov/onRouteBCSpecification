Feature: View/Edit CV Client user information
    As a CA or User I want to manage "My Information" so that I can maintain my contact details.

@orv2-353-1
Scenario: View "My Information"
    Given the CA or User is at the onRouteBC home page
    When they select "Profile"
    And they select "My Information" 
    Then they are directed to "My Information" page
    And only fields that contain data are displayed

@orv2-353-2
Scenario: Edit "My Information"
    Given the CA or User chooses to edit their "My Information"
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
    Given the CA or User is at their "My Information" edit page
    When they make changes to their "My Information"
    And they save changes 
    Then the changes are saved 
    And they are directed to their "My Information" page
    And their changes are displayed

@orv2-353-4
Scenario: Indicate mandatory "My Information" fields    
    Given the CA or User is editing their "My Information"
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
    Given the CA is editing their "My Information" page
    When they make changes to their user information
    And they select "Cancel"
    Then the changes are not saved 
    And they are directed to their "My Information" page

@orv2-353-6
Scenario: Edit "My Information" navigate away from page
    Given the CA or User is at their "My Information" page
    When they make changes to their user information
    And they navigate away from the My Information page 
    Then the changes are not saved 

@orv2-353-7
Scenario: One time populate "My Information" with BCeID user data at first login
    Given the CA or User has logged into onRouteBC for the first time
    And they are at the "My Information" page
    When they are viewing the "My Information" page <BCeID data fields>
    Then they see <BCeID Data>

    Examples:
    | BCeID Data fields  | BCeID Data          | 
    | First Name         | BCeID display_name  | 
    | Last Name          | BCeID display_name  | 
    | Email              | BCeID email         |