Feature: Manage LCV Applications in Progress

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-1490-7
Rule: Original LCV vehicle information is removed when a CV Client is no longer and LCV carrier

  Scenario: LCV carrier
    Given the CV Client is an LCV carrier
      And they used an LCV vehicle in application A
     When a user edits application A
     Then they see the LCV vehicle

  Scenario: not an LCV carrier
    Given the CV Client is as an LCV carrier
      And they used an LCV vehicle in application A
     When they are no longer an LCV carrier
      And a user edits application A
     Then the LCV vehicle in application A is not available


