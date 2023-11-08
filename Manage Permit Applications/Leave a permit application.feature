Feature: Leave permit application
As a CV Client I want to leave a permit application I am currently editing so that I can return to it at a later time or cancel the application.

  @orv2-847-1
  Scenario: Leave unsaved
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application in onRouteBC
     Then they see "Leave application? You have unsaved changes in your permit application. If you leave all your changes will be lost. This action cannot be undone."

  @orv2-847-2
  Scenario: Leave unsaved discard changes
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application and discard changes
     Then they are directed to the "Permit" page "Applications in Progress" tab
      And the permit application is not saved

  @orv2-847-3
  Scenario: Leave saved
    Given the CV Client is at the "Permit Application" page 
      And has saved
     When they choose to leave the application
     Then they are directed to the "Permit" page "Applications in Progress" tab
      And the permit application is saved    
      And the application is displayed in the "Applications in Progress" list
      And the "Last Updated" timestamp reflects the date and time they last saved???

  @orv2-847-4
  Scenario: Close browser unsaved
    Given the CV Client is at the "Permit Application" page 
      And has not saved
     When they choose to leave the application by a method outside onRoute
     Then the permit application is not saved 

  @orv2-847-5
  Scenario: Close browser saved
    Given the CV Client is at the "Permit Application" page 
      And has saved
     When they choose to leave the application by a method outside onRoute
     Then the permit application data reflects the last save 