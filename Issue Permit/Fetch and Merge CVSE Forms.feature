Feature: Fetch and merge CVSE forms with the generated permit documents

Rule: CVSE forms choosen in the permit application are fetched from the source of truth and merged with the generated permit document

@orv2-1205-1
  Scenario: Optional CVSE forms
    Given the CV Cient has recieved the issued permit
     When they view the permit 
     Then they see the CVSE forms chosen when they applied for the permit
      And they are attached consecutively beginning at the final page of the permit

@orv2-1205-3
  Scenario: No CVSE optional CVSE forms
    Given the CV Cient has recieved the issued permit
     When they view the permit 
     Then they see the CVSE only mandatory forms required when they applied for the permit
      And they are attached consecutively beginning at the final page of the permit

@orv2-1205-4
  Scenario: Optional and mandatory CVSE forms
    Given the CV Cient has recieved the issued permit
     When they view the permit 
     Then they see the CVSE chosen and mandatory forms required when they applied for the permit
      And they are attached consecutively beginning at the final page of the permit

@orv2-1205-2
  Scenario: View latest CVSE forms in permit PDF
    Given the CV Cient has recieved the issued permit
     When they view the permit 
     Then they see the CVSE forms required when they applied for the permit
      And they are the latest version available from: https://www.cvse.ca/whatsnew.html


