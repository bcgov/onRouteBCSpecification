@orv2-5585 https://moti-imb.atlassian.net/browse/ORV2-5585
Feature: As a user I want to apply for a Single Trip Overweight Oversize Empty permit with a length over 27.5m so that I can move my vehicle given the length beyond 27.5m triggers a legal "overload" condition regardless of whether a commodity is being carried.

users = PC, SA, TRAIN, CTPO, CA, PA

Date rules:
Applying for Permits/Permit start and duration CV Client.feature

@orv2-5585
Rule: 

  Scenario: 
    Given 
     When 
     Then 

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
	- Self Issue = less than or equal to OAW 3.20 m, OAL 27.51 to 31.00 m
		- Must be greater than 27.5
		- If 0 is entered we are ok with it? #nextaction 
	- front and rear proj can be 0
	- Submit for review = if any are greater than OAW 3.20 m, OAL 31.00 m, Overall Height = 4.3 m
		- Add to cart is submit for review
		- show warning popup on continue to review and confirm
			- Dimensions exceed self issue This application will be submitted for review.
			- confirm how we are doing this in the STOW because we may still have an issue there #nextaction 
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
	- Sequence of highways info box change the Height Clearance Tool to Commercial Vehicle Routing Tool https://twm.th.gov.bc.ca/?c=cvrt
	- Select permit menu should read Oversize Overweight not Oversized
	- Move Eptop to Non res
	- LOA's do not apply to this permit type
	- Receipt Template
- Create ticket for the start permit selection drop down #nextaction 
	- link to this ticket
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
	- do we ever need to refund a portion of the fee, like the falt rate vs 10km rate
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
