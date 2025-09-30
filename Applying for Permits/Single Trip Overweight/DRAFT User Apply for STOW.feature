Feature: Applying for Single Trip Overweight Permit (STOW)

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Rule: a STOW is issued to the power unit only

#confirm
Rule: STOS permit default is a one way trip
Rule: a user can optionally choose to designate the STOS application as a return trip
Rule: a return trip multiplies the one way fee by 2
Rule: if chosen a return trip is indicated on the generated permit pdf
Rule: the trip type is shown on review and confirm details

Rule: CVSE Form 1070 is chosen by default and attached to the STOW permit application consecutively beginning after the final page of the issued permit

Rule: CVSE Forms may be optionally chosen for attachment to the issued permit

  Scenario: choose an optional cvse form
    Given a user choose to attach a cvse form the following list of available optional forms:
      | Highways with Restrictive Load Limits CVSE-1011                          |
     When they select "Highways with Restrictive Load Limits CVSE-1011"
      And they continue to review and confirm the application
     Then they see "Highways with Restrictive Load Limits CVSE-1011" is attached to the issued permit after the final page of the issued permit 
      And they see "Permit Scope and Limitation CVSE-1070" is attached to the issued permit before "Highways with Restrictive Load Limits CVSE-1011"

Rule: A user can see the source of truth for CVSE forms

Rule: Users must input a commodity allowable for an STOW permit

Rule: Users can search for a commodity allowable for an STOW permit

Rule: Users can scroll the list of commodities allowable for an STOW permit

Rule: Users can change the chosen commodity

Rule: Users must input a load description

Rule: Users can add a power unit only when a commodity is chosen

Rule: Users may only input one power unit allowable for an STOW permit manually or chosen from inventory 

Rule: Only vehicles with a licensed GVW of 63,500 (kg) or lower may be added or chosen from inventory

Rule: Power unit province / state is not available when Mexico is chosen as the country

Rule: Details of the chosen power units are shown in the application form

Rule: Users may remove the power unit from the application

Rule: a user can edit any power unit detail except vehicle sub-type or recall a new power unit with allowable vehicle sub-type without impacting other application data

Rule: Users must choose from a list of allowable trailers

Rule: The choice and order of allowable trailers is determined by the chosen commodity, and selected power unit

Rule: The chosen trailers are shown in the application form in the order they were added

Rule: The selection of trailers must adhere to an allowable order of jeep first, trailer second, then booster last

Rule: If jeep(s) and or booster(s) are allowable one or more jeep(s) or booster(s) may be added to the trailer list

Rule: A chosen trailer(s) determines the remaining allowable trailers shown

Rule: Don't show the the change commodity warning modal if there are no vehicle details inputted

  Scenario: 
    Given 
     When 
     Then 

ASW

Rule: Origin and destination may be entered manually or selected from the provided resolved list of geocoder locations

Rule: The origin and destination is resolved and the chosen resolved address replaces text inputted by the user

Rule: user must input total distance (km)

Rule: Users must input at least one trip sequence step

Rule: hwy sequence is limited to a maximum of 3 characters per sequence step input field

Rule: A maximum of 32 sequence steps may be inputted

Rule: Show one row of eight steps with an option to add additional rows of eight steps

Rule: Show sequence information box

Rule: Users must input specific route details

Rule: Users may optionally input application notes

Rule: Show application notes info box

Rule: Show application details inputted by the user prior to submission or adding to cart

Rule: Indication of vehicle saved to inventory is shown if save was chosen

Rule: A user can edit an application 

Fee Calculation

Rule: The user must complete the attestations

Rule: users are directed to applications in review after submitting the application for review

Rule: users can pay for a STOW permit application in the shopping cart that has policy validation warnings
