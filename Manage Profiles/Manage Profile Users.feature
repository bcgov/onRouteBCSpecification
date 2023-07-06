Feature: Add new users
As a CV Client admin I want to add new users to my onRouteBC profile so that they can use my profile based on their assigned role.

Scenario: Wrong username added 
    Given the CV Client admin is at the "User Management" page
    When they 
    Then they 

@orv2-363-1
Scenario: Navigate to Add User page
    Given the CV Client admin is at the "User Management" page
    When they select "Add User"
    Then they are directed to the "Add User" page

@orv2-363-2
Scenario: Input new pending user BCeID username
    Given the CV Client admin is at the "Add User" page
    When they input a BCeID username
    And they select "Add"
    Then they see "User Added"
    And they are directed to the "User Management" page
    And the newly added user is displayed as pending

@orv2-363-3
Scenario: Cancel add new user
    Given the CV Client admin is at the "Add User" page
    When they select "Cancel"
    Then they are directed to the "User Management" page
   
@orv2-363-4
Scenario: Does not assign new pending user to user group
    Given the CV Client admin is at the "Add User" page
    When they a "User Group" is not assigned
    And they select "Add User"
    Then they see "You must assign a User group"

@orv2-363-5
Scenario: Default new pending user to user group "Permit Applicant"
    Given the CV Client admin is at the "Add User" page
    When they view the "User Group" assignment list
    Then they see "Permit Applicant" checked

@orv2-363-6
Scenario: Assign new pending user to one or more user groups
    Given the CV Client admin is at the "Add User" page
    When they assign one or more "User Groups"
    Then they see indication of each assigned role

@orv2-363-7
Scenario: View user group permissions
    Given the CV Client admin is at the "Add New User" page
    When they select "User Groups and Permissions"
    Then they are directed to the "User Groups and Permission" page
    And they see <function> and <permission> a <Administrator> and <Permit Applicant> has permission to use; Y for yes and N for no

    Examples:
      | function                   | permission                             | Administrator | Permit Applicant |
      | Permits                    | All Functions                          | Y             | Y                |
      | Manage Vehicle Inventory   | All Functions                          | Y             | Y                |
      | Manage Company Information | View profile                           | Y             | Y                |
      | Manage Company Information | Update profile information             | Y             | N                |
      | Manage Company Users       | All functions                          | Y             | N                |
      | Manage Company Users       | Update my own user profile information | Y             | Y                |
      
Feature: View and manage profile users and roles 
As a CV Client admin I want to view and edit information about users so that I can maintain an accurate inventory of authorized users of my onRouteBC profile.

Background: Users can have the following statuses:
    | Active      |
    | Pending     |

@orv2-480-1
Scenario: Sort list of users
    Given the CV Client admin is at the "User Management" page
    When they select any of the following column headers:
      | BCeID Username |
      | First Name     | 
      | Last Name      | 
      | User Group     | 
      | Date Created   | 
    Then the list is sorted by the selected column header
    And the sort order is the reverse of the previously selected order

@orv2-480-2
Scenario: Delete one or more users selection indication
    Given the CV Client admin chooses to delete one or more users
    When they choose a user to delete
    Then the choosen user is indicated 

@orv2-480-5
Scenario: Delete one or more users warning
    Given the CV Client admin has chosen one or more users to delete
    When they choose to delete
    Then they see "Are you sure you want to delete this user? This action cannot be undone."

@orv2-480-3
  Scenario: Continue delete
    Given the CV Client chooses to continue delete
     When they choose delete
     Then they are directed to the "User Management" page
      And they see "User Deleted" notification
      And the user is removed from the "User Management" list

@orv2-480-4
Scenario: Cancel a user deletion
    Given the CV Client admin is at the "Delete user?" warning
    When they select "Cancel"
    Then they are directed to the "User Management" page

@orv2-480-6
Scenario: View and edit user "My Information"
    Given the CV Client admin is at the "User Management" page
    When they select "Edit"
    Then they are directed to the "Edit User" page

@orv2-480-7
Scenario: Cancel view and edit user "My Information"
    Given the CV Client admin is at the "Edit User" page
    When they select "Cancel"
    Then they are directed to the "User Management" page

@orv2-480-8 
Scenario: Save edit changes to user "My Information"
    Given the CV Client admin is at the "Edit User" page
    When they select "Save"
    Then they are directed to the "User Management" page
    And changes are saved to the database
    And they see "Changes Saved" notification

@orv2-480-9 
Scenario: Indicate mandatory "My Information" fields    
    Given the CV Client Admin is editing a users "My Information"
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