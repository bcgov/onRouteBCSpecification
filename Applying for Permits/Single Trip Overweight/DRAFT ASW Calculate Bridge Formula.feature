@orv2-5275 https://moti-imb.atlassian.net/browse/ORV2-5275
Feature: As a user I want to be able to be able to calculate bridge formula so that I can determine if the total weight of the combination satisfies the Bridge Formula to be permitted on many major routes.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5275
Rule: Calculate button is enabled when all mandatory ASW fields are inputted

  Scenario: all mandatory fields inputted
     When a user has inputted all mandatory ASW fields
     Then the Calculate button is available
      And they see "All fields in Axle Spacing and Weights are required to calculate results."

  Scenario: mandatory fields data missing
    Given a user has inputted some but not all mandatory ASW fields
     When they view the ASW table
     Then the Calculate button is not available
      And they see "All fields in Axle Spacing and Weights are required to calculate results."

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
Rule: Axle unit groups that fail bridge formula are indicated on the ASW table

  Scenario: failed axle group 3
    Given axle group 3 has failed BF
     When the calculated return the results
     Then the user sees axle unit rows 3 and 4 indicated

  Scenario: failed axle group 3 and 4
    Given axle group 3 has failed BF
      And axle group 4 has failed BF
     When the calculated return the results
     Then the user sees axle unit rows 3 and 4 and 5 indicated

@orv2-5275
Rule: Users stay on the application form when calculation on continue has errors 

  Scenario: has errors
    Given a user has inputted all mandatory ASW fields
      And there are calculation errors
     When they choose to continue to review and confirm
     Then they see the calculation results are shown 
      And they cannot continue
      And they remain on the application form

  Scenario: no errors
    Given a user has inputted all mandatory ASW fields
      And there are no calculation errors
     When they choose to continue to review and confirm
     Then they are directed to the "Review and Confirm Details" page
      And the calculation results are shown
     When 
     Then 

@orv2-5275
Rule: Resetting the ASW table restore default field values in the table

  Scenario: tire sizes reset
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then they see that the tire size for all axle units is reset to 279.4 mm

  Scenario: number of axles
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then the number of axles is reset to 1 for all axle units

@orv2-5275
Rule: Resetting the ASW table will remove all inputted ASW data and calculation results

  Scenario: reset asw no calculation
    Given a user has inputted ASW data
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed
      And the WSPD remains

  Scenario: reset asw with calculation
    Given a user has inputted ASW data
      And they have calculated the ASW
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed
      And the WSPD remains

@orv2-5275
Rule: Resetting the AWS table will remove the additional axle units added by the user

  Scenario: reset asw additional axle units
    Given a user has added 
      And additional axle units
     When they choose to reset the ASW table
     Then all additional axle units are removed
      And the ASW table is reset to only show the default power unit axle unit

# Bridge Formula Calculation Results
@orv2-5275
Rule: Indicate result error(s) on ASW table when calculation errors are present

  Scenario: calculation errors present
    Given a user has inputted all mandatory ASW fields
      And there are calculation errors
     When they view the ASW table
     Then they see error indicators on the ASW table
      And they see error messages indicating the nature of the error(s)

Resetting Axle Spacing and Weights will remove all entered data, including any
additional Axle Units you may have added.
Cancel Reset

Default number of axles is one
Header rows grouping parts of the vehicle configuration by section