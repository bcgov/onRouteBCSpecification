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












# Notes:
In British Columbia, a permit for an empty (no load) vehicle combination exceeding 27.5 m is required because the legal definition of an "overload" explicitly includes the weight of any part of an empty vehicle that extends past that mark.
The following details outline the rules, fees, and safety requirements for these specific permits:
1. Legal Basis and Definition
Definition of Overload: For the purpose of issuing permits, an "overload" is defined as the total weight of any axle unit or group of axles located beyond the 27.5 m mark of an empty vehicle combination.
Trigger: Even if the vehicle is carrying no cargo, once the physical length exceeds 27.5 m, it is legally considered to be in an overweight condition.
2. Permit and Fee Requirements
Mandatory Permits: Operators must obtain both oversize and overweight permits to move these empty combinations on provincial highways.
Fee Calculation: Unlike standard overweight permits where fees are based on weight exceeding the licensed GVW, the overload fee for an empty overlength combination is calculated based on the entire weight of the axles situated beyond the 27.5 m point.
Licensed GVW: The permit must still note the Registered/Licensed Gross Vehicle Weight (GVW) as part of the standard mandatory vehicle information, allowing enforcement to verify the vehicle is not in violation of its basic licensing limits.
3. Safety and Pilot Car Rules
Pilot Car Requirement: Any vehicle or combination (empty or loaded) exceeding 27.5 m in length is required to have at least one pilot car.
Positioning: If the empty combination is over 27.5 m long but less than 3.2 m wide, the pilot car is specifically directed to travel to the rear of the vehicle on 2, 3, or 4-lane highways.
Signage: The vehicle or load must display signs containing the words "Long Load," "Oversize Load," or a "D" sign.
Lights: In daylight, if a pilot car is not used (for widths up to 3.5 m), the towing unit must operate amber rotating or strobe lights.
4. Applicable Vehicle Types
This rule frequently affects specialized heavy haul equipment that remains long even when empty, such as:
Lowbeds with boosters.
Hiboy semi-trailers.
Picker truck tractors.
Oilfield Bed Trucks (particularly in the Peace River Area, where they may operate up to 32 m in total combination length).
Tow truck combinations towing a disabled vehicle that exceed the 27.5 m threshold

Tab order
- Commodity Details - Remove this section but keep vehicle config relationships
	- Empty should be the only available commodity
		- default and unavailable
	- Load description says Empty and cannot be edited
- Power unit, new or recall limited to
	- Picker Truck Tractors
	- Picker Trucks
	- Truck Tractors
	- Trucks
- Vehicle Dimensions - all mandatory
	- Overall Width
	- Overall Height
	- Overall Length
	- Front Projection 
	- Rear Projection
- Overweight
	- Weight beyond 27.5 on the ground
- CVSE Form
	- CVSE-1000 mandatory
	- CVSE-1070 mandatory
- Trip Details
	- same as STOW
- Application Notes:
	- keep
- Fee calculation
	- Infobox: Overload permit fee calculation is based on entire weight of axle(s) beyond 27.5m.
	- 10km rate
	- $15 STOS flat fee - because they are oversized
- Review and Confirm
	- Dimensions
	- Trip Details
- Dimension Submission Behaviour
	- no negative numbers
 - 2 decimal places allowed except for weight which is whole numbers only
	- Self Issue = less than or equal to OAW 3.20 m, OAL 27.51 to 31.00 m
		- OAL must be greater than 27.5
	- front and rear proj can be 0
	- Submit for review = if any are greater than OAW 3.20 m, OAL 31.00 m, Overall Height = 4.3 m
		- show warning popup on continue to review and confirm
			- Dimensions exceed self issue This application will be submitted for review.
		- one or more break policy submit for review
	- Under threshold:
		- min OAL 27.5
			- equal to or less than 27.5
				- Must be greater than 27.5
				- Cannot continue application
	- Weight Over 27.5m (kg)
		- whole numbers
		- 0
			- Must be greater than 0
- OL field?
 - empty return auth?, they require full permit not relevant 
	- Separate overload section
- LOA's do not apply to this permit type
#### Staff
- staff new application always goes to cart
	- always goes to the cart 
	- less than 27.5 still stops staff
	- allow OAW, OAL, OAH with any number
- do staff see the the must submit warning
	- yes but generic now
	- +pop up warning
		- lists only what triggered the warning
		- shows on amend as well
- Refunds 
	- do we ever need to refund a portion of the fee, like the flat rate vs 10km rate
		- all or nothing
	- increase permit value possible
		- add weight and kilometers can increase the permit value
	- refund to multiple payment methods summary table
		- no specific issues
- Free Flag
	- Permit can be free
- LCV
	- no LCV vehicles
- LOA
	- not LOA
- Receipt

A Application requires review
The provided dimensions make this application ineligible for self-purchase until it is reviewed
and approved by the Provincial Permit Centre.

Overload Permit Fees	
 		For each single trip permit, according to the following table:	
 			Fee for each 10 km of operation or fraction thereof (minimum $25.00)
 			Overload in Kilograms		
 – 2 000		0.95
 2 001 – 3 000		1.15
 3 001 – 4 000		1.40
 4 001 – 5 000		1.60
 5 001 – 6 000		1.85
 6 001 – 7 000		2.15
 7 001 – 8 000		2.45
 8 001 – 9 000		2.95
 9 001 – 10 000		3.35
 10 001 – 11 000		3.75
 11 001 – 12 000		4.25
 12 001 – 13 000		4.95
 13 001 – 14 000		5.60
 14 001 – 15 000		6.25
 15 001 – 16 000		7.25
 16 001 – 17 000		8.25
 17 001 – 18 000		9.15
 18 001 – 19 000		10.10
 19 001 – 20 000		10.90
 20 001 – 21 000		11.85
 21 001 – 22 000		12.70
 22 001 – 23 000		13.95
 23 001 – 24 000		14.95
 24 001 – 25 000		16.10
 25 001 – 26 000		17.85
 26 001 – 27 000		19.85
 27 001 – 28 000		21.40