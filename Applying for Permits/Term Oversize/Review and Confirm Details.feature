Feature: Review and Confirm TROS Details
  
User = CA, PA, SA, PC, CTPO, Trainee

@orv2-1384-1 @orv2-627-1
Rule: a user can see permit application details summary

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see:
       | Please review and confirm warning                             |
       | Company information edit message                              |
       | Company mailing Address of logged in user                     |
       | Contact information submitted in Permit Application           |
       | Permit details submitted in Permit Application                |
       | Selected commodities listed with links to the source of truth |
       | Vehicle information submitted in Permit Application           |

 Scenario: Link to CVSE forms web page
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

 Scenario: Save vehicle indication
     Given a user has chosen to save a vehicle submitted in the permit application to inventory
     And they continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

 Scenario: Display fee summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for each permit application that includes a <description> and <price>
      And a total of each permit applied for???

   Examples:
     | Description          | Price  |
     | Term Oversize Permit | $30.00 |

 Scenario: Attestations
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see a list of attestations they are required to check in order to proceed to pay
       | Confirm that this permit is issued to the registered owner (or lessee) of the vehicle being permitted. |
       | Confirm compliance with the appropriate policy for the selected commodity(s).                          |
       | Confirm the information in this application is correct.                                                |

@orv2-1384-2 @orv2-627-2
Rule: Attestations are mandatory

 Scenario: Attestations warning
     Given a user is at the "Review and Confirm Details" page
     When they do not check one or more attestations
     Then they see "Checkbox selection is required"
     And any unselected checkbox is outlined in red

@orv2-1384-3 @orv2-627-3
Rule: TROS permit fee is calculated

 Scenario: Fee calculation
     Given a user has completed a TROS Permit Application
     When they continue to "Review and Confirm Details" page
     Then the <permit fee> is calculated by <term>
    
  Examples:
    | term | permit fee |
    | 30   | 30         |
    | 60   | 60         |
    | 90   | 90         |
    | 120  | 120        |
    | 150  | 150        |
    | 180  | 180        |
    | 210  | 210        |
    | 240  | 240        |
    | 270  | 270        |
    | 300  | 300        |
    | 330  | 330        |
    | 1y   | 360        |

@orv2-1384-4 @orv2-627-4
Rule: a user can edit the application

 Scenario: Edit Application
     Given a user is at the "Review and Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page 