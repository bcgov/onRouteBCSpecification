Feature: Generate unique permit number
   As staff I need to ensure a unique permit number is generated so that each permit can be identified individually.

Rule: A unique permit number is generated when a permit is saved in onRouteBC

  Scenario Outline: Generate permit number
    Given a user has attempted to complete payment
     When they successfully complete payment
     Then the permit number is generated that contains the <application source><application origin>-<sequence>-<random>
      And they see "Permit <application number> created." notification 
    
     Examples:
     | <application source> | <application origin> | <sequence> | <random> |
     | P                    | 1                    | 82364275   | 175      |

  Scenario: Permit number meta-data source
    Given a permit number is generated
     When the permit number is generated
     Then it is formed using the following rules:
       | element                                                | order | specification |
       | "P" for permit "A" for application                     | 1     | 1 character   |
       | "1" created by PPC or "2" created online by CV Client  | 2     | 1 digit       |
       | a sequence number starting at 00010000 preceded by "-" | 3     | 8 digits      |
       | a random number preceded by "-"                        | 4     | 3 digits      |

