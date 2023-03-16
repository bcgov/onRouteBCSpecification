Feature: Add new users
As a CV Client admin I want to add new users to my onRouteBC profile so that they can use my profile based on their assigned role.

@orv2-363
Scenario: Navigate to Add User page
    Given the CV Client admin is at the "User Management" page
    When they select "Add User"
    Then they are directed to the "Add User" page

@orv2-363
Scenario: Input new pending user BCeID username
    Given the CV Client admin is at the "Add User" page
    When they input a BCeID username
    And they select "Add"
    Then they see "User Added"
    And they are directed to the "User Management" page
    And the newly added user is displayed as pending

@orv2-363
Scenario: Cancel add new user
    Given the CV Client admin is at the "Add User" page
    When they select "Cancel"
    Then they are directed to the "User Management" page
   
@orv2-363
Scenario: Does not assign new pending user to user group
    Given the CV Client admin is at the "Add User" page
    When they a "User Group" is not assigned
    And they select "Add User"
    Then they see "You must assign a User group"

@orv2-363
Scenario: Default new pending user to user group "Permit Applicant"
    Given the CV Client admin is at the "Add User" page
    When they view the "User Group" assignment list
    Then they see "Permit Applicant" checked

@orv2-363
Scenario: Assign new pending user to one or more user groups
    Given the CV Client admin is at the "Add User" page
    When they assign one or more "User Groups"
    Then they see indication of each assigned role

@orv2-363
Scenario: View user group permissions
    Given the CV Client admin is at the "Add New User" page
    When they select "User Groups and Permissions"
    Then they are directed to the "User Groups and Permission" page
    And they see <function> and <capability> a <Company Administrator> and <Permit Applicant> has permission to use; Y for yes and N for no

    Examples:
      | function                      | capability                                        | Company Administrator |  Permit Applicant | 
      | Manage Vehicles and Inventory | View vehicle inventory                            | Y                     | Y                 | 
      | Manage Vehicles and Inventory | Add vehicle                                       | Y                     | Y                 | 
      | Manage Vehicles and Inventory | Update vehicle                                    | Y                     | Y                 | 
      | Manage Vehicles and Inventory | Remove vehicle                                    | Y                     | Y                 | 
      | Permits                       | View permits dashboard                            | Y                     | Y                 | 
      | Permits                       | View my permits (historical permits)              | Y                     | Y                 | 
      | Permits                       | View list of applications in progress             | Y                     | Y                 | 
      | Permits                       | View individual application in progress - details | Y                     | Y                 | 
      | Permits                       | Edit individual application in progress - details | Y                     | Y                 | 
      | Permits                       | Cancel application in progress                    | Y                     | Y                 | 
      | Permits                       | View list of applications in review               | Y                     | Y                 | 
      | Permits                       | View individual application in review - details   | Y                     | Y                 | 
      | Permits                       | Cancel application in review                      | Y                     | Y                 | 
      | Manage Company Information    | View company information                          | Y                     | Y                 | 
      | Manage Company Information    | Update company information                        | Y                     | N                 | 
      | Manage Company Users          | Add new users                                     | Y                     | N                 | 
      | Manage Company Users          | Update all user information                       | Y                     | N                 | 
      | Manage Company Users          | Remove users                                      | Y                     | N                 | 
      | Manage Company Users          | Deactivate and activate users                     | Y                     | N                 | 
      | Manage My Information         | Update my information                             | Y                     | Y                 | 

Feature: View and manage profile users and roles 
As a CV Client admin I want to view and edit information about users so that I can maintain an accurate inventory of authorized users of my onRouteBC profile.

Background: Users can have the following statuses:
    | Active      |
    | Pending     |
    | Deactivated |

@orv2-480
Scenario: Sort list of users
    Given the CV Client admin is at the "User Management" page
    When they select any of the following column headers:
      | First Name     | 
      | Last Name      | 
      | Email          | 
      | User Group     | 
      | Date Created   | 
      | BCeID Username |
    Then the list is sorted by the selected column header
    And the sort order is the reverse of the previously selected order

@orv2-480 
Scenario: Delete a user 
    Given the CV Client admin is at the "Delete user?" warning
    When they select "Delete"
    Then the user is removed from the database
    And they are directed to the "User Management" page
    And the user is removed from the "User Management" page

@orv2-480 
Scenario: Delete a user warning
    Given the CV Client admin is at the "User Management" page
    When they select "Delete"
    Then they see "Are you sure you want to delete this user? This action cannot be undone." 

@orv2-480 
Scenario: Cancel a user deletion
    Given the CV Client admin is at the "Delete user?" warning
    When they select "Cancel"
    Then they are directed to the "User Management" page

@orv2-480 
Scenario: View onRouteBC profile users
    Given the CV Client admin is at the "User Management" page
    When they view "Active Users" or "Pending Users" or "Deactivated Users"
    Then they see the following headers:
      | First Name   |
      | Last Name    |
      | Email        |
      | User Group   |
      | Date Created |
    But "Pending Users" does not display headers "First Name", "Last Name" or "Email"
    And "Pending Users" displays header "BCeID Username"

@orv2-480 
Scenario: View and edit user "My Information"
    Given the CV Client admin is at the "User Management" page
    When they select "Edit"
    Then they are directed to the "Edit User" page

@orv2-480 
Scenario: Cancel view and edit user "My Information"
    Given the CV Client admin is at the "Edit User" page
    When they select "Cancel"
    Then they are directed to the "User Management" page

@orv2-480 
Scenario: Save edit changes to user "My Information"
    Given the CV Client admin is at the "Edit User" page
    When they select "Save"
    Then they are directed to the "User Management" page
    And they see "Changes Saved" notification