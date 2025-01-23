
Feature: Bridge Formula Calculation Tool (BFCT)

User = HQA, SA, PC, Trainee, CTPO, CTA, EO

@orv2-2916-1
Rule: BFCT works independently of acting as company

  Scenario: acting as company
    Given a user is acting as ABC co.
     When they choose to navigte to the BFCT
     Then they are not acting as ABC co.

@orv2-2916-2
Rule: User can access the BFCT from anywhere in onRouteBC (global navigation bar)

@orv2-2916-3
Rule: Show information about the BFCT

  Scenario: arrive at BFCT
     When a user arrives at the BFCT
     Then they see "This tool only calculates Bridge Formula, which is a mathematical equation that is used to calculate the maximum allowable weight allowed by permit for various axle groups in a combination. This tool is not confirming compliance with the CTR or CTPM. The image on the right is for illustration purposes only."

@orv2-2916-4
Rule: Show a vehicle configuration diagram

@orv2-2916-5
Rule: Show axle unit calculation input parameter table

  Scenario: parameter input table
     When a user arrives at the BFCT
     Then they see the a table with the following input parameters:
       | parameter             | description                                                                                                                |
       | Axle Unit             | an axle unit can have 1 or more axles                                                                                      |
       | Number of Axles       | the number of axles in an axle unit                                                                                        |
       | Axle Spread (m)       | the distance between axles in a unit, measured from the centre of the axles furthest apart from each other                 |
       | Interaxle Spacing (m) | The distance between axle units. Measured from the centres of each of the axles that is the closest to the other axle unit |
       | Axle Unit Weight (kg) | the total weight of an axle unit                                                                                           |

@orv2-2916-6
Rule: the BCFT default state shows 2 axle unit parameter input columns

  Scenario: default state
     When a user arrives at the BFCT
     Then they see the following columns:
       | axle unit 1       |
       | interaxle spacing |
       | axle unit 2       |
       
@orv2-2916-7
Rule: Show 1 interaxle spacing column for every 2 axle units

  Scenario: default state
     When a user arrives at the BFCT
     Then they see 1 interaxle spacing column and input field

  Scenario: add axle unit
     When a user adds an axle unit
     Then they see an interaxle spacing column and input field preceding the newly added axle unit

@orv2-2916-8
Rule: Axle spread is available when there are 2 or more axles in an axle unit

  Scenario: axle unit is 1
     When a user inputs 1 
     Then axle spread is not available

  Scenario: axle unit is empty
     When axle unit is empty
     Then axle spread is available

@orv2-2916-9
Rule: Axle spread is not available when there are 2 or more axles in an axle unit

@orv2-2916-10
Rule: Keyboard tab order is left to right per row

  Scenario: no following axle unit
    Given a user is in axle unit 3 row 2
      And there is no axle unit 4
     When they use keyboard tab once
     Then the cursor is at axle unit 1 (interaxle spacing) row 3

  Scenario: following axle unit
    Given a user is in axle unit 3 row 2
      And there is axle unit 4
     When they use keyboard tab once
     Then the cursor is at axle unit 4 row 2

# whats the limit?
@orv2-2916-11
Rule: User can optionally add additional axle unit input columns following preceding axle unit columns

@orv2-2916-12
Rule: Added axle unit columns are empty

@orv2-2916-13
Rule: User can optionally remove an axle unit input column

  Scenario: 3 axle unit columns
    Given there are 3 axle unit columns
     When a user chooses to remove axle unit 3
     Then they see "Remove item? Are you sure you want to remove this? This action cannot be undone."

  Scenario: continue removal
     When a user chooses to continue with the removal of axle unit 3
     Then they are directed to the BFCT
      And axle unit 3 is removed from the BFCT parameter table

@orv2-2916-14
Rule: Remove axle unit option shows on hover tooltip "Remove"

@orv2-2916-15
Rule: Axle unit columns following removed axle unit column are shifted left and renumbered

  Scenario: 4 axle units remove axle unit 3
     When chooses to remove axle unit 3
     Then axle unit 4 is now axle unit 3
      And interaxle spacing preceding axle unit 4 is removed

@orv2-2916-16
Rule: Only numbers can be inputted into the BFCT parameter table input fields

  Scenario: "ten" inputted 
     When a user inputs "ten" input number of axles for axle unit 1
     Then number of axles for axle unit 1 is empty

