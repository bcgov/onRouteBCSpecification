Feature: Applying for Single Trip Overweight Permit (STOW)

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Note: These rules cover the user experience for applying for a Single Trip Overweight (STOW) permit application form behaviour specific to a STOW permit application. Other rules (e.g., contact details, date or duration) that are common to more than one permit application type can be found in the Applying for Permits folder.

# Permit Details
@orv2-3276-1
Rule: CVSE Form 1070 is chosen by default and attached to the STOW permit application consecutively beginning after the final page of the issued permit
@orv2-3276-2
Rule: CVSE Forms may be optionally chosen for attachment to the issued permit

  Scenario: choose an optional cvse form
    Given a user choose to attach a cvse form the following list of available optional forms:
      | Highways with Restrictive Load Limits CVSE-1011                          |
     When they select "Highways with Restrictive Load Limits CVSE-1011"
      And they continue to review and confirm the application
     Then they see "Highways with Restrictive Load Limits CVSE-1011" is attached to the issued permit after the final page of the issued permit 
      And they see "Permit Scope and Limitation CVSE-1070" is attached to the issued permit before "Highways with Restrictive Load Limits CVSE-1011"

@orv2-3276-3
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

# Commodity Details
@orv2-3276-4
Rule: Users must input a commodity allowable for an STOW permit

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881efcec-9462-46d8-a908-1e7df42f113a%7D&action=edit&wdinitialsession=3bcc4506-0f70-c7c7-ef0a-ed7f570196b6&wdrldsc=9&wdrldc=1&wdrldr=ContinueInExcel&wdenableroaming=1&wdlcid=en-CA&wdorigin=AuthRedirect.BrowserReload&wdredirectionreason=Force_SingleStepBoot

  Scenario: no commodity inputted
     When a users chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-3276-5
Rule: Commodity types "None" appears below select at the top of the drop down list
@orv2-3276-6
Rule: Users can search for a commodity allowable for an STOW permit

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881efcec-9462-46d8-a908-1e7df42f113a%7D&action=edit&wdinitialsession=3bcc4506-0f70-c7c7-ef0a-ed7f570196b6&wdrldsc=9&wdrldc=1&wdrldr=ContinueInExcel&wdenableroaming=1&wdlcid=en-CA&wdorigin=AuthRedirect.BrowserReload&wdredirectionreason=Force_SingleStepBoot


  Scenario: Reducible Loads
    Given a user is searching for "Reducible Loads"
     When they enter a <parameter> 
     Then they see these <results>

     Examples:
       | parameter | results               |
       | Red       | Manufactured Homes.   |
       | Red       | 1 Non-Reducible Loads |
       | Red       | Reducible Loads       |

@orv2-3276-7
Rule: Users can scroll the list of commodities allowable for an STOW permit

 # see STOW commodity list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881efcec-9462-46d8-a908-1e7df42f113a%7D&action=edit&wdinitialsession=3bcc4506-0f70-c7c7-ef0a-ed7f570196b6&wdrldsc=9&wdrldc=1&wdrldr=ContinueInExcel&wdenableroaming=1&wdlcid=en-CA&wdorigin=AuthRedirect.BrowserReload&wdredirectionreason=Force_SingleStepBoot


@orv2-3276-8
Rule: Users can change the chosen commodity

  Scenario: vehicles exist warning
    Given vehicles have been added to the permit application
     When a user chooses to change the commodity
     Then they see "Change Commodity Type Changing your commodity will require you to re-enter your Vehicle Information and Axle Spacing and Weights."
      And they have the option to cancel or continue

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
      
@orv2-3276-9
Rule: Users must input a load description

  Scenario: no load description inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

# Vehicle Information
@orv2-3276-10
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

@orv2-3276-11
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
     Then they cannot choose vehicle sub-type 1 

@orv2-3276-12
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

@orv2-3276-13
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-3276-14
Rule: Details of the chosen power units are shown in the application form

  Scenario: pu details shown
    Given a user has added a power unit
     When they view the application form
     Then they see the details of the chosen power unit including:
      | Unit #
      | Vehicle Sub-type  |
      | Year              |
      | Make              |
      | VIN               |
      | Licensed GVW (kg) |
      | Plate             |
      | Province/State    |

@orv2-3276-15
Rule: Users may remove the power unit from the application

  Scenario: no pu
     When a user chooses to remove the power unit
     Then they do not have the option to remove the power unit

  Scenario: pu exists
     When a user chooses to removed the power unit
     Then they have the option to remove the power unit

  Scenario: confirm remove power unit
    Given a power unit exists
     When a user chooses to remove the power unit
     Then they see "Remove Power Unit Confirming will require you to re-enter your trailer configuration and Axle Spacing and Weights." 
      And they have the option to cancel or continue 

  Scenario: pu exists removed
     When a user chooses to remove a power unit
     Then all inputted power unit information is removed
      And all inputted axle spacings and weights (ASW) information is removed
      And all inputted trailer information is removed

@orv2-3276-16
Rule: a user can edit any power unit detail except vehicle sub-type or recall a new power unit with allowable vehicle sub-type without impacting other application data

  Scenario: edit power unit
    Given there is a power unit
     When a user chooses to edit
     Then they are directed to the edit power unit screen
      And vehicle sub-type is not available

  Scenario: edit plate
    Given a user has chosen to edit the power unit
     When they amend the plate to ABC123
      And choose done
     Then they are directed to the application form
      And the plate is ABC123

  Scenario: recall new vehicle
    Given a commodity is chosen
     When a user chooses to recall a new vehicle
     Then only allowable vehicle sub-types are available

