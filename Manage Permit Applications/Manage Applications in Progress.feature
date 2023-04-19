Feature: View Applications in Progress
   As a CV Client I want to view a list of my applications so that I can manage their submission, payment or deletion.

@orv-672
  Scenario: View list applications do not exist
    Given the CV Client is at the "Applications in Progress" tab
     When they do not have applications in progress
     Then they see "No Records Found" empty state page message

@orv-672
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

@orv-557
  Scenario: Bulk delete applications in progress
    Given the CV Client is at the "Applications in Progress" tab
     When they select one or more application
     And they choose to delete
     Then the aplications are deleted

Feature: Save Permit Application
   As a CV Client I need to save my permit application so that I can complete them at a later date.

@orv-555
  Scenario: In application not saved timeout
    Given the CV Client is at a permit application page and has not saved the application
     When the system timeout is reached
     Then the application is not saved

@orv-555
  Scenario: In application saved timeout
    Given the CV Client is at a permit application page and has saved the application
     When the system timeout is reached
     Then current changes are lost the application remains in its previously saved state  
     
@orv-555
  Scenario: Manual save application
    Given the CV Client is at a permit application page
     When they save the application
     Then they see "Saved to Applications in Progress"
     And changes are saved 
     And the application is displayed in the Applications in Progress list
     And the "Last Updated" timestamp reflects the date and time they saved it

@orv-555
  Scenario: Manual save mandatory fields
    Given the CV Client is at a permit application page
     When they save the application with invalid or missing mandatory fields
     Then current changes are saved 

@orv-555
  Scenario: Save on continue
    Given the CV Client is at a permit application page
     When they choose to continue
     Then the application is saved 
     And they are directed to the "Review and Confirm Details" page

@orv-555
  Scenario: Save on continue invalid mandatory fields
    Given the CV Client is at a permit application page and has invalid or missing mandatory fields
     When they choose to continue
     Then they remain at the permit application page
     And they see the mandatory field warning for invalid or missing mandatory fields


Feature: Edit Application in progress
  Scenario: 
    Given 
     When 
     Then 



