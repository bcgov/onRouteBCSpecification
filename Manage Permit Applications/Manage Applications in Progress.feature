Feature: View Applications in Progress
   As a CV Client I want to view a list of my applications so that I can manage their submission, payment or deletion.

@orv-672-1
  Scenario: View list applications do not exist
    Given the CV Client is at the "Applications in Progress" tab
     When they do not have applications in progress
     Then they see "No Records Found" empty state page message

@orv-672-2
  Scenario: View list applications exist
    Given the CV Client has applications in progress
     When they are viewing the "Applications in Progress" tab
     Then they see this data about their applications
       | Application Number  |
       | Permit Type         |
       | VIN                 |
       | Vehicle Plate       |
       | Vehicle Unit Number |
       | Last Updated Date   |
       | Permit Start Date   |
     And the default sort order is "Last Updated Date" newest at the top
     And they only see application they created

Feature: Delete Permit Application
   As a CV Client I need to delete permit applications I no longer need so that I can maintain my permit applications list.

@orv-557-1
  Scenario: Bulk delete applications in progress
    Given the CV Client is at the "Applications in Progress" tab
     When they select one or more application
     And they choose to delete
     Then the applications are deleted

@orv-557-2
  Scenario: Delete application in progress
    Given the CV Client is at the "Applications in Progress" tab
     When they select a permit application
     And they choose to delete
     Then the application is deleted

Feature: Save Permit Application
   As a CV Client I need to save my permit application so that I can complete them at a later date.

@orv-555-1
  Scenario: In application not saved timeout
    Given the CV Client is at a permit application page and has not saved the application
     When the system timeout is reached
     Then the application is not saved

@orv-555-2
  Scenario: In application saved timeout
    Given the CV Client is at a permit application page and has saved the application
     When the system timeout is reached
     Then current changes are lost the application remains in its previously saved state  
     
@orv-555-3
  Scenario: Manual save application
    Given the CV Client is at a permit application page
     When they save the application
     Then they see "Saved to Applications in Progress"
     And changes are saved 
     And the application is displayed in the Applications in Progress list
     And the "Last Updated" timestamp reflects the date and time they saved it

@orv-555-4
  Scenario: Manual save mandatory fields
    Given the CV Client is at a permit application page
     When they save the application with invalid or missing mandatory fields
     Then current changes are saved 
     And they see "Saved to Applications in Progress"

@orv-555-5
  Scenario: Save on continue
    Given the CV Client is at a permit application page
     When they choose to continue
     Then the application is saved 
     And they are directed to the "Review and Confirm Details" page

@orv-555-6
  Scenario: Save on continue invalid mandatory fields
    Given the CV Client is at a permit application page and has invalid or missing mandatory fields
     When they choose to continue
     Then they remain at the permit application page
     And they see the mandatory field warning for invalid or missing mandatory fields

Feature: Edit Application in progress
   As a CV Client I need to be able to edit a permit application before I submit it so that I can have the flexibility to submit when it is ready.

@orv2-685-1
  Scenario: Open existing Permit Application 
    Given the CV Client is at the "Applications in Progress" tab 
      And they have application in progress
     When they choose to view an application in progress
     Then they are directed to the selected "Permit Application" page 

Feature: Leave permit application
As a CV Client I want to leave a permit application I am currently editing so that I can return to it at a later time or cancel the application.

  @orv2-687-1
  Scenario: Leave unsaved
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application in onRouteBC
     Then they see "Leave application? You have unsaved changes in your permit application. If you leave all your changes will be lost. This action cannot be undone."

  @orv2-687-2
  Scenario: Leave unsaved discard changes
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application and discard changes
     Then they are directed to the "Permit" page "Applications in Progress" tab
      And the permit application is not saved

  @orv2-687-3
  Scenario: Leave saved
    Given the CV Client is at the "Permit Application" page 
      And has saved
     When they choose to leave the application
     Then they are directed to the "Permit" page "Applications in Progress" tab
      And the permit application is saved    
      And the application is displayed in the "Applications in Progress" list
      And the "Last Updated" timestamp reflects the date and time they last saved???

  @orv2-687-4
  Scenario: Close browser unsaved
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application by a method outside onRoute
     Then the permit application is not saved 

  @orv2-687-5
  Scenario: Close browser saved
    Given the CV Client is at the "Permit Application" page 
      And has saved
     When they choose to leave the application by a method outside onRoute
     Then the permit application data reflects the last save 