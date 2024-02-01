Feature: Staff Manage Applications in Progress
   As a PPC SA or PC I want to view a list of my applications so that I can manage their submission, payment or deletion.

@orv2-1575-3
Rule: Staff can view a list of all applications in progress for a specific company

  Scenario: View list applications do not exist
    Given Staff is at the "Applications in Progress" tab
     When there are no applications in progress for the CV Client
     Then they see "No Records Found" empty state page message

  Scenario: View list applications exist
    Given CV Client has applications in progress
     When Staff are viewing the "Applications in Progress" tab
     Then they see this data about the applications
       | data               | description                                                                                                                       |
       | Application Number | unique application no. generated by onRouteBC                                                                                     |
       | Permit Type        | the name of the permit applied for                                                                                                |
       | VIN                | the first 6 digits of the ViN no. used in the application                                                                         |
       | Vehicle Plate      | the plate no. of the vehicle used in the application                                                                              |
       | Unit #             | the unit no. of the vehicle used in the application                                                                               |
       | Last Updated Date  | the date the permit application was last updated                                                                                  |
       | Permit Start Date  | the start date inputted in the permit application                                                                                 |
       | Applicant          | the first name and last name of the logged in user that started the permit application or the idir username if completed by staff |
     And only staff can see the idir username
     And the default sort order is "Last Updated Date" newest at the top ascending

@orv2-1575-4
Rule: Staff can delete any permit application

  Scenario: Bulk delete applications in progress
    Given Staff is at the "Applications in Progress" tab
     When they select one or more application
     And they choose to delete
     Then the applications are removed from the application in progress list

  Scenario: Delete application in progress
    Given Staff is at the "Applications in Progress" tab
     When they select a permit application
     And they choose to delete
    Then the applications are removed from the application in progress list

@orv2-1575-5
Rule: Staff can edit any application in progress

  Scenario: Open existing Permit Application 
    Given Staff is at the "Applications in Progress" tab 
      And they have application in progress
     When they choose to view an application in progress
     Then they are directed to the selected "Permit Application" page 

