Feature: CV Client common features for profile creation workflows
 These rules apply to all onRouteBC account creation workflows.

User = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA

@orv2-481-11, @orv2-3322-11, @orv2-3228
Rule: A user can cancel or return to a previous page

  Scenario: Cancel
     When they choose to cancel
     Then they are directed to welcome to onRouteBC

  Scenario: Previous
     When a user chooses to return to a previous page
     Then they are directed to the previous page in the workflow

@orv2-369-9, @orv2-3322-12, @orv2-3228
Rule: contact details are not saved until the workflow is finished

 Scenario: user navigates away from create new onRouteBC profile workflow
     Given they are at "Company Information" or "My Information" in the workflow
     When they navigate away from the page
     Then the onRouteBC account is not created
      And no information is saved

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
     When a user finishes creating their onRouteBC profile
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

@orv2-481, @orv2-3322-17, @orv2-1637-8, @orv2-3228
Rule: a user can view their onRouteBC Client Number upon successful completion of the profile creation workflow

  Scenario: Successfully completed 
     When they choose to complete the workflow
     Then they are directed to a success page
     And they see the following:
        | their onRouteBC Client No.   |
        | option to apply for a permit |
        | option to view their profile |