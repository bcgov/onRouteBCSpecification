@orv2-5585 https://moti-imb.atlassian.net/browse/ORV2-5585
Feature: As a user I want to apply for a Single Trip Overweight Oversize Empty - length over 27.5m permit so that I can move my vehicle given the length beyond 27.5m triggers a legal "overload" condition regardless of whether a commodity is being carried.

users = PC, SA, TRAIN, CTPO, CA, PA
cv client = CA, PA

Note: These rules cover the user experience for applying for a Single Trip Overweight Oversize Empty - length over 27.5m permit application permit for all users and those specific to CV clients. Other rules (e.g., contact details, date or duration) that are common to more than one permit application type can be found in the Applying for Permits folder.

# Permit Details
@orv2-5585-1
Rule: CVSE Form CVSE-1000 Application for Oversize/Overweight Permit and CVSE-1070 Single Trip Overweight Oversize Empty - Length over 27.5m Conditions(May 2021) are chosen by default and attached consecutively beginning after the final page of the issued permit
# Vehicle Information
@orv2-5585-2
Rule: Users may only input a power unit allowable for a Single Trip Overweight Oversize Empty - length over 27.5m permit manually or chosen from inventory

 # see vehicle to permit mapping: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

  Scenario: recall non allowable
    Given power unit A vehicle sub-type is not allowed
     When they choose to recall power unit A
     Then they do not see power unit A

  Scenario: manually input new vehicle
    Given vehicle sub-type 1 is not allowed
     When they attempt to choose vehicle sub-type 1 
     Then they do not see vehicle sub-type 1

@orv2-5585-3
Rule: Only vehicles with a licensed GVW of 63,500 (kg) or lower may be added or chosen from inventory

  Scenario: manually input 65,000 (kg)
    Given a user has manually inputted a power unit
     When they input 65,000 (kg)
     Then they see "Can't Exceed 63,500"
      And they cannot continue

  Scenario: attempt to recall 65,000 (kg)
    Given a user chooses to recall a power unit with a licensed gvw of 65,000 (kg)
     When they search for the power unit
     Then they do not see power units with a licensed gvw greater than 63,500 (kg)

@orv2-5585-4
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-5585-5
Rule: a user can edit any power unit detail except vehicle type or recall a new power unit with allowable vehicle sub-type

  Scenario: edit power unit details
     Given a user has inputted or recalled a power unit
     When they choose to edit the power unit details
     Then they can edit any detail except vehicle type

  Scenario: recall new power unit with allowable vehicle sub-type
     Given a user has inputted or recalled a power unit with vehicle sub-type 1
      And vehicle sub-type 2 is allowed for this permit type
     When they choose to recall a new power unit with vehicle sub-type 2
     Then they can recall the new power unit with vehicle sub-type 2
      And vehicle sub-type 1 is removed from the application
      And the details for the new power unit are added to the application

# Dimensions (Metres)
@orv2-5585-6
Rule: Users must input all dimensions and cannot input negative numbers

  Scenario: input negative dimensions
     When a user inputs negative numbers into dimension fields
      And they choose to continue 
     Then they see "Must be greater than 0m."
      And the dimension fields are indicated with a red border
      And they cannot continue

  Scenario: no input
    Given a user does not input overall width
     When they choose to continue
     Then they see "This is a required field."
      And overall width field is indicated with a red border
      And they cannot continue

@orv2-5585-7
Rule: Overall length must be greater than 27.5m 

  Scenario: overall length less than
     Given a user inputs overall length 27.49m
     When they choose to continue
     Then they see "Must be greater than 27.5m."
      And overall length field is indicated with a red border
      And they cannot continue

  Scenario: overall length equal to
     Given a user inputs overall length 27.5m
     When they choose to continue
     Then they see "Must be greater than 27.5m."
      And overall length field is indicated with a red border
      And they cannot continue

@orv2-5585-8
Rule: Dimension fields have 2 decimal places

  Scenario: input more than 2 decimal places in dimension field
     When a user inputs 3.123 into a dimension field
     Then they see 3.12 in the field

  Scenario: input 2 decimal places in dimension field
     When a user inputs 3.12 into a dimension field
     Then they see 3.12 in the field

  Scenario: input 0 decimal places in dimension field
     When a user inputs 3 into a dimension field
     Then they see 3.00 in the field

# Dimension Based Submission Rules
@orv2-5585-9
Rule: cv clients can self issue if overall width is less than or equal to 3.20 m and overall length is between 27.51 m and 31.00 m and overall height is less than or equal to 4.3 m

  Scenario: self issue dimensions
     Given a user inputs dimensions that are within self issue limits
     When they choose to continue
     Then they are directed to the "Review and Confirm Details" page
      And they have the option to add to cart

