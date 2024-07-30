DRAFT Feature: Review and confirm permit application input

@orv2-1095-7
Rule: Show inputted permit application information

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                             |
       | Company information edit message                              |
       | Company mailing Address of permitee                           |
       | Contact information submitted in Permit Application           |
       | Permit details submitted in Permit Application                |
       | Selected commodities listed with links to the source of truth |
       | Commodity details submitted in Permit Application             |
       | Vehicle information submitted in Permit Application           |
       | Loaded dimensions submitted in the permit application         |
       | Trip details submitted in the permit application              |
       | Application notes if submitted in the permit application      |

@orv2-1095-8
Rule: user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-1095-9
Rule: Indication of vehicle saved to inventory is shown (if save was chosen)

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-1095-10
Rule: The calculated total fee of the permit is shown

 Scenario: Display fee summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for the permit application that includes a <description> and <price>

   Examples:
     | Description          | Price   |
     | Single Trip Oversize | $15.00 |

 Scenario: Fee calculation
     Given a user has completed a Single Trip Permit Application
     When they continue to "Review and Confirm Details" page
     Then the permit fee is calculated as $15

@orv2-1095-11
Rule: The user must complete the attestations

 Scenario: Attestations
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see a list of attestations they are required to check in order to proceed to pay
       | I confirm the information in this application is correct.                          |
       | I confirm I am compliant with the appropriate policy for my selected commodity(s). |
       | I confirm I am the registered owner (or lessee) of the vehicle being permitted.    |

 Scenario: Attestations warning
     Given a user is at the "Review and Confirm Details" page
     When they do not check one or more attestations
     Then they see "Checkbox selection is required"
     And any unselected checkbox is outlined in red

@orv2-1095-12
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
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
Rule: A user can choose to save a permit application

