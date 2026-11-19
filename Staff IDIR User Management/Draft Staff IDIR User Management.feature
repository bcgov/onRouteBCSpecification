@orv2- https://moti-imb.atlassian.net/browse/ORV2-
Feature: As a system administrator, I need to manage IDIR users in onRoute so that user roles and access are properly maintained

Users: SA

# Authorized IDIR User Management Users
 Rule: IDIR user management is is shown only to SA users on the home page

  Scenario: IDIR user management visibility for SA users
    Given I am logged in as a SA
     When I am on the home page
     Then I see the IDIR user management option

  Scenario: IDIR user management not visible for non-SA users
    Given I am logged in as a non-SA user
     When I am on the home page
     Then I do not see the IDIR user management option

 Rule: Only SA can manage IDIR users in onRoute

  Scenario: Only SA can manage IDIR users
    Given I am logged in as a SA
     When I navigate to the IDIR user management page
     Then I have access to manage IDIR users

  Scenario: Non-SA cannot manage IDIR users
    Given I am logged in as a non-SA user
     When I navigate to the IDIR user management page
     Then I do not have access to manage IDIR users

# Add New User as Pending
 Rule: SA can add new IDIR user

  Scenario: no input choose add new user
    Given I am logged in as a SA
     When I navigate to the IDIR user management page
      And I choose to add a new user without providing any input
     Then I see an error indicating that input is required

  Scenario: add new user with valid input
    Given I am logged in as a SA
     When I navigate to the IDIR user management page
      And I choose to add a new user with valid input
     Then the add user detail modal is displayed

 Rule: The add user detail modal displays the inputted IDIR username, available user group options and the options to cancel or add the user

  Scenario: cancel adding a new user
    Given I am at the add user detail modal
     When I cancel the add user detail modal
     Then I am directed back to the IDIR user management page
      And I do not see the new user added to the list
      But I still see the inputted user name

  Scenario: add new user with missing user group
    Given I am logged in as a SA
     When I navigate to the IDIR user management page
      And I choose to add a new user with a valid IDIR username but do not select a user group
     Then I see an error indicating that a user group must be selected

 Rule: Only one user group can be selected when adding a new IDIR user

  Scenario: complete add new user
    Given I am logged in as a SA
      And I choose to add a new user with valid input
      And I choose a user group
     When I confirm the addition of the new user
     Then I am directed to the IDIR user management page
      And I see the newly added user in the list

 Rule: Newly added users are displayed in the IDIR user management list with their assigned user group and status of pending

  Scenario: newly added user is displayed in the list
    Given I have added a new user "JDOE" and selected user group "PC"
     When I view the IDIR user management list
     Then I see the newly added user with the following details:
       | IDIR username | First Name    | Last Name     | User group | Status  |
       | JDOE          | Not Available | Not Available | PC         | Pending |

 Rule: A history record is created when a new user is added

  Scenario: confirm addition of a new user
    Given I have added a new user
     When I view the history records
     Then I see a history record with the following details:
       | Date/Time           | Time when the pending user is added as MMMM DD, YYYY hh:mm am/pm PCT |
       | IDIR username       | IDIR username of the newly added user                                     |
       | Added by            | IDIR username of the SA that added the user                               |
       | Assigned User Group | User group assigned to the newly added user                               |

# Remove Pending User
 Rule: SA can remove a only pending users

  Scenario: remove a pending user warning
    Given I have added a new user "JDOE" and selected user group "PC"
      And I am at the detail modal for the pending user "JDOE"
     When I choose to remove the pending user "JDOE"
     Then I see a warning indicating that the pending user "JDOE" will be removed
      And I have the option to confirm or cancel the removal

  Scenario: confirm removal of a pending user
    Given I have added a new user "JDOE" and selected user group "PC"
      And I am at the detail modal for the pending user "JDOE"
     When I choose to remove the pending user "JDOE"
      And I confirm the removal
     Then I am directed back to the IDIR user management page
      And I do not see the user "JDOE" in the list

# Post IDIR user login
 Rule: Pending IDIR users that login to onRouteBC become active users

  Scenario: pending user becomes active after login
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in pending status
     When the user "JDOE" logs in to onRouteBC
     Then the status of the user "JDOE" is updated to active in the IDIR user management list

 Rule: A history record is created whenever a new user logs in for the first time

  Scenario: history record is created for first login
    Given I have added a new user
     When the user logs in to onRouteBC for the first time
     Then I see a history record with the following details:
       | Date/Time                             | Time when the pending user logged in as MMMM DD, YYYY hh:mm am/pm PCT |
       | IDIR username  logged in to onRouteBC | IDIR username with static message "logged in to onRouteBC"            |
      

# Activate Existing User
 Rule: Only deactivated users can be activated

  Scenario: activate a deactivated user
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in deactivated status
     When I choose to activate the user "JDOE"
     Then I am directed back to the IDIR user management page
      And the status of the user "JDOE" is updated to active in the IDIR user management list

# Deactivate Existing User
 Rule: Only active users can be deactivated

  Scenario: deactivate an active user
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in active status
     When I choose to deactivate the user "JDOE"
     Then I am directed back to the IDIR user management page
      And the status of the user "JDOE" is updated to deactivated in the IDIR user management list

 Rule: SA's see a deactivate user info message on the user detail modal for active users

  Scenario: view info message for an active user
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in active status
     When I choose to view the detail modal for the active user "JDOE"
     Then I see an info message indicating the user can be deactivated

