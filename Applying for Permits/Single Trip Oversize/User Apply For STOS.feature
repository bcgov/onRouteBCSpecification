Feature: Apply for Single Trip Oversize Permit

Users = CA, PA, SA, PC, CTPO, Trainee

@orv2-2254-1 @orv2-2387-1 @orv2-4015-24 @orv2-2560-8 @orv2-2561-7
Rule: Single trip permits are issued to the power unit only

  Scenario: choose vehicle type
     When a user chooses to change vehicle type
     Then they can not change vehicle type

  Scenario: recall trailer
     When a user chooses to recall a trailer
     Then they can not recall the trailer

@orv2-2254-3 @orv2-2387-3 @orv2-4015-25 @orv2-2560-9 @orv2-2561-8
Rule: CVSE Forms 1000 and 1070 are chosen by default and attached consecutively beginning after the final page of the issued permit

@orv2-2254-4 @orv2-2387-4 @orv2-4015-26 @orv2-2560-10 @orv2-2561-9
Rule: CVSE Forms may be optionally chosen for attachment to the issued permit

  Scenario: choose an option cvse form
     When a user choose to attach a cvse form the following list:
      | Routes Pre-Approved for 5.0 m OAW CVSE-1001                          |
      | General Permit Conditions to 6.1 m in the Peace River Area CVSE-1002 |
      | East-West Overheight Corridors in the Lower Mainland CVSE-1010       |
      | Routes for Wood Chip & Residual CVSE-1012                            |
      | Restricted Routes for Wide Bunks Hauling Wood CVSE-1013              |
      | LCV Operating Conditions & Routes CVSE-1014                          |
     Then the chosen cvse form is attached consecutively beginning after the final page of the issued permit

@orv2-2254-5 @orv2-2387-5 @orv2-4015-27 @orv2-2560-11 @orv2-2561-10
Rule: Users must input a commodity allowable for an STOS permit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

  Scenario: no commodity inputted
     When a users chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-2254-6 @orv2-2387-6 @orv2-4015-28 @orv2-2560-12 @orv2-2561-11
Rule: Users can search for a commodity allowable for an STOS permit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

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
       
@orv2-2254-7 @orv2-2387-7 @orv2-4015-29 @orv2-2560-13 @orv2-2561-12
Rule: Users can scroll the list of commodities allowable for an STOS permit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

@orv2-2254-8 @orv2-2387-8 @orv2-3902-2 @orv2-4015-30 @orv2-2560-14 @orv2-2561-13 
Rule: Users may change the chosen commodity

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

@orv2-2254-9 @orv2-2387-9 @orv2-4015-31 @orv2-2560-15 @orv2-2561-14
Rule: Users must input a load description

  Scenario: no load description inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-3902-1 @orv2-4015-32 @orv2-2560-16 @orv2-2561-15
Rule: User can add a power unit only when a commodity is chosen

  Scenario: arrive
     When a user arrives at a new STOS permit application
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

@orv2-2254-10 @orv2-2387-10 @orv2-4015-33 @orv2-2560-17 @orv2-2561-16
Rule: Users may only input one power unit allowable for an STOS permit manually or chosen from inventory 

 # see STOS dimension set

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

@orv2-2254-11 @orv2-2387-11 @orv2-4015-34 @orv2-2560-18 @orv2-2561-17
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

@orv2-2254-12 @orv2-2387-12 @orv2-4015-35 @orv2-2560-19 @orv2-2561-18
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-2254-13 @orv2-2387-13 @orv2-4015-36 @orv2-2560-20 @orv2-2561-19
Rule: Details of the chosen power units are shown in the application form

  Scenario: Mexico as country
    Given a user chose Mexico a the power unit country
     When they add the power unit
     Then they see "Mexico" as they Province / State

