Feature: CV Client Manage Applications in Progress
   As a CV Client I want to view a list of my applications so that I can manage their submission, payment or deletion.

@orv-548-1
Rule: View list of applications in progress

  Scenario: View list applications do not exist
    Given the CV Client is at the "Applications in Progress" tab
     When they do not have applications in progress
     Then they see "No Records Found" empty state page message

  Scenario: View list applications exist
    Given the CV Client has applications in progress
     When they are viewing the "Applications in Progress" tab
     Then they see this data about their applications
       | data                | description                                                                            |
       | Application Number  | unique application no. generateed by onRouteBC                                         |
       | Permit Type         | the name of the permit applied for                                                     |
       | VIN                 | the first 6 digits of the ViN no. used in the application                              |
       | Vehicle Plate       | the plate no. of the vehicle used in the application                                   |
       | Vehicle Unit Number | the unit no. of the vehicle used in the application                                    |
       | Last Updated Date   | the date the permit application was last updated                                       |
       | Permit Start Date   | the start date inputted in the permit application                                      |
       | Applicant           | the first name and last name of the logged in user that started the permit application |
     And the default sort order is "Last Updated Date" newest at the top
     And they only see application they created

@orv-557-1
Rule: Delete Permit Application

  Scenario: Bulk delete applications in progress
    Given the CV Client is at the "Applications in Progress" tab
     When they select one or more application
     And they choose to delete
     Then the applications are removed from the application in progress list
     And remain visible only to staff users

  Scenario: Delete application in progress
    Given the CV Client is at the "Applications in Progress" tab
     When they select a permit application
     And they choose to delete
    Then the applications are removed from the application in progress list
     And remain visible only to staff users

@orv2-685-1
Rule: Edit Application in progress

  Scenario: Open existing Permit Application 
    Given the CV Client is at the "Applications in Progress" tab 
      And they have application in progress
     When they choose to view an application in progress
     Then they are directed to the selected "Permit Application" page 