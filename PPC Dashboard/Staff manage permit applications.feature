Feature Staff manage permit applications in progress

Rule: View a list of permit applications
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
        | Applicant           | the idir username of the logged in user that started the permit application |
      And the default sort order is "Last Updated Date" newest at the top
      And they only see application they created