@orv2-2254-14 @orv2-2387-14 @orv2-4015-37 @orv2-2560-21 @orv2-2561-20
Rule: Users may remove and change the power unit from the application

  Scenario: no pu
     When a user chooses to remove the power unit
     Then they do not have the option to remove the power unit

  Scenario: pu exists
     When a user chooses to removed the power unit
     Then they have the option to remove the power unit

  Scenario: pu exists removed
     When a user chooses to remove a power unit
     Then all inputted power unit information is removed
      And all inputted loaded dimensions is removed
      And all inputted trailer information is removed

@orv2-2254-15 @orv2-2387-15 @orv2-4015-38 @orv2-2560-22 @orv2-2561-21
Rule: Users must choose from a list of allowable trailers

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B316994BE-0B19-4F0B-8569-0E74D6F9E719%7D&file=Single%20Trip%20Oversize%20Dimension%20Set.xlsx&action=default&mobileredirect=true 

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

@orv2-2254-16 @orv2-2387-16 @orv2-4015-39 @orv2-2560-23 @orv2-2561-22
Rule: The selection of trailers must adhere to an allowable order of jeep first, trailer second, then booster last

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B316994BE-0B19-4F0B-8569-0E74D6F9E719%7D&file=Single%20Trip%20Oversize%20Dimension%20Set.xlsx&action=default&mobileredirect=true

@orv2-2254-18 @orv2-2387-18 @orv2-4015-40 @orv2-2560-24 @orv2-2561-23
Rule: If jeep(s) and or booster(s) are allowable one or more jeep(s) or booster(s) may be added to the trailer list

@orv2-2254-40 @orv2-2387-40 @orv2-4015-41 @orv2-2560-25 @orv2-2561-24
Rule: A chosen trailer(s) determines the remaining allowable trailers shown 

  Scenario Outline: brush cutters
    Given a user has chosen the <commodity> 
      And a <power unit> is chosen
     When a user adds <trailer 1>
     Then the allowable <trailer 2> is shown

  Examples:
    | commodity                 | power unit             | trailer 1     | trailer 2                                                                    |
    | Brushcutters (Peace Only) | Truck Tractors         | Jeep          | Semi-Trailers - Single Drop, Double Drop, Step Decks, Lowbed, Expandos, etc. |
    | Brushcutters (Peace Only) | Truck Tractors         | Semi-Trailers |
    | None                      | Concrete Pumper Trucks | None          | Booster                                                                      |                                                                        |

@orv2-2254-17 @orv2-2387-17 @orv2-4015-42 @orv2-2560-26 @orv2-2561-25
Rule: The choice and order of allowable trailers is determined by the chosen commodity, and selected power unit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B316994BE-0B19-4F0B-8569-0E74D6F9E719%7D&file=Single%20Trip%20Oversize%20Dimension%20Set.xlsx&action=default&mobileredirect=true

@orv2-2254-18 @orv2-2387-18 @orv2-4015-43 @orv2-2560-27 @orv2-2561-26
Rule: The chosen trailers are shown in the application form in the order they were added

@orv2-2254-19 @orv2-2387-19 @orv2-4015-44 @orv2-2560-28 @orv2-2561-27
Rule: Users may remove all added trailers from the application

  Scenario: trailers added
     When a user chooses to reset trailer configuration
     Then all existing trailers are removed

  Scenario: no trailers added
     When a user chooses to reset trailer configuration
     Then they do not have the option to reset trailer configuration

@orv2-2254-20 @orv2-2387-20 @orv2-4015-45 @orv2-2560-29 @orv2-2561-28
Rule: There is no limit to the number of trailers that can be added to the application

@orv2-2254-21 @orv2-2387-21 @orv2-4015-46 @orv2-2560-30 @orv2-2561-29
Rule: Users must input load dimensions as numbers

  Scenario: no loaded dimensions inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

  Scenario: text inputted
    Given no data in in overall width
     When a user inputs "five"
     Then "five" is not accepted 
      And overall width is empty

@orv2-4064-1 @orv2-4015-47 @orv2-2560-31 @orv2-2561-30
Rule: Accept the numeral 0 in front and rear projection loaded dimensions

