@orv2-5275 https://moti-imb.atlassian.net/browse/ORV2-5275
Feature: As a user I want to be able to be able to calculate bridge formula so that I can determine if the total weight of the combination satisfies the Bridge Formula to be permitted on many major routes.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5275
Rule: Calculate button is enabled when all mandatory ASW fields are inputted

  Scenario: all mandatory fields inputted
     When a user has inputted all mandatory ASW fields
     Then the Calculate button is available

@orv2-5275
Rule: Users must input all mandatory ASW fields before calculation is possible either manually or when attempting to continue to review and confirm

  Scenario: new vehicle added
    Given a user has completed a calculation
     When they add a new vehicle
     Then the ASW is updated to include the new axle units
      And the Calculate button is not available

@orv2-5275
Rule: Users may optionally initiate manual calculation of the ASW

  Scenario: manual calculation partial input
    Given a user has inputted some mandatory ASW fields
     When they choose to calculate
     Then they see "All fields in Axle Spacing and Weights are required to calculate results."
      And they cannot continue

  Scenario: manual calculation all inputted
    Given a user has inputted all mandatory ASW fields
     When they choose to calculate
     Then they see the calculation results are shown 
      And they can continue
  
@orv2-5275
Rule: The ASW is automatically calculated when a user attempts to continue to review and confirm if all mandatory ASW fields are inputted

  Scenario: continue to review and confirm partial input
    Given a user has inputted some mandatory ASW fields
     When they choose to continue to review and confirm
     Then they see "All fields in Axle Spacing and Weights are required to calculate results."
      And they cannot continue

  Scenario: continue to review and confirm all inputted no errors
    Given a user has inputted all mandatory ASW fields
      And there are no calculation errors
     When they choose to continue to review and confirm
     Then they are directed to the "Review and Confirm Details" page
      And the calculation results are shown 

  Scenario: continue to review and confirm all inputted with errors
    Given a user has inputted all mandatory ASW fields
      And there are calculation errors
     When they choose to continue to review and confirm
     Then the calculation results shown
      And they cannot continue

@orv2-5275
Rule: Users stay on the application form when calculation on continue has errors 

