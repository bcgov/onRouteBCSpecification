Feature: CV Client review and confirm permit details
   As a CV Client I need to be able review the information I submitted in the permit application so that I can ensure it is accurate before purchase.

CV Client = CA, PA

@orv2-1095-7
Rule: Show CV Client submitted permit application information

 Scenario: Display permit application details summary
     Given a CV Client has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                             |
       | Company information edit message                              |
       | Company mailing Address of logged in user                     |
       | Contact information submitted in Permit Application           |
       | Permit details submitted in Permit Application                |
       | Selected commodities listed with links to the source of truth |
       | Vehicle information submitted in Permit Application           |

@orv2-1095-8
Rule: CV Client can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a CV Client has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-1095-9
Rule: Indication of vehicle saved to inventory is shown (if save was chosen)

 Scenario: Save vehicle indication
     Given a CV Client chose to save a vehicle submitted in the permit application to inventory
     And they continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-1095-10
Rule: The calculated total fee of the permit is shown

 Scenario: Display fee summary
     Given a CV Client has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for each permit application that includes a <description> and <price>

   Examples:
     | Description          | Price  |
     | Term Oversize Permit | $30.00 |


 Scenario: Fee calculation
     Given a CV Client has completed a TROS Permit Application
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

@orv2-1095-11
Rule: The CV Client must complete the attestations

 Scenario: Attestations
     Given a CV Client has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see a list of attestations they are required to check in order to proceed to pay
       | I confirm the information in this application is correct.                          |
       | I confirm I am compliant with the appropriate policy for my selected commodity(s). |
       | I confirm I am the registered owner (or lessee) of the vehicle being permitted.    |

 Scenario: Attestations warning
     Given a CV Client is at the "Review and Confirm Details" page
     When they do not check one or more attestations
     Then they see "Checkbox selection is required"
     And any unselected checkbox is outlined in red

@orv2-1095-12
Rule: A CV Client can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a CV Client is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page

@orv2-1095-13
Rule: A permit application is saved on continue to "Review and Confirm Details"

 Scenario: Saved on continue
     Given The user has filled all mandatory fields at "Permit Application"
     When they choose to continue
     Then the user is directed to the "Review and Confirm Details" page
     And the application is saved to "Applications in Progress"

@orv2-1095-14
Rule: A CV Client can choose to save a permit application

 Scenario: Manual save
     Given The user has filled all mandatory fields at "Permit Application"
     When they choose to save
     Then the application is saved to "Applications in Progress"

