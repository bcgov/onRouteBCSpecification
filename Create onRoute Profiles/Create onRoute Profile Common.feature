Feature: Common features for profile creation workflows
 These rules apply to all onRouteBC account creation workflows.

User = basic or business

@orv2-481-8, @orv2-3322-10, @orv2-3228
Rule: The navigation bar is not visible to users until the profile has been successfully created

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following steps:
       | steps |
       | welcome to onroutebc - claim profile or not choice |
       | verify profile | 
       | company information |
       | my information |
     Then the navigation bar is not visible

@orv2-481-11, @orv2-3322-11, @orv2-3228
Rule: A user can cancel or step backwards

  Scenario: Cancel
    Given they have chosen to claim a onRouteBC profile
     When they choose to cancel
     Then they are directed to welcome to onRouteBC

  Scenario: Previous
     When they choose to return to a previous page
     Then they are directed to the previous page in the workflow

@orv2-369-9, @orv2-3322-12, @orv2-3228
Rule: contact details are not saved until the workflow is finished

 Scenario: CV Client Business BCeID navigates away from create new onRouteBC profile workflow
     Given they are at "Company Information" or "My Information" in the workflow
     When they navigate away from the page
     Then the onRouteBC account is not created
      And no information is saved

  Scenario: CV Client Business BCeID user added to a company profile first time sign in accept add to onRouteBC profile
      Given the CV Client Business BCeID user is at the invitation welcome page
      When they accept the invitation
      Then they are directed to the "My Information" page in the workflow
      And they are removed from the "Pending User" list of the company that added them
      And they are designated as an "Active User" 

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page





@orv2-907-4, @orv2-3322-13, @orv2-3228
Rule: a new PA user can only view company profile information

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to view their profile
      Then they are directed to company information
       But they cannot edit company information


@orv2-481-10, @orv2-3322-14, @orv2-3228
Rule: upon creating a profile or joining an existing profile a user can view their profile or apply for a permit

 Scenario: choose to apply for permit
     Given the user has completed their profile creation
      When they choose to apply for a permit
      Then they are directed to applications in progress

  Scenario: pa choose to view profile
     When a pa has chosen to view their profile
     Then they are directed to their user details

  Scenario: sa choose to view profile
     When a sa has chosen to view their profile
     Then they are directed to their company information

@orv2-3322-15, @orv2-3228
Rule: contact details are replicated to company primary contact and user details

  Scenario: all contact details have data
    Given the following contacts details have data:
      | contact details             | data           |
      | First Name                  | John           |
      | Last Name                   | Doe            |
      | Email                       | jdoe@email.com |
      | Primary Phone               | 250-555-1234   |
      | Ext                         | 123            |
      | Alternate Phone             | 250-123-555    |
      | Ext                         | 321            |
      | Address (Line 1)            | 123 Nowhere St |
      | Address (Line 2) (optional) | Suite 101      |
      | Country                     | Canada         |
      | Province / State            | BC             |
      | City                        | Vancouver      |
      | Postal / Zip Code           | V8L 13T        |
     When a user finishes created their onRouteBC profile
     Then data is replicated to primary contact and user details as follows:
      | contact details             | company mailing address & company contact details | company primary contacts | user details   |
      | First Name                  |                                                   | John                     | John           |
      | Last Name                   |                                                   | Doe                      | Doe            |
      | Email                       | jdoe@email.com                                    | jdoe@email.com           | jdoe@email.com |
      | Primary Phone               | 250-555-1234                                      | 250-555-1234             | 250-555-1234   |
      | Ext                         | 123                                               | 123                      | 123            |
      | Alternate Phone             |                                                   | 250-123-555              | 250-123-555    |
      | Ext                         |                                                   | 321                      | 321            |
      | Address (Line 1)            | 123 Nowhere St                                    |                          |                |
      | Address (Line 2) (optional) | Suite 101                                         |                          |                |
      | Country                     | Canada                                            | Canada                   | Canada         |
      | Province / State            | BC                                                | BC                       | BC             |
      | City                        | Vancouver                                         | Vancouver                | Vancouver      |
      | Postal / Zip Code           | V8L 13T                                           |                          |                |

@orv2-481-7, @orv2-3322-16, @orv2-3228
Rule: a user can view their onRouteBC Client Number upon successful completion of profile creation

  Scenario: Successfully completed 
     When a user chooses to complete the workflow
     Then they are directed to a success page
      And they see their onRouteBC Client Number
      And they see options to apply for a permit and view their profile

@orv2-481, @orv2-3322-17, @orv2-1637-8, @orv2-3228
Rule: a user can view their onRouteBC Client Number upon successful completion of the profile creation workflow

  Scenario: Successfully completed 
    Given a CV Client has completed "My Information"
     When they choose to complete the workflow
     Then they are directed to a success page
     And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |