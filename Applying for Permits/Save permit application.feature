Feature: Save Permit Application
   As a user I need to save my permit application so that I can complete them at a later date.

@orv-555-1 @orv2-1384- @orv2-685-2 
  Scenario: In application not saved timeout
    Given a user is at a permit application page and has not saved the application
     When the system timeout is reached
     Then the application is not saved

@orv-555-2 @orv2-1384-
  Scenario: In application saved timeout
    Given a user is at a permit application page and has saved the application
     When the system timeout is reached
     Then current changes are lost the application remains in its previously saved state  
     
@orv-555-3 @orv2-1384-
  Scenario: Manual save application
    Given a user is at a permit application page
     When they save the application
     Then they see "Saved to Applications in Progress"
     And changes are saved 
     And the application is displayed in the Applications in Progress list
     And the "Last Updated" timestamp reflects the date and time they saved it

@orv-555-4 @orv2-1384-
  Scenario: Manual save mandatory fields
    Given a user is at a permit application page
     When they save the application with invalid or missing mandatory fields
     Then current changes are saved 
     And they see "Saved to Applications in Progress"

@orv-555-5 @orv2-1384-
  Scenario: Save on continue
    Given a user is at a permit application page
     When they choose to continue
     Then the application is saved 
     And they are directed to the "Review and Confirm Details" page

@orv-555-6 @orv2-1384-
  Scenario: Save on continue invalid mandatory fields
    Given a user is at a permit application page and has invalid or missing mandatory fields
     When they choose to continue
     Then they remain at the permit application page
     And they see the mandatory field warning for invalid or missing mandatory fields