@orv2-3276-17
Rule: Users must choose from a list of allowable trailers

 # see STOW trailer list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B9C8D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Trailer%20List%2020170825.xlsx&action=default&mobileredirect=true

  Scenario: no allowable
     When the user has chosen a commodity and power unit with no allowable trailer
     Then there is no option to add a trailer

   Scenario: none is an option
     Given allowable trailers include "None"
      When a users chooses to add a trailer
      Then "None" is the first option

  Scenario: choose "None"
     Given allowable trailers include "None"
      When a users chooses "None"
      Then there is no option to add another trailer
       And they see the option to reset the list

  Scenario: trailer not inputted
    Given a trailer has not been chosen 
     When a user chooses to continue to review and confirm
     Then they see "Vehicle configuration is not permittable for this commodity"
      And add trailer is indicated

  Scenario: reached limit of allowable trailers 
      When a user adds trailers to the application
       And there are no allowable additional trailers  
      Then there is no option to add another trailer
       And they see the option to reset the list

@orv2-3276-18
Rule: Users may reset the trailer list to start adding trailers again from the beginning of the allowable trailer list

  Scenario: reset trailer list no calculation
    Given a user has added one or more trailers to the application
     When they choose to reset the trailer list
     Then all inputted trailers are removed
      And the ASW table trailers are removed
      And the option to add a trailers is available

  Scenario: reset trailer list with calculation
    Given a user has added one or more trailers to the application
      And they have calculated the ASW
     When they choose to reset the trailer list
     Then all inputted trailers are removed
      And the ASW table trailers are removed
      And Any calculation results are removed
      And the option to add a trailers is available

@orv2-3276-19
Rule: The choice and order of allowable trailers is determined by the chosen commodity, and selected power unit

 # see STOW trailer list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B9C8D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Trailer%20List%2020170825.xlsx&action=default&mobileredirect=true

@orv2-3276-20
Rule: The chosen trailers are shown in the application form in the order they were added
@orv2-3276-21
Rule: The selection of trailers must adhere to an allowable order of jeep first, trailer second, then booster last

 # see STOW trailer list: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B9C8D6E3E-2C8E-4F2D-8E3C-1F4D1C8D6A3F%7D&file=Single%20Trip%20Overweight%20Trailer%20List%2020170825.xlsx&action=default&mobileredirect=true 

@orv2-3276-22
Rule: If jeep(s) and or booster(s) are allowable one or more jeep(s) or booster(s) may be added to the trailer list
@orv2-3276-23
Rule: A chosen trailer(s) determines the remaining allowable trailers shown

  Scenario Outline: brush cutters
    Given a user has chosen the <commodity> 
      And a <power unit> is chosen
     When a user adds <trailer 1>
     Then the allowable <trailer 2> is shown

  Examples:
    | commodity                 | power unit            | trailer 1                | trailer 2     |
    | Laminated Beams           | Truck Tractors        | Jeep                     | Semi-Trailers |
    | Fixed Equipment           | Truck Tractors        | Semi-Trailers            | Booster       |
    | Empty                     | Picker Truck Tractors | Semi-Trailers - Wheelers | Booster       |

  Scenario: axle unit description
     When the ASW table is shown
     Then users can choose to see a description of the difference between axle unit and no. of axles

  Scenario: calculation errors on continue
    Given a user has inputted all mandatory ASW fields
     When they choose to continue to review and confirm
      And there are calculation errors
     Then they stay on the application form
      And the calculation results shown
      And they are directed to the first calculation error
      And the first calculation error is indicated
      And they cannot continue

  Scenario: only PU needs trailer
    Given a user has inputted all mandatory ASW fields for power unit only
      And there are calculation errors because trailers are missing
     When they choose to continue to review and confirm
     Then they stay on the application form
      And the calculation results shown
      And they are directed to the trailer section
      And the trailer section is indicated
      And they cannot continue

# Trip Details
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

@orv2-3276-24
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

@orv2-3276-25
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

@orv2-3276-26
Rule: Total distance resolves to 2 decimal places

  Scenario: input 100.555
    Given a user input 100.555
     When they leave the field
     Then they see 100.55

@orv2-3276-27
Rule: Users must input at least one trip sequence step

  Scenario: no sequence is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter at least one highway."
      And the mandatory field is indicated

@orv2-3276-28
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

@orv2-3276-29
Rule: A maximum of 32 sequence steps may be inputted
@orv2-3276-30
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

@orv2-3276-31
Rule: Show sequence information box
@orv2-3276-32
Rule: Users must input specific route details

  Scenario: no specific route details is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-3276-33
Rule: Users may optionally input application notes

  Scenario: notes inputted
     When a user inputs "These are my notes" into application notes
      And continues
     Then the  application note "These are my notes" are saved with the application

# Application Notes
@orv2-3276-34
Rule: Show application notes info box
@orv2-3276-35
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                                   |
       | Company information edit message                                    |
       | Company mailing Address of permitee                                 |
       | Contact information submitted in Permit Application                 |
       | Permit details submitted in Permit Application                      |
       | Selected CVSE Forms listed with links to the source of truth        |
       | Commodity details submitted in Permit Application                   |
       | Vehicle information submitted in Permit Application                 |
       | Axle Spacings and Weights table submitted in the permit application |
       | Vehicle configuration diagram                                       |
       | Calculation results                                                 |
       | Trip details submitted in the permit application                    |
       | Application notes if submitted in the permit application            |
       | Permit fee summary                                                  |

@orv2-3276-36
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-3276-37
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page