# Edit User Role
 Rule: All users statuses, including pending, active, and deactivated, can have their roles edited

# View User Details
 Rule: SA can choose to view the detail modal for a pending user

  Scenario: view detail modal for a pending user
    Given I have added a new user "JDOE" and selected user group "PC"
     When I choose to view the detail modal for the pending user "JDOE"
     Then the detail modal is displayed with the following information:
       | IDIR username | First Name    | Last Name     | User group | Status  |
       | JDOE          | Not Available | Not Available | PC         | Pending |

 Rule: Active IDIR users first name and last name are displayed in the IDIR user management list

  Scenario: active user displays first and last name
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in active status
     When I view the IDIR user management list
     Then I see the first and last name of the user "JDOE" displayed correctly

 Rule: Active users detail modal displays first and last name, user group, and status correctly

  Scenario: view detail modal for an active user
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in active status
     When I choose to view the detail modal for the active user "JDOE"
     Then the detail modal is displayed with the following information:
       | IDIR username | First Name | Last Name | User group | Status |
       | JDOE          | John       | Doe       | PC         | Active |

# Sorting user list
 Rule: Newest users are displayed at the top of the IDIR user management list

  Scenario: newest users appear at the top
    Given I have added a new user "JDOE" and selected user group "PC"
      And I have added another new user "ASMIT" and selected user group "PC"
     When I view the IDIR user management list
     Then I see the user "ASMIT" displayed above the user "JDOE"

 Rule: Users can be sorted by IDIR username, user group, and status

  Scenario: sort users by IDIR username
    Given I have added a new user "JDOE" and selected user group "PC"
      And I have added another new user "ASMIT" and selected user group "PC"
     When I sort the IDIR user management list by IDIR username
     Then I see the user "ASMIT" displayed above the user "JDOE"

  Scenario: sort users by user group
    Given I have added a new user "JDOE" and selected user group "PC"
      And I have added another new user "ASMIT" and selected user group "SA"
     When I sort the IDIR user management list by user group
     Then I see the user "ASMIT" displayed above the user "JDOE"

  Scenario: sort users by status
    Given I have added a new user "JDOE" and selected user group "PC"
      And the user "JDOE" is in active status
      And I have added another new user "ASMIT" and selected user group "PC"
      And the user "ASMIT" is in pending status
     When I sort the IDIR user management list by status
     Then I see the user "ASMIT" displayed above the user "JDOE"




# Notes:
 - Home on sticky side bar shows idir user management for SA's only
- Only SA can add/deactivate/activate users in onRoute
- Deactivate would continue to show users in the list
- If a SA accidentally removes their SA role in onRoute we submit a ticket to make a backend change or have another SA edit their role or activation status
	- Rebecca, Courtenay, Barry 
- User already exists scenario
	- IDIR user already exists in onRoute
	- IDIR username
	- Status
	- Inline text under the field "User already exists"
- Pending stage > log in > permanent stage 
- Endless scroll on the table
- Sort table columns
	- Newest to the top
	- User Group 
	- Status
	- IDIR username
- Pending stage
	- Actions
		- Remove invite
- Change user role while a user is logged in
	- Access change is immediate but they would still see elements they may not have access to #devsync
- Data elements:
	- IDIR for user that created the user, made a change (activate, deactivate, role change)
	- IDIR for new or existing user being added or edited - has to be exact
	- First and Last Name of the new user - pulled from IDIR and shown
	- Role - New
		- Staff Roles
		- SA
		- PC
		- CTPO
		- FIN
		- EO
		- HQA
		- Trainee ??
	- Status = Active/Deactivated
- SA can add users to any of the roles When editing a user, First and Last name is not available when adding a user it is populated after the first log on. 
- When SA adds a user, they also assign the role in onRoute for the user
- SA can edit assigned roles
- No default user type
	- Sc1 attempt to add but did not select a user
		- You must assign a user group
		- Indicate TBD
- Don't enter an idir attempt to add
	- IDIR username required
	- Indicate the field
- IDIR deactivated by the Province
	- Activated in onRouteBC
		- User attempts to log in
		- No access by IDIR
- IDIR active by Province
	- Deactivated in onRouteBC
		- User attempts to log in
		- Pass IDIR
		- Arrive at unauthorized page
- History of changes chrono order descending
	- user added
	- activated
	- deactivated
	- role change
	- first time log into onRoute 
	- endless scroll
	- Details and History tabs always visible
	- scroll bar in the modal - purple
- Populate the the front end with the existing list of active users and deactivated users
- History button on users tab?
- Renu to pull a list out of onRouteBC of existing users and roles
- Added by: Migrated - how did we handle this from for the BCeID migration? Treat it the same way.
- Update the current list of onRouteBC users status when we implement this feature so some will have the pending
- MVP drop the history table?
- Remove pending user store change in history table
	- Removed and readded?
		- Include the previous add and removal
			- No history for pending
	- Cancel remove directs to modal
	- 
- IDIR user added to onRoute
	- IDIR username changes before log  into onRouteBC
		- Pass IDIR fail at onRoute
		- Need to test this workflow
			- We get the GUID on the original log on
	- Post logon change IDIR
		- Pass both IDIR and onRoute
		- History table is updated to show IDIR username change
- Invalid IDIR added it gets added to the list