@orv2-2916-17
Rule: Length parameters have two decimal precision

  Scenario: input whole number
    Given a user has inputted 10 in axle spread for axle unit 2
     When they leave the field
     Then axle spread for axle unit 2 is 10.00

  Scenario: input single decimal place
    Given a user has inputted 5.5 in axle spread for axle unit 2
     When they leave the field
     Then axle spread for axle unit 2 is 5.50

@orv2-2916-18
Rule: Weight parameters are whole numbers

  Scenario: input a decimal number round up
    Given a user has inputted 5000.5 in axle unit weight for axle unit 1
     When they leave the field
     Then axle unit weight for axle unit 1 is 5001

  Scenario: input a decimal number round down
    Given a user has inputted 5000.5 in axle unit weight for axle unit 1
     When they leave the field
     Then axle unit weight for axle unit 1 is 5000

@orv2-2916-19
Rule: 0, -x and empty are invalid input parameters

  Scenario: 0 inputted
    Given a user input 0 in number of axles for axle unit 2
     When they choose to calculate 
     Then they see "Insufficient and/or invalid data."
      And number of axles for axle unit 2 is indicated

  Scenario: all empty
    Given a user does not input any data 
     When they choose to calculate 
     Then they see "Insufficient and/or invalid data."
      And all empty fields are indicated

@orv2-2916-20
Rule: Calculate bridge calculation wheelbase (BCW) for each axle group

  Scenario: axle group 1
    Given there are 2 axle units 
      And axle unit 1 has 1 axle
      And interaxle spacing is 4.90(m)
      And axle unit 2 axle spread is 1.50(m)
     When a user chooses to calculate
     Then the BCW for axle group 1 is 650(cm)

@orv2-2916-21
Rule: Calculate bridge formula (BF) for each axle group as 30 x (BCW) (cm) + 18,000 kg = x (Maximum weight allowed by permit)

  Scenario: calculate 1 axle group
    Given axle unit 1 has the following parameters
      | number of axles   | 1    |
      | axle spread       | null |
      | interaxle spacing | 4.90 |
      | axle unit weight  | 4200 |
      And axle unit has 2 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.50  |
      | interaxle spacing | N/A   |
      | axle unit weight  | 15000 |
     When a user chooses to calculate
     Then BF is 37200

 # confirm other possible vehicle configs
  Scenario: 5 axle unit vehicle
    Given there are 5 axle units
     When a user chooses to calculate
     Then the BF is calculated for 10 axle groups

@orv2-2916-22
Rule: Axle groups fail BF when the sum of the axle unit weight for an axle group is greater than the BF result

  Scenario: fail axle group 3 calculation
    Given axle unit 3 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.00  |
      | interaxle spacing | 3.00 |
      | axle unit weight  | 15600 |
      And axle unit has 4 has the following parameters
      | number of axles   | 2     |
      | axle spread       | 1.10  |
      | interaxle spacing | N/A   |
      | axle unit weight  | 17800 |
     When a user chooses to calculate
     Then the BF result is 33300
      And the axle group weight is 33400
      And they see "Bridge calculation failed between Axle Unit 3 and 4, Axle Group Weight is 33400, Bridge Formula Weight max is 33300."

@orv2-2916-23
Rule: Axle unit groups that fail bridge formula are indicated

  Scenario: failed axle group 3
    Given axle group 3 has failed BF
     When the calculated return the results
     Then the user sees axle unit columns 3 and 4 indicated

  Scenario: failed axle group 3 and 4
    Given axle group 3 has failed BF
      And axle group 4 has failed BF
     When the calculated return the results
     Then the user sees axle unit columns 3 and 4 and 5 indicated

@orv2-2916-24
Rule: All axle groups must pass BF

  Scenario: failed axle group 3
    Given axle group 3 has failed BF
     When the user chooses to calculate
     Then the user sees "Bridge calculation failed between Axle Unit x and x, Axle Group Weight is x, Bridge Formula Weight max is x."

  Scenario: passed BF
    Given all axle groups pass BF
     When the user chooses to calculate
     Then they see "Bridge Calculation is ok."

@orv2-2916-25
Rule: A user can optionally reset all inputted data in the BFCT parameter table

  Scenario: table has input
    Given the BCFT parameter table has input
     When a user choose to reset
     Then they see " Reset all? Reset will remove all data. This action cannot be undone."

  Scenario: continue reset
     When a user chooses to continue with the reset
     Then they are directed to the BFCT
      And all input is removed
      And the BFCT parameter table is at its default state