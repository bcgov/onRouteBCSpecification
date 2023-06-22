Feature: Generate unique permit application number
   As staff I need to ensure a unique permit application number id generated so that each application can be identified individually.

Rule: 

@orv2-835-1
  Scenario: Generate permit application number
    Given the CV Client has entered all require permit application information
     When they choose to save the permit or continue to the "Review and Confirm Details" page
     Then the permit application number is generated that contains the <application source><application origin>-<sequence>-<random>
      And 
  
     Examples:
     | <application source> | <application origin> | <sequence> | <random> |
     | A                    | 1                    | 82364275   | 175      |

@orv2-835-2
  Scenario: Permit application meta-data definition
    Given 
     When 
     Then 

@orv2-835-3
  Scenario: 
    Given 
     When 
     Then 