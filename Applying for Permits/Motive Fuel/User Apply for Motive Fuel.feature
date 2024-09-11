@tagPlaceholder1 @tagPlaceholder2
Feature: User Apply for a Motive Fuel Permit

User = CA, PA, SA, PC, CTPO, Trainee

Rule: Motive fuel permits are issued to the power unit only

Rule: Users are required to choose a permit length in increments of one day, with a maximum of 7 days from their chosen start date

Rule: CVSE Forms MV4001 are chosen by default and attached consecutively beginning after the final page of the issued permit

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


Rule: Users must input an origin, destination and exit point chosen from the resolved geocoder list

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
       | Loaded dimensions submitted in the permit application         |
       | Trip details submitted in the permit application              |
       | Application notes if submitted in the permit application      |

Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

Rule: A motive fuel permit fee is is calculated at $0.11 per km if greater than $20

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

Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page
