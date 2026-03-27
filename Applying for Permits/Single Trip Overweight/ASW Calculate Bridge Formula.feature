@orv2-5275 https://moti-imb.atlassian.net/browse/ORV2-5275
Feature: As a user I want to be able to be able to calculate bridge formula so that I can determine if the total weight of the combination satisfies the Bridge Formula to be permitted on many major routes.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

# ASW Table Rules:
@orv2-5275-1
Rule: Calculate button is enabled when all ASW fields are inputted

  Scenario: all mandatory fields inputted
     When a user has inputted all mandatory ASW fields
     Then the Calculate button is available
      And they see "All fields in Axle Spacing and Weights are required to calculate results."

  Scenario: mandatory fields data missing
    Given a user has inputted some but not all mandatory ASW fields
     When they view the ASW table
     Then the Calculate button is not available
      And they see "All fields in Axle Spacing and Weights are required to calculate results."

@orv2-5275-2
Rule: Users must input all ASW fields before calculation is possible either manually or when attempting to continue to review and confirm

  Scenario: new vehicle added
    Given a user has completed a calculation
     When they add a new vehicle
     Then the ASW is updated to include the new axle units
      And the Calculate button is not available

@orv2-5275-3
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
  
@orv2-5275-4
Rule: The ASW is automatically calculated when a user attempts to continue to review and confirm if all ASW fields are inputted

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

@orv2-5275-5
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

@orv2-5275-6
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

@orv2-5275-7
Rule: Users are shown a warning message when they attempt to reset the ASW table

  Scenario: choose reset
    Given a user has inputted ASW data
     When they choose to reset the ASW table
     Then they see: "Reset Axle Spacing and Weights Resetting Axle Spacing and Weights will remove all entered data, including any additional Axle Units you may have added." 
      And they have the option to cancel or confirm the reset

  Scenario: cancel reset
     When a user chooses to cancel the reset of the ASW table
     Then they see the ASW table with all inputted data still present

  Scenario: confirm reset
     When a user chooses to confirm the reset of the ASW table
     Then they see the ASW table with all data removed and reset to default values
      And any calculation results are removed
      And any additional axle units added are removed

@orv2-5275-8
Rule: Resetting the ASW table restore default field values in the table

  Scenario: tire sizes reset
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then they see that the tire size for all axle units is reset to 279.4 mm

  Scenario: number of axles
    Given a user has added a power unit and entered tire sizes for the axle units
     When they reset the ASW table
     Then the number of axles is reset to 1 for all axle units

@orv2-5275-9
Rule: Resetting the ASW table will remove all inputted ASW data and calculation results

  Scenario: reset asw no calculation
    Given a user has inputted ASW data
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed

  Scenario: reset asw with calculation
    Given a user has inputted ASW data
      And they have calculated the ASW
     When they choose to reset the ASW table
     Then all inputted ASW data is removed
      And any calculation results are removed

@orv2-5275-10
Rule: Resetting the AWS table will remove the additional axle units added by the user

  Scenario: reset asw additional axle units
    Given a user has added 
      And additional axle units
     When they choose to reset the ASW table
     Then all additional axle units are removed
      And the ASW table is reset to only show the default power unit axle unit

@orv2-5275-11
Rule: Only numbers can be inputted into the ASW table input fields

  Scenario: "ten" inputted 
     When a user inputs "ten" input number of axles for axle unit 1
     Then number of axles for axle unit 1 is empty

@orv2-5275-12
Rule: Interaxle spacing and Axle Spread have two decimal precision

  Scenario: input whole number
    Given a user has inputted 10 in axle spread for axle unit 2
     When they leave the field
     Then axle spread for axle unit 2 is 10.00

  Scenario: input single decimal place
    Given a user has inputted 5.5 in axle spread for axle unit 2
     When they leave the field
     Then axle spread for axle unit 2 is 5.50

@orv2-5275-13
Rule: No. of Axles, No. of Wheels and Axle Unit Weight are whole numbers

  Scenario: input a decimal number round up
    Given a user has inputted 5000.5 in axle unit weight for axle unit 1
     When they leave the field
     Then axle unit weight for axle unit 1 is 5001

  Scenario: input a decimal number round down
    Given a user has inputted 5000.4 in axle unit weight for axle unit 1
     When they leave the field
     Then axle unit weight for axle unit 1 is 5000
# Bridge Formula Calculation Rules:
@orv2-5275-14
Rule: 0, -x and empty are invalid input

  Scenario: 0 inputted
    Given a user input 0 in number of axles for axle unit 2
     When they choose to calculate 
     Then they see "All fields in Axle Spacing and Weights are required to calculate results."
      And number of axles for axle unit 2 is indicated

  Scenario: all empty
    Given a user does not input any data 
     When they choose to calculate 
     Then they see "All fields in Axle Spacing and Weights are required to calculate results."
      And all empty fields are indicated

@orv2-5275-15
Rule: Calculate bridge calculation wheelbase (BCW) for each axle group

  Scenario: axle group 1
    Given there are 2 axle units 
      And axle unit 1 has 1 axle
      And interaxle spacing is 4.90(m)
      And axle unit 2 axle spread is 1.50(m)
     When a user chooses to calculate
     Then the BCW for axle group 1 is 640(cm)

@orv2-5275-16
Rule: Calculate bridge formula (BF) for each axle group as 30 x (BCW) (cm) + 18,000 kg = x (Maximum weight allowed by permit)

  Scenario: calculate 1 axle group
    Given axle unit 1 has the following parameters
      | number of axles   | 1    |
      | axle spread       | null |
      | interaxle spacing | 4.90 |
      | axle unit weight  | 4200 |
      And axle unit 2 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.50  |
      | interaxle spacing | N/A   |
      | axle unit weight  | 15000 |
     When a user chooses to calculate
     Then BF is 37200

@orv2-5275-17
Rule: Axle groups fail BF when the sum of the axle unit weight for an axle group is greater than the BF result

  Scenario: fail axle group 3 calculation
    Given axle unit 3 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.00  |
      | interaxle spacing | 3.00 |
      | axle unit weight  | 15600 |
      And axle unit 4 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.10  |
      | interaxle spacing | N/A   |
      | axle unit weight  | 17800 |
     When a user chooses to calculate
     Then the BF result is 33300
      And the axle group weight is 33400
      And they see "Bridge calculation failed for Axle Group (Axle Unit 3 - Axle Unit 4) Axle Group Weight is 33400, Bridge Formula Weight max is 33300."

@orv2-5275-18
Rule: Axle unit groups that fail bridge formula are indicated on the ASW

  Scenario: failed axle group 3
    Given axle group 3 has failed BF
     When the calculated return the results
     Then the user sees axle unit rows 3 and 4 indicated

  Scenario: failed axle group 3 and 4
    Given axle group 3 has failed BF
      And axle group 4 has failed BF
     When the calculated return the results
     Then the user sees axle unit rows 3 and 4 and 5 indicated

@orv2-5275-19
Rule: All axle groups must pass BF

  Scenario: failed axle group 3
    Given axle group 3 has failed BF
     When the user chooses to calculate
     Then the user sees a error like: "Bridge calculation failed for Axle Group (Axle Unit X - Axle Unit Y), Axle Group Weight is A, Bridge Formula Weight max is B."

  Scenario: passed BF
    Given all axle groups pass BF
     When the user chooses to calculate
     Then they see nothing indicating success

# Notes:





