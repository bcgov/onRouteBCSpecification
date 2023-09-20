
Feature: "Review and Confirm Details"
   As a PPC SA or PC I need to be able review the information I submitted in the amend permit application so that I can ensure it is accurate before completing.


Scenario: Display amend permit application details summary
    Given a PPC SA or PC has continued from the "Permit Application" page
    When they arrive at the "Review and Confirm Details" page
    Then they see permit applicaton header and footer information
    And they see:
      | Please review and confirm warning                             |
      | Company information edit message                              |
      | Company mailing Address of amending permit                     |
      | Contact information of amending permit           |
      | Permit details submitted in Permit Application                |
      | Selected commodities listed with links to the source of truth |
      | Vehicle information submitted in Permit Application           |


Scenario: Display permit application details summary
    Given a PPC SA or PC has continued from the "Permit Application" page
    When they select a "Conditions" link
    Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html


Scenario: Save vehicle indication
    Given a PPC SA or PC has choosen to save a vehicle submitted in the permit application to inventory
    And they continued from the "Permit Application" page
    When they arrive at the "Review and Confirm Details" page
    Then they see "This vehicle has been added/updated to your Vehicle Inventory."


Scenario: Display fee summary
    Given a PPC SA or PC has continued from the "Permit Application" page
    When they arrive at the "Review and Confirm Details" page
    Then they see permit applicaton fee for each permit application that includes a <description> and <price>
     And a total of each permit applied for???

Examples:
  | Description          | Price  |
  | Term Oversize Permit | $30.00 |


Scenario: Fee calculation
    Given a PPC SA or PC has completed a TROS Permit Application
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


Scenario: Edit Application
    Given a PPC SA or PC is at the "Review abd Confirm Details" page
    When they choose to edit the application
    Then they are directed to the "Permit Application" page


Scenario: Clicking Continue in the "TROs Permit Application" form.
    Given The user has filled all mandartory fields in "Application Details", and "Vehicle Details"
    When there are no error notifcation in the application
    Then the user is brought to the "Permit Review" Screen
    And the appliction is saved to "Applications in Progress"


Scenario: Clicking Continue in the "TROs Permit Application" form.
    Given The user has not filled all mandartory fields in "Application Details", and "Vehicle Details"
    And there are are error notifcations in the application
    Then the user user cannont continue to the "Permit Review" screen and the error notifications for each field remain highlighted in Red until resolved.