@orv2-2254-22 @orv2-2387-22 @orv2-4015-48 @orv2-2560-32 @orv2-2561-31
Rule: Load dimensions are a decimal number rounded to 2 decimal places

  Scenario: 35
    Given a user inputs 35 in overall width
     When they tab to the next field
     Then they see 35.00 in overall width

@orv2-2254-23 @orv2-2387-23 @orv2-3966-1 @orv2-4015-49 @orv2-2560-33 @orv2-2561-32
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

@orv2-2254-24 @orv2-2387-24 @orv2-4015-50 @orv2-2560-34 @orv2-2561-33
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

@orv2-2254-27 @orv2-2387-27 @orv2-4015-51 @orv2-2560-35 @orv2-2561-34
Rule: Users must input at least one trip sequence step

  Scenario: no sequence is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter at least one highway."
      And the mandatory field is indicated

@orv2-2254-28 @orv2-2387-28 @orv2-4015-52 @orv2-2560-36 @orv2-2561-35
Rule: A maximum of 32 sequence steps may be inputted

@orv2-2254-29 @orv2-2387-29 @orv2-4015-53 @orv2-2560-37 @orv2-2561-36
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

@orv2-2254-30 @orv2-2387-30 @orv2-4015-54 @orv2-2560-38 @orv2-2561-37
Rule: Show sequence information box

@orv2-2254-31 @orv2-2387-31 @orv2-4015-55 @orv2-2560-39 @orv2-2561-38
Rule: Users must input specific route details

  Scenario: no specific route details is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-2254-32 @orv2-2387-32 @orv2-4015-56 @orv2-2560-40 @orv2-2561-39
Rule: Users may optionally input application notes

  Scenario: notes inputted
     When a user inputs "These are my notes" into application notes
      And continues
     Then the  application note "These are my notes" are saved with the application

@orv2-2254-33 @orv2-2387-33 @orv2-4015-57 @orv2-2560-41 @orv2-2561-40
Rule: Show application notes info box

@orv2-2254-34 @orv2-2387-34 @orv2-4015-58 @orv2-2560-42 @orv2-2561-41
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                             |
       | Company information edit message                              |
       | Company mailing Address of permitee                           |
       | Contact information submitted in Permit Application           |
       | Permit details submitted in Permit Application                |
       | Selected commodities listed with links to the source of truth |
       | Commodity details submitted in Permit Application             |
       | Vehicle information submitted in Permit Application           |
       | Loaded dimensions submitted in the permit application         |
       | Trip details submitted in the permit application              |
       | Application notes if submitted in the permit application      |

@orv2-2254-35 @orv2-2387-35 @orv2-4015-59 @orv2-2560-43 @orv2-2561-42
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-2254-36 @orv2-2387-36 @orv2-4015-60 @orv2-2560-44 @orv2-2561-43
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-2254-37 @orv2-2387-37 @orv2-4015-61 @orv2-2560-45 @orv2-2561-44
Rule: A single trip permit fee is $15 per permit 

 Scenario: Display fee summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for the permit application that includes a <description> and <price>

   Examples:
     | Description          | Price   |
     | Single Trip Oversize | $15.00 |

 Scenario: Fee calculation
     Given a user has completed a Single Trip Permit Application
     When they continue to "Review and Confirm Details" page
     Then the permit fee is calculated as $15

@orv2-2254-38 @orv2-2387-38 @orv2-4015-62 @orv2-2560-46 @orv2-2561-45
Rule: The user must complete the attestations

 Scenario: Attestations
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see a list of attestations they are required to check in order to proceed to pay
       | Confirm that this permit is issued to the registered owner (or lessee) of the vehicle being permitted. |
       | Confirm compliance with the appropriate policy for the selected vehicle(s) and/or commodity(s).        |
       | Confirm the information in this application is correct.                                                |

 Scenario: Attestations warning
     Given a user has not checked one or more attestations
     When they choose to continue
     Then they see "Checkbox selection is required"
      And the checkboxes are indicated

@orv2-2254-39 @orv2-2387-39 @orv2-4015-63 @orv2-2560-47 @orv2-2561-46
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page

# Add directed to Applications in Review on submission