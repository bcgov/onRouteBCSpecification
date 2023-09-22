
Feature: "Review and Confirm Details"
   As a PPC SA or PC I need to be able review the information I submitted in the amend permit application so that I can ensure it is accurate before completing.

Rule: PPC SA and PC must complete all mandatory fields

Scenario: Amending permit application form complete
    Given PPC Sa or PC has filled all mandatory fields in the amending permit application
    When there are no error notifications in the amending permit application
     And they choose to proceed to review and confirm details
    Then they are directed to review and confirm details page


Scenario: Amending permit application form incomplete
    Given PPC SA or PC has not filled all mandatory fields in the amending permit application
      And there are are error notifications in the amending permit application
      And they choose to proceed to review and confirm details
     Then they cannot continue 
      And they see "This is a required field"
      And incomplete mandatory fields indicated

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

Rule: Show amending permit application fee

Scenario: Display fee summary
    Given a PPC SA or PC has continued from the "Permit Application" page
    When they arrive at the "Review and Confirm Details" page
    Then they see permit applicaton fee for each permit application that includes a <description> and <price>

Examples:
  | Description          | Price  |
  | Term Oversize Permit | $30.00 |


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
  
Rule: PPC SA or PC must complete attestations 

Scenario: Attestations
    Given a PPC SA or PC has continued from the "Permit Application" page
    When they arrive at the "Review and Confirm Details" page
    Then they see a list of attestations they are required to check in order to proceed to pay
      | I confirm the information in this application is correct.                          |
      | I confirm I am compliant with the appropriate policy for my selected commodity(s). |
      | I confirm I am the registered owner (or lessee) of the vehicle being permitted.    |


Scenario: Attestations warning
    Given a PPC SA or PC is at the "Review and Confirm Details" page
    When they do not check one or more attestations
    Then they see "Checkbox selection is required"
    And any unselected checkbox is outlined in red

Rule: PPC SA or PC can edit an active amending permit application

Scenario: Edit Application
    Given a PPC SA or PC is at the "Review abd Confirm Details" page
    When they choose to edit the amending permit application
    Then they are directed to the amending permit application page


