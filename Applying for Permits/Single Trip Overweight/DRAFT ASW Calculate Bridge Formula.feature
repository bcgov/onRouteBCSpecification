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

@orv2-5275
Rule: Resetting the ASW table restore default field values

  Scenario: tire sizes reset
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then they see that the tire size for all axle units is reset to 279.4 mm

  Scenario: number of axles
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then the number of axles is reset to 1 for all axle units

@orv2-5275
Rule: 
# Bridge Formula Calculation Results
@orv2-
Rule: Indicate result error(s) on ASW

@orv2-
Rule: Calculation results are shown on review and confirm details page

# ASW Table Updates
@orv2-
Rule: Users may optionally reset the ASW table to remove all inputted ASW data and calculation results

  Scenario: reset asw no calculation
    Given a user has inputted ASW data
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed
      But the inputted power unit and trailer(s) axle unit rows remain
      And the WSPD remains

  Scenario: reset asw with calculation
    Given a user has inputted ASW data
      And they have calculated the ASW
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed
      But the inputted power unit and trailer(s) axle unit rows remain
      And the WSPD remains

Default number of axles is one
Header rows grouping parts of the vehicle configuration by section