Feature: User Apply for Non-Resident Quarterly Trip ICBC Basic Insurance

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-2735-1
Rule: A quarterly permit end date falls on the last date of the calendar quarter that includes the start date 

  Scenario: choose 2024/05/10
     When a user chooses a start date of 2024/05/10
     Then their permit expiry date is June 30, 2024

 # see common date rules:  https://vscode.dev/github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Permit%20start%20and%20duration.feature#L18

@orv2-2735-2
Rule: CVSE Form APV96 Insurance Certificate Conditions(May 2021) is chosen by default and attached consecutively beginning after the final page of the issued permit

@orv2-2735-3
Rule: Users may only input a power unit allowable for a Non-Resident Quarterly Trip ICBC Basic
Insurance permit manually or chosen from inventory

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
       | Province / State    |
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

  Scenario: bc plated
    Given a user chooses "British Columbia" as Province / State
     When they choose to continue
     Then they see "BC plated vehicles don't require this permit."
      And they can not continue

# see common save vehicle to inventory rules here: https://github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Save%20or%20update%20a%20vehicle%20to%20inventory.feature

@orv2-2735-4
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

@orv2-2735-5
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-2735-6
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display Non-Resident Quarterly Trip ICBC Basic Insurance fuel permit application details summary
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
       | Vehicle information submitted in Permit Application           |
       | Third Party Liability submitted in the permit application     |

@orv2-2735-7
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-2735-8
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-2735-9
Rule: A Non-Resident Quarterly ICBC Basic Insurance permit fee is a flat rate based on the chosen third party liability

 Scenario: view fee summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton fee for the permit application that includes a <description> and <price>

   Examples:
     | Description                         | Price    |
     | Quarterly ICBC Basic Insurance (FR) | $843.00  |
     | Quarterly ICBC Basic Insurance (FR) | $899.00 |

 Scenario: choose general goods
     When they continue to "Review and Confirm Details" page
     Then their permit fee is $843.00

  Scenario: choose dangerous goods
     When they continue to "Review and Confirm Details" page
     Then their permit fee is $899.00

# below rules will soon be removed and saved as common in a single feature file

@orv2-2735-10
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

@orv2-2735-11
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page