@orv2-5585-10
Rule: cv clients must submit for review if overall width is greater than 3.20 m or overall length is greater than 31.00 m or overall height is greater than 4.3 m

  Scenario: submit for review dimensions
     Given a user inputs dimensions that are outside of self issue limits
     When they choose to continue
     Then they are directed to the "Review and Confirm Details" page
      And they only have the option to submit for review

@orv2-5585-11
Rule: users are shown a warning message on the "Review and Confirm Details" page if dimensions are outside of self issue limits

  Scenario: dimensions outside of self issue limits
     Given a user inputs dimensions that are outside of self issue limits
      And they continue to the "Review and Confirm Details" page
     Then they see "Application requires review The provided dimensions make this application ineligible for self-issue and must be reviewed by the Provincial Permit Centre."

  Scenario: dimensions inside of self issue limits
    Given a user inputs dimensions that are within self issue limits
     When they continue to the "Review and Confirm Details" page
     Then they do not see "Application requires review The provided dimensions make this application ineligible for self-issue and must be reviewed by the Provincial Permit Centre." 

# Overload (kg)
@orv2-5585-12
Rule: Users must input the weight of the axles beyond 27.5m greater than 0 and cannot input negative numbers

  Scenario: input negative weight
     When a user inputs negative numbers into the weight over 27.5m field
     Then they cannot input negative numbers

  Scenario: no input
    Given a user does not input weight over 27.5m
     When they choose to continue
     Then they see "This is a required field."
      And weight over 27.5m field is indicated with a red border
      And they cannot continue

  Scenario: input 0
    Given a user has inputted 0
     When they choose to continue
     Then they see "Must be greater than 0kg."
      And weight over 27.5m field is indicated with a red border
      And they cannot continue
  
@orv2-5585-13
Rule: Weight Over 27.5m field has no decimal places

  Scenario: input decimal places in weight field
     When a user inputs 1000.55 into the weight over 27.5m field
     Then they see 1001 in the field

  Scenario: input whole number in weight field
     When a user inputs 1000 into the weight over 27.5m field
     Then they see 1000 in the field
# Trip Details
@orv2-5585-14
Rule: Origin and destination may be entered manually or selected from the provided resolved list of geocoder locations

  Scenario: no origin or destination is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field."
      And the mandatory field is indicated

  Scenario: user inputted text
    Given a user has inputted text in origin, destination or exit point
      And has not chosen a resolved address from the geocoder list 
     When they chose to continue
     Then they can continue

@orv2-5585-15
Rule: The origin and destination is resolved and the chosen resolved address replaces text inputted by the user

 Scenario: 940 blanshard
     When a user has inputted 940 Blanshard
     Then they see the following list:
       | BC Places                      |
       | 940 Blanshard St, Victoria, BC |
       | 940 Blanshard Dr, Richmond, BC |
       | Blanshard St, Saanich, BC      |
       | Blanshard Rd, Bouchie Lake, BC |
       | Blanshard Rd, Malahat, BC      |
       | Blanshard Rd, Vernon, BC       |
       | Blanshard St, Maple Ridge, BC  |

@orv2-5585-16
Rule: Users must input total distance (km)

  Scenario: no input
     When a user chooses to continue to review and confirm
     Then they can not continue
      And they see "This is a required field."
      And the mandatory field is indicated

  Scenario: text input
    Given a user inputs "eight hundred" in total distance
     When they choose to continue
     Then they can not continue
      And they see "Invalid Input"
      And the mandatory field is indicated

  Scenario: -number
     When a user inputs -100
     Then they see "Invalid Input"

@orv2-5585-17
Rule: Total distance resolves to 2 decimal places

  Scenario: input 100.555
    Given a user input 100.555
     When they leave the field
     Then they see 100.55

@orv2-5585-18
Rule: Users must input at least one trip sequence step

  Scenario: no sequence is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter at least one highway."
      And the mandatory field is indicated

@orv2-5585-19
Rule: hwy sequence is limited to a maximum of 3 characters per sequence step input field

  Scenario: sequence step inputted
     When a user inputs "1" into the first sequence step
      And continues
     Then the sequence step "1" is saved with the application

 Scenario: 4 characters inputted
     When a user inputs "1234" into the first sequence step
      And continues
     Then they "123" is saved with the application

  Scenario: sequence step inputted with a space
     When a user inputs "1 " into the first sequence step
      And continues
     Then the sequence step "1" is saved with the application

  Scenario: sequence step inputted with a space and a letter
     When a user inputs "1 A" into the first sequence step
      And continues
     Then the sequence step "1 A" is saved with the application

  Scenario: sequence step inputted with a letter
     When a user inputs "A" into the first sequence step
      And continues
     Then the sequence step "A" is saved with the application

