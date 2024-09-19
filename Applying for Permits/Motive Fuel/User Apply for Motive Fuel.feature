Feature: User Apply for a Motive Fuel Permit

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-2608 @orv2-2612
Rule: Users are required to choose a permit length in increments of one day, with a maximum of 7 days from their chosen start date

 # see common date calculation rules:  https://vscode.dev/github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Permit%20duration%20calculation.feature#L16

@orv2-2608 @orv2-2612
Rule: CVSE Form MV4001 is chosen by default and attached consecutively beginning after the final page of the issued permit

@orv2-2608 @orv2-2612
Rule: Users may only input a power unit allowable for a Motive Fuel Permit manually or chosen from inventory

 # see vehicle to permit mapping: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

  Scenario: change vehicle type
     When a user chooses to change vehicle type
     Then they can not change vehicle type

 # see common recall rules here: https://vscode.dev/github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Application%20Vehicle%20Details.feature#L20

  Scenario: recall trailer
     When a user chooses to find a trailer from inventory
     Then they can not find the trailer

  Scenario: manual input vehicle information
    Given the CV Client is at the "Permit Application" page
     When They are at the "Vehicle Information" section
     And  Choose to input their Vehicle Information and not select a previously saved Power unit or Trailer
     Then they fill in the following vehicle information:
       | VIN (last 6 digits) |
       | Plate               |
       | Make                |
       | Year                |
       | Country             |
       | Province            |
       | Vehicle Sub-type    |
       | Licensed GVW (kg)   |

 Scenario: no input to mandatory fields 
     When they do not enter valid data into a <mandatory field>
     Then they see <mandatory field error message> 
     And they wont be able to "continue" until resolved
  
     Examples:
       | mandatory field   | mandatory field error message |
       | VIN               | This is a required field      |
       | Plate             | This is a required field      |
       | Make              | This is a required field      |
       | Year              | This is a required field      |
       | Country           | This is a required field      |
       | Province / State  | This is a required field      |
       | Vehicle Sub-type  | This is a required field      |
       | Licensed GVW (kg) | This is a required field      |

@orv2-2608 @orv2-2612
Rule: Only vehicles with a licensed GVW of 63,500 (kg) or lower may be added or chosen from inventory

  Scenario: manually input 65,000 (kg)
    Given a user has manually inputted a power unit
     When they input 65,000 (kg)
     Then they see "Can't Exceed 63,500"
      And they can not continue

  Scenario: attempt to recall 65,000 (kg)
    Given a user chooses to recall a power unit with a licensed gvw of 65,000 (kg)
     When they search for the power unit
     Then they do not see power units with a licensed gvw greater than 63,500 (kg) in search results

@orv2-2608 @orv2-2612
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-2608 @orv2-2612
Rule: Users must input an origin and destination chosen from the resolved geocoder list

  Scenario: no origin or destination is inputted
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

@orv2-2608 @orv2-2612
Rule: The origin, destination and exit point is resolved and the chosen resolved address replaces text inputted by the user 

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

@orv2-2608 @orv2-2612
Rule: Users must input a total distance in km

  Scenario: no input
     When a user chooses to continue to review and confirm
     Then they can not continue
      And they see "This is a required field."
      And the mandatory field is indicated

  Scenario: text input
    Given a user inputs "eight hundred" in total distance
     When they choose to continue
     Then they can not continue
      And they see "invalid input"
      And the mandatory field is indicated

@orv2-2608 @orv2-2612
Rule: Users must input specific route details

  Scenario: no input
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "This is a required field."
      And the mandatory field is indicated

 # currently seems to crash the page
  Scenario: greater than 500 characters
    Given 
     When 
     Then 

@orv2-2608 @orv2-2612
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display motive fuel permit application details summary
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
       | Trip details submitted in the permit application              |

@orv2-2608 @orv2-2612
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-2608 @orv2-2612
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-2608 @orv2-2612
Rule: A motive fuel permit fee is is calculated at $0.11 per km or a minimum of $20

 Scenario: view fee summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for the permit application that includes a <description> and <price>

   Examples:
     | Description             | Price  |
     | Motive Fuel User Permit | $20.00 |

 Scenario: 200 km
     Given a users total distance is 200 km 
       And the calculated fee is $22.00
     When they continue to "Review and Confirm Details" page
     Then their permit fee is $22.00

  Scenario: 180 km
     Given a users total distance is 180 km 
       And the calculated fee is $19.80
     When they continue to "Review and Confirm Details" page
     Then their permit fee is $20.00

@orv2-2608 @orv2-2612
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

@orv2-2608 @orv2-2612
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page
