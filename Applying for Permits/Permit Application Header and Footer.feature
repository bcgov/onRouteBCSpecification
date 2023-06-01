Feature: Display permit application header information
    As a CV Client I want to be able to view a header details so that I can refer to this application in progress 
 
@orv2-552-1
  Scenario: Display application number
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see a uniqe permit application number

@orv2-552-2
  Scenario: Display date created
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see the <date and time> the permit application was created

     Examples:
       | date and time                  |
       | Apr. 15, 2023, 8colon23 am PDT |

@orv2-552-3
  Scenario: Display last updated
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see the <date and time> the permit application was last updated

   Examples:
       | date and time                  |
       | Apr. 15, 2023, 8colon23 am PDT |

@orv2-552-4
  Scenario: Display company information
    Given the CV Client has started a permit application
     When they are at the "Permit Application" page
     Then they see:
       | Company Name            |
       | onRouteBC Client Number |



