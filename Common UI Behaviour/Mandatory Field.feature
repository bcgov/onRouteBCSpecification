Feature: Mandatory Fields

Rule: Indicate mandatory fields when left empty 
 
  Scenario: empty on continue
    Given a user does not input data into a mandatory field
     When they choose to continue
     Then the mandatory field is indicated

Rule: A User cannot continue past a validation state if a mandtory field is not completed

  Scenario: empty on continue
    Given a user does not input data into a mandatory field
     When they choose to continue
     Then they cannot continue