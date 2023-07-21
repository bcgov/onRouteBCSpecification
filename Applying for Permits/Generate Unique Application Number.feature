Feature: Generate unique permit application number
   As staff I need to ensure a unique permit application number id generated so that each application can be identified individually.

Rule: A unique application number is generated when a permit application is saved in onRouteBC

@orv2-835-1
  Scenario: Generate permit application number
    Given the CV Client has entered all require permit application information
     When they choose to save the permit
     Then the permit application number is generated that contains the <application source><application origin>-<sequence>-<random>
      And they see "Application <application number> created." notification 
    
     Examples:
     | <application source> | <application origin> | <sequence> | <random> |
     | A                    | 1                    | 82364275   | 175      |

@orv2-835-2
  Scenario: Generate permit application number
    Given the CV Client has entered all require permit application information
     When they choose to continue to the "Review and Confirm Details" page
     Then the permit application number is generated that contains the <application source><application origin>-<sequence>-<random>
      And they are directed to the "Review and Confirm Details" page
      And they see "Application <application number> created." notification 
    
     Examples:
     | <application source> | <application origin> | <sequence> | <random> |
     | A                    | 1                    | 82364275   | 175      |

@orv2-835-3
  Scenario: Permit application meta-data source
    Given a CV Client has started a permit application
      And they save the permit application
     When the permit application number is generated
     Then the source is used for each <part> of the application number
      And the have a <specification>
      And each <part> is separated by a hyphen

     Examples:
       | source                                                | part               | specification |
       | "A" for permit aplication                             | application source | 1 character   |
       | "1" created by PPC or "2" created online by CV Client | application origin | 1 digit       |
       | a sequence number starting at 00010000                | sequence           | 8 digits      |
       | a random number                                       | random             | 3 digits      |
