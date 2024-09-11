Feature: Apply for Single Trip Oversize Permit

Users = CA, PA, SA, PC, CTPO, Trainee

@orv2-2254-1 @orv2-2387-1
Rule: Single trip permits are issued to the power unit only

@orv2-2254-2 @orv2-2387-2
Rule: Users are required to choose a permit length in increments of one day, with a maximum of 7 days from their chosen start date

@orv2-2254-3 @orv2-2387-3
Rule: CVSE Forms 1000 and 1070 are chosen by default and attached consecutively beginning after the final page of the issued permit

@orv2-2254-4 @orv2-2387-4
Rule: CVSE Forms may be optionally chosen for attachement to the issued permit

  Scenario: choose an option cvse form
     When a user choose to attach a cvse form the following list:
      | Routes Pre-Approved for 5.0 m OAW CVSE-1001                          |
      | General Permit Conditions to 6.1 m in the Peace River Area CVSE-1002 |
      | East-West Overheight Corridors in the Lower Mainland CVSE-1010       |
      | Routes for Wood Chip & Residual CVSE-1012                            |
      | Restricted Routes for Wide Bunks Hauling Wood CVSE-1013              |
      | LCV Operating Conditions & Routes CVSE-1014                          |
     Then the chosen cvse form is attached consecutively beginning after the final page of the issued permit

@orv2-2254-5 @orv2-2387-5
Rule: Users must input a commodity allowable for an STOS permit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

  Scenario: no commodity inputted
     When a users chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-2254-6 @orv2-2387-6
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
       
@orv2-2254-7 @orv2-2387-7
Rule: Users can scroll the list of commodities allowable for an STOS permit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

@orv2-2254-8 @orv2-2387-8
Rule: Users may change the chosen commodity

  Scenario: vehicles exist warning
    Given vehicles have been added to the permit application
     When a user chooses to chnage the commodity
     Then they see "Changing your commodity will require you to reenter your vehicle information."

  Scenario: vehicles exist confirm change
    Given a user initiated a commodity change
     When a user chooses to continue
     Then the commodity type is removed 
      And all inputted vehicle information is removed
      And all inputted loaded dimensions is removed

@orv2-2254-9 @orv2-2387-9
Rule: Users must input a load description

  Scenario: no load description inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-2254-10 @orv2-2387-10
Rule: Users may only input one power unit allowable for an STOS permit manually or chosen from inventory 

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

  Scenario: pu added
     When a user chooses to add a power unit
     Then they do not have the option to add a power unit

  Scenario: no pu added
     When a user chooses to add a power unit
     Then they have the option to add a power unit

@orv2-2254-11 @orv2-2387-11
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

@orv2-2254-12 @orv2-2387-12
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-2254-13 @orv2-2387-13
Rule: Details of the chosen power units are shown in the application form

  Scenario: Mexico as country
    Given a user chose Mexico a the power unit country
     When they add the power unit
     Then they see "Mexico" as they Province / State

@orv2-2254-14 @orv2-2387-14
Rule: Users may remove a power unit from the application

  Scenario: no pu
     When a user chooses to remove the power unit
     Then they do not have the option to remove the power unit

  Scenario: pu exists
     When a user chooses to removed the power unit
     Then they have the option to remove the power unit

@orv2-2254-15 @orv2-2387-15
Rule: Users must choose from a list of allowable trailers

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

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
     Then they see "This is a required field"
      And add trailer is indicated

  Scenario: reached limit of allowable trailers 
      When a user adds trailers to the application
       And there are no allowable additional trailers  
      Then there is no option to add another trailer
       And they see the option to reset the list

@orv2-2254-16 @orv2-2387-16
Rule: The selection of trailers must adhere to an allowable order

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

@orv2-2254-17 @orv2-2387-17
Rule: The choice and order of allowable trailers is determined by the STOS permit type, chosen commodity, and selected power unit

 # see STOS dimension set: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B39CC3A68-857D-404F-A5BA-B874BCD38907%7D&file=Single%20Trip%20Oversize%20Dimension%20Set%2020170825.xlsx&action=default&mobileredirect=true 

@orv2-2254-18 @orv2-2387-18
Rule: The chosen trailers are shown in the application form in the order they were added

@orv2-2254-19 @orv2-2387-19
Rule: Users may remove all added trailers from the application

  Scenario: trailers added
     When a user chooses to reset trailer configuration
     Then all exsiting trailers are removed

  Scenario: no trailers added
     When a user chooses to reset trailer configuration
     Then they do not have the option to reset trailer configuration

@orv2-2254-20 @orv2-2387-20
Rule: There is no limit to the number of trailers that can be added to the application

@orv2-2254-21 @orv2-2387-21
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

@orv2-2254-22 @orv2-2387-22
Rule: Load dimensions are a decimal number rounded to 2 decimal places

  Scenario: 35
    Given a user inputs 35 in overall width
     When they tab to the next field
     Then they see 35.00 in overall width

@orv2-2254-23 @orv2-2387-23
Rule: Users must input an origin and destination chosen from the resolved geocoder list

  Scenario: no origin, destination and exit point is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter a valid address."
      And the mandatory field is indicated

  Scenario: user inputted text
    Given a user has inputted text in origin, destination or exit point
      And has not chosen a resolved address from the geocoder list 
     When they chose to continue
     Then they cannnot continue
      And they see "You must enter a valid address."
      And the mandatory field is indicated

@orv2-2254-24 @orv2-2387-24
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

@orv2-2254-27 @orv2-2387-27
Rule: Users must input at least one trip three character sequence step

  Scenario: no sequence is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter at least one highway."
      And the mandatory field is indicated

@orv2-2254-28 @orv2-2387-28
Rule: A maximum of 32 sequence steps may be inputted

@orv2-2254-29 @orv2-2387-29
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
      And they are each numbered started at 1

@orv2-2254-30 @orv2-2387-30
Rule: Show sequence information box

@orv2-2254-31 @orv2-2387-31
Rule: Users must input specific route details

  Scenario: no specific route details is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field"
      And the mandatory field is indicated

@orv2-2254-32 @orv2-2387-32
Rule: Users may optionally input application notes

  Scenario: notes inputted
     When a user inputs "These are my notes" into application notes
      And continues
     Then the  application note "These are my notes" are saved with the application

@orv2-2254-33 @orv2-2387-33
Rule: Show application notes info box

@orv2-2254-34 @orv2-2387-34
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

@orv2-2254-35 @orv2-2387-35
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-2254-36 @orv2-2387-36
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-2254-37 @orv2-2387-37
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

@orv2-2254-38 @orv2-2387-38
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

@orv2-2254-39 @orv2-2387-39
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page




# Add directed to Applications in Review on submission