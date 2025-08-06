
Feature: "Review and Confirm Details"
   As a PPC SA or PC I need to be able review the information I submitted in the amend permit application so that I can ensure it is accurate before completing.

staff = PC, SA, TRAIN, CTPO
CV Client = CA, PA

Note: Term Oversize (TROS) amending permit applications share rules and scenarios with new applications (e.g., mandatory fields, province/sate error) and have common amend permit application features (e.g., reason for amendment, revision history). Only unique amending TROS 
permit application rules are included in this feature file.

@orv2-938-25
Rule: staff must complete all mandatory fields

@orv2-938-26
Rule: Show completed amending permit application information

 Scenario: Display amend permit application details summary
     Given a PPC SA or PC has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit application header and footer information
     And they see:
       | Please review and confirm warning                             |
       | Company information edit message                              |
       | Company mailing Address of amending permit application        |
       | Contact information of amending permit application            |
       | Permit details of the amending permit application             |
       | Selected commodities listed with links to the source of truth |
       | Vehicle information of the amending permit application        |

  Scenario: Indicate change made
    Given a PPC staff is at the "Review and Confirm Details" page
     When they review their updates made
     Then the information updated is indicated as "Changed"

 Scenario: Display permit application details summary
     Given a PPC SA or PC has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

 Scenario: Save vehicle indication
     Given a PPC SA or PC has choosen to save a vehicle submitted in the permit application to inventory
     And they continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-938-27
Rule: Show amending permit application fee

 Scenario: Display fee summary
     Given a PPC SA or PC has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for each permit application that includes a <description> and <price>

 Examples:
   | Description          | Price  |
   | Term Oversize Permit | -$30.00 |

 Scenario: Fee delta calculation
     Given a PPC SA or PC has shortened the duration of a TROS permit
     When they continue to "Review and Confirm Details" page
     Then the amending permit application <fee> is the <current fee> minus the <total term reduction>
    
 Examples:
   | current fee | total term reduction | fee |
   | 120         | 30                   | 90  |
   | 60          | 30                   | 30  |
   | 90          | 60                   | 30  |
   | 360         | 270                  | 90  |

@orv2-938-28  
Rule: staff must complete attestations 

@orv2-938-29
Rule: staff can edit an active amending permit application



