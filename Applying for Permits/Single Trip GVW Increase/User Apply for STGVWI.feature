@orv2-5606 https://moti-imb.atlassian.net/browse/ORV2-5606
Feature: User apply for a Single Trip GVW Increase (STGVWI) permit

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Note: These rules cover the user experience for applying for a Single Trip GVW Increase (STGVWI) permit application permit for all users and those specific to CV clients. Other rules (e.g., contact details, date or duration) that are common to more than one permit application type can be found in the Applying for Permits folder.

# Permit Details
# See Permit start and duration User feature file for rules related to permit start and duration

@orv2-5606-1
Rule: CVSE Form CVSE-1070 Permit Scope and Limitations are chosen by default and attached consecutively beginning after the final page of the issued permit

# Vehicle Information
@orv2-5606-2
Rule: Users may only input a power unit allowable for a Single Trip GVW Increase permit manually or chosen from inventory

 # see vehicle to permit mapping: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

  Scenario: recall non allowable
    Given power unit A vehicle sub-type is not allowed
     When they choose to recall power unit A
     Then they do not see power unit A

  Scenario: manually input new vehicle
    Given vehicle sub-type 1 is not allowed
     When they attempt to choose vehicle sub-type 1 
     Then they do not see vehicle sub-type 1

@orv2-5606-3
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

@orv2-5606-4
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-5606-5
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

# Actual GVW (kg)
@orv2-5606-6
Rule: Actual GVW (kg) is required and must be greater than the licensed GVW

  Scenario: no input
     Given a user has inputted or recalled a power unit
     When they have not inputted an actual gvw
     Then they see "This is a required field" error message for the "Actual GVW (kg)" field
      And the "Actual GVW (kg)" field is highlighted in red
      And they cannot continue

  Scenario: input less than licensed gvw
     Given a user has inputted or recalled a power unit with a licensed gvw of 63,500 (kg)
     When they input an actual gvw of 63,000 (kg)
     Then they see "Must be greater than Licensed GVW."
      And the "Actual GVW (kg)" field is highlighted in red
      And they cannot continue

  Scenario: greater than 63,500 (kg)
     Given a user has inputted or recalled a power unit with a licensed gvw of 63,500 (kg)
     When they input an actual gvw of 64,000 (kg)
     Then they see "Cannot exceed 63,500kg"
      And the "Actual GVW (kg)" field is highlighted in red
      And they cannot continue

# Overload Calculation
@orv2-5606-7
Rule: Licensed GVW Increase is calculated live on input of Actual GVW (kg) as the difference between Actual GVW and Licensed GVW and displayed on the application form

  Scenario: licensed 40000 actual 46000
    Given a users power unit licensed GVW is 40000
     When they input an actual GVW of 46000
     Then they see "Licensed GVW Increase (kg): 6000"
      And they can continue

# Trip Details
@orv2-5606-8
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

@orv2-5606-9
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

@orv2-5606-10
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

@orv2-5606-11
Rule: Total distance resolves to 2 decimal places

  Scenario: input 100.555
    Given a user input 100.555
     When they leave the field
     Then they see 100.55

@orv2-5606-12
Rule: Users must input at least one trip sequence step

  Scenario: no sequence is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter at least one highway."
      And the mandatory field is indicated

@orv2-5606-13
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

@orv2-5606-14
Rule: A maximum of 32 sequence steps may be inputted
@orv2-5606-15
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

@orv2-5606-16
Rule: Show sequence information box
@orv2-5606-17
Rule: Users must input specific route details

  Scenario: no specific route details is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

# Review and Confirm
@orv2-5606-18
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
       | Actual GVW (kg)                                              |
       | Licensed GVW Increase (kg)                                   |
       | Trip details submitted in the permit application             |
       | Permit fee summary                                           |
       | Permit attestations                                          |

# Fee Calculation and Fee Summary
@orv2-5606-19
Rule: The overload portion of the permit fee is calculated using the Licensed GVW Increase (kg) to establish the overload permit fee per 10 km rate (or fraction thereof) x (the total distance (km) / 10) rounded to the nearest dollar with a minimum fee of $25.00

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

  Scenario Outline: Overload permit fee is calculated from overload weight (licensed GVW increase) and total distance
     Given a users calculated <licensedgvwincrease>kg 
      And they have inputted <distance>km in total distance
     When they continue to the "Review and Confirm Details" page
     Then they see a overload permit fee of $<fee>

    Examples:
      | licensedgvwincrease | distance | fee     |
      | 10000               | 800      | 268.00  |
      | 28000               | 1000     | 2140.00 |
      | 1000                | 100      | 25.00   |
      | 19500               | 900      | 981.00  |
      | 2000                | 101      | 25.00   |
      | 2001                | 220      | 25.00   |
      | 10001               | 800      | 300.00  |
      | 12000               | 85       | 36.00   |

@orv2-5606-20
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

Single Trip - GVW Increase
- CVSE Forms:
	- 1070 chosen by default
- Vehicle SubTypes
	- Any power unit
	- LCV should be available if they are LCV
- Licensed GVW
	- max violation still true
		- Over 63,500
			- Cannot exceed 63,500
- Overload
	- This is a required field
	- Actual GVW
		- Less than licensed Actual GVW "Must be greater than Licensed GVW."
	- Max violation still true
		- Over 63,500
			- Cannot exceed 63,500
	- Licensed GVW Increase
		- live on input results
- Trip Details
	- Same mandatory behaviour
- Application Notes
	- Turf it
- Fee Calculation
	- same as STOW
	- Round up
  - Overload permit fee table (per 10 km or fraction thereof; minimum $25.00):
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
  - For overload greater than 28000 kg, use 21.40 plus 1.85 for each 900 kg or portion thereof over 28000, per 10 km or fraction thereof.
  - Round the final overload permit amount to the nearest dollar; amounts ending in 0.50 or more are rounded up to the next dollar.
- Fee Summary
	- Non-itemized

 