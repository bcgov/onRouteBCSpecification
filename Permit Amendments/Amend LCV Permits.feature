Feature: Amend LCV Permits

Staff = SA, PC

@orv2-1490-8
Rule: Original LCV vehicle information is removed when a CV Client is no longer and LCV carrier

  Scenario: LCV carrier
    Given the CV Client is an LCV carrier
      And they used an LCV vehicle in permit A
     When staff amends permit A
     Then they see the LCV vehicle

  Scenario: not an LCV carrier
    Given the CV Client is as an LCV carrier
      And they used an LCV vehicle in permit A
     When they are no longer an LCV carrier
      And staff amends permit A
     Then the LCV vehicle in permit A is not available