@orv2-5585-20
Rule: A maximum of 32 sequence steps may be inputted
@orv2-5585-21
Rule: Show one row of eight steps with an option to add additional rows of eight steps

  Scenario: add highways not chosen
    Given a user does not add highways
     When they are directed to the single trip permit application 
     Then they see 8 boxes 
      And they are each numbered started at 1

  Scenario: add highways
    Given on 1 row of highway boxes exist
     When a user chooses to add highways
     Then they see 2 rows of higway boxes
      And the second row starts at 9

@orv2-5585-22
Rule: Show sequence information box
@orv2-5585-23
Rule: Users must input specific route details

  Scenario: no specific route details is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

# Application Notes
@orv2-5585-24
Rule: Users may optionally input application notes

  Scenario: notes inputted
     When a user inputs "These are my notes" into application notes
      And continues
     Then the  application note "These are my notes" are saved with the application

@orv2-5585-25
Rule: Show application notes info box
# Review and Confirm
@orv2-5585-26
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                            |
       | Company information edit message                             |
       | Company mailing Address of permitee                          |
       | Contact information submitted in Permit Application          |
       | Permit details submitted in Permit Application               |
       | Selected CVSE Forms listed with links to the source of truth |
       | Vehicle information submitted in Permit Application          |
       | Dimensions (Metres)                                          |
       | Overload (kg)                                                |
       | Trip details submitted in the permit application             |
       | Application notes if submitted in the permit application     |
       | Permit fee summary                                           |
       | Permit attestations                                          |

@orv2-5585-27
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-5585-28
Rule: A user can edit an application 

# Fee Calculation and Fee Summary
@orv2-5585-29 The oversize portion of the permit fee is a flat fee of $15.00

@orv2-5585-30
Rule: The overload portion of the permit fee is calculated using the weight of the axle(s) beyond 27.5m to establish the overload permit fee per 10 km rate (or fraction thereof) x (the total distance (km) / 10) rounded to the nearest dollar with a minimum fee of $25.00

 # see General Fee 3(d) for current fee table: https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/328_91

 Overload permit fee table:
    | overloadkg      | rateper10km |
    | 0-2000          | 0.95        |
    | 2001-3000       | 1.15        |
    | 3001-4000       | 1.40        |
    | 4001-5000       | 1.60        |
    | 5001-6000       | 1.85        |
    | 6001-7000       | 2.15        |
    | 7001-8000       | 2.45        |
    | 8001-9000       | 2.95        |
    | 9001-10000      | 3.35        |
    | 10001-11000     | 3.75        |
    | 11001-12000     | 4.25        |
    | 12001-13000     | 4.95        |
    | 13001-14000     | 5.60        |
    | 14001-15000     | 6.25        |
    | 15001-16000     | 7.25        |
    | 16001-17000     | 8.25        |
    | 17001-18000     | 9.15        |
    | 18001-19000     | 10.10       |
    | 19001-20000     | 10.90       |
    | 20001-21000     | 11.85       |
    | 21001-22000     | 12.70       |
    | 22001-23000     | 13.95       |
    | 23001-24000     | 14.95       |
    | 24001-25000     | 16.10       |
    | 25001-26000     | 17.85       |
    | 26001-27000     | 19.85       |
    | 27001-28000     | 21.40       |

  Scenario Outline: Overload permit fee is calculated from overload weight and total distance
     Given a user has inputted <weight>kg in the weight over 27.5m field
      And they have inputted <distance>km in total distance
     When they continue to the "Review and Confirm Details" page
     Then they see a overload permit fee of $<fee>

    Examples:
      | weight | distance | fee     |
      | 10000  | 800      | 268.00  |
      | 28000  | 1000     | 2140.00 |
      | 1000   | 100      | 25.00   |
      | 19500  | 900      | 981.00  |
      | 2000   | 101      | 25.00   |
      | 2001   | 220      | 25.00   |
      | 10001  | 800      | 300.00  |
      | 12000  | 85       | 36.00   |

@orv2-5585-31
Rule: For overload greater than 28000 kg, the permit fee per 10 km is 21.40 plus 1.85 for each 900 kg or portion thereof over 28000, with the minimum fee of 25.00, then rounded to the nearest dollar with amounts ending in 0.50 or more rounded up.

  Scenario Outline: Overload permit fee is calculated for overload greater than 28000 kg
     Given a users calculated <licensedgvwincrease>kg
      And they have inputted <distance>km in total distance
     When they continue to the "Review and Confirm Details" page
     Then they see a overload permit fee of $<fee>

    Examples:
      | licensedgvwincrease | distance | fee     |
      | 29000               | 1000     | 2510.00 |
      | 30700               | 100      | 270.00  |
      | 33400               | 100      | 330.00  |

# Notes:
- under Non-Res in start permit menu
- if BC then show error on province selection
 - Scenario: bc plated
    Given a user chooses "British Columbia" as Province / State
     When they choose to continue
     Then they see "BC plated vehicles don't require this permit."