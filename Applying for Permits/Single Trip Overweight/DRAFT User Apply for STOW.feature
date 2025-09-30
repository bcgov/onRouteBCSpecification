Feature: Applying for Single Trip Overweight Permit (STOW)

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Note: These rules cover the user experience for applying for a Single Trip Overweight (STOW) permit application form behaviour specific to a STOW permit application. Other rules (e.g., contact details, date or duration) that are common to more than one permit application type can be found in the Applying for Permits folder.

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

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B1B0D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Commodity%20List%2020170825.xlsx&action=default&mobileredirect=true

  Scenario: no commodity inputted
     When a users chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

Rule: Users can search for a commodity allowable for an STOW permit

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B1B0D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Commodity%20List%2020170825.xlsx&action=default&mobileredirect=true

  Scenario: Hay Bales (Round) Peace River Only
    Given a user is searching for "Hay Bales (Round) Peace River Only"
     When they enter a <parameter> 
     Then they see these <results>

     Examples:
       | parameter | results                            |
       | Hay       | Hay Bales (Round) Peace River Only |
       | Hay       | Hay Bales Large Rectangular        |
       | Hay       | Hay Bales Round                    |
       | Hay       | Hay Bales Small Rectangular        |
       | Pea       | Hay Bales (Round) Peace River Only |
       | La        | Hay Bales Large Rectangular        |

Rule: Users can scroll the list of commodities allowable for an STOW permit

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B1B0D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Commodity%20List%2020170825.xlsx&action=default&mobileredirect=true

Rule: Users can change the chosen commodity

  Scenario: vehicles exist warning
    Given vehicles have been added to the permit application
     When a user chooses to chnage the commodity
     Then they see "Change Commodity Type Changing your commodity will require you to re-enter your vehicle information and loaded dimensions."

  Scenario: vehicles exist confirm change
    Given a user initiated a commodity change
     When a user chooses to continue
     Then the commodity type is removed 
      And all inputted vehicle information is removed
      And all inputted loaded dimensions is removed

  Scenario: vehicles do not exist
    Given a user has not added vehicles to the permit application
     When a user chooses to change the commodity
     Then the commodity changes without warning
      
Rule: Users must input a load description

  Scenario: no load description inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

Rule: Users can add a power unit only when a commodity is chosen

  Scenario: arrive
     When a user arrives at a new STOW permit application
     Then the option to add a power unit is not available
  
  Scenario: commodity chosen
    Given commodity is not chosen
     When a user chooses a commodity
     Then the option to add a power unit is available

  Scenario: commodity not chosen
     When a user does not choose a commodity
     Then the option to add a power unit is available

  Scenario: change commodity
    Given commodity is chosen
     When a user changes the commodity
     Then all vehicle information is removed
      And the option to add a power unit is available

  Scenario: commodity not chosen continue
     When a user chooses to continue
     Then they see "A Power Unit must be added."
      And they cannot continue

Rule: Users may only input one power unit allowable for an STOW permit manually or chosen from inventory 

 # see STOW vehicle list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B8C8D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Vehicle%20List%2020170825.xlsx&action=default&mobileredirect=true

  Scenario: pu added
     When a user chooses to add a power unit
     Then they do not have the option to add a power unit

  Scenario: no pu added
     When a user chooses to add a power unit
     Then they have the option to add a power unit

  Scenario: recall non allowable
    Given power unit A is not allowed for a chosen commodity
     When they choose to recall power unit A
     Then they cannot choose the power unit A

  Scenario: manually input new vehicle
    Given vehicle sub-type 1 is not allowed for a chosen commodity
     When they attempt to choose vehicle sub-type 1 
     Then they cannot choose the power unit 1

Rule: Only vehicles with a licensed GVW of 63,500 (kg) or lower may be added or chosen from inventory

  Scenario: manually input 65,000 (kg)
    Given a user has manually inputted a power unit
     When they input 65,000 (kg)
     Then they see "Can't Exceed 63,500"
      And they cannot continue

  Scenario: attempt to recall 65,000 (kg)
    Given a user chooses to recall a power unit with a licensed gvw of 65,000 (kg)
     When they search for the power unit
     Then they do not see power units with a licensed gvw greater than 63,500 (kg) in search results

Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

Rule: Details of the chosen power units are shown in the application form

  Scenario: pu details shown
    Given a user has added a power unit
     When they view the application form
     Then they see the details of the chosen power unit
     
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


# confirm
Rule: STOS permit default is a one way trip
Rule: a user can optionally choose to designate the STOS application as a return trip
Rule: a return trip multiplies the one way fee by 2
Rule: if chosen a return trip is indicated on the generated permit pdf
Rule: the trip type is shown on review and confirm details
# confirm