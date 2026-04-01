Feature: User Apply for Non-Resident Single Trip License

User = CA, PA, SA, PC, CTPO, Trainee
@orv2-2818-1
Rule: Users are required to choose a permit length in increments of one day, with a maximum of 30 days from their chosen start date

 # see common date rules:  https://vscode.dev/github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Permit%20start%20and%20duration.feature#L18

@orv2-2818-2
Rule: CVSE Form APV96 Insurance Certificate Conditions(May 2021) is chosen by default and attached consecutively beginning after the final page of the issued permit
@orv2-2818-3
Rule: Users may only input a power unit allowable for a Non-Resident Single Trip License permit manually or chosen from inventory  

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

 # see common save vehicle to inventory rules here: https://github.com/bcgov/onRouteBCSpecification/blob/main/Applying%20for%20Permits/Save%20or%20update%20a%20vehicle%20to%20inventory.feature

@orv2-2818-5
Rule: Power unit province / state is not available when Mexico is chosen as the country

  Scenario: Mexico chosen
     When a user chooses the country "Mexico"
     Then Province state is not available

@orv2-2818-4
Rule: Users must input a vehicle weight

  Scenario: vehicle sub-type not chosen
     When they have not chosen a vehicle sub-type
     Then vehicle weight options are not available

  Scenario: no input
    Given a user does not input a vehicle weight
     When they choose to continue
     Then they see "This is a required field"
      And the field is indicated
      And they can not continue

  Scenario: input 65,000 (kg)
     When they input 65,000 (kg)
     Then they see "Can't Exceed 63,500"
      And the field is indicated
      And they can not continue

  Scenario: farm tractor
     When a user chooses farm tractor
     Then vehicle weight options are not available

@orv2-2818-12
Rule: User can optionally choose a Conditional Licensing Fee

  Scenario: default selection
     When they start the application process
     Then all conditional license fee options are shown 
      But unavailable
      And the default state is "none"

  Scenario: none
    Given a user has not chosen a Conditional Licensing Fee option
     When they continue to review and confirm
     Then they see the fee calculated based on the annual license fee table for a commercial vehicle based on gross vehicle weight (loaded GVW)

  Scenario: conditional
    Given a user has chosen Conditional license fee rate in accordance with Commercial Transport Fees Regulation Item 3(b)
     When they continue to review and confirm
     Then they see the fee calculated based on the Conditional Licences fee table flat rate

  Scenario: x-plated
    Given a user has chosen a vehicle eligible for Industrial (X-Plate Type) fee rate in accordance with Commercial Transport Fees Regulation Item 2(c)
      And they choose Industrial (X-Plate Type) fee rate in accordance with Commercial Transport Fees Regulation Item 2(c)
     When they continue to review and confirm
     Then they see the fee calculated based on the annual license fee table for a Industrial Machine based on gross vehicle weight (loaded GVW)

  Scenario: farm vehicle
    Given a user has chosen a vehicle eligible for Farm Vehicle fee rate in accordance with Commercial Transport Fees Regulation Item 2(d)
      And they choose Farm Vehicle fee rate in accordance with Commercial Transport Fees Regulation Item 2(d)
     When they continue to review and confirm
     Then they see the fee calculated based on the annual license fee table for a Farm Vehicle based on net vehicle weight (loaded GVW)

   Scenario: farm tractor
    Given a user has chosen a vehicle eligible for Farm Tractor fee rate in accordance with Commercial Transport Fees Regulation Item 2(b)
      And they choose Farm Vehicle fee rate in accordance with Commercial Transport Fees Regulation Item 2(b)
     When they continue to review and confirm
     Then they see the fee calculated based on the annual license fee table table flat rate

@orv2-2818-13
Rule: Conditional license fee (CLF) choice determines available options for vehicle weight (VW)

   Scenario: choosing CLF
      When a user chooses a CLF option
      Then the associated VW options are available:
       | CLF                       | VW            |
       | Industrial (X-Plate Type) | Loaded GVW    |
       | Conditional License       | Loaded GVW    |
       | Farm Vehicle              | Net Weight    |
       | None                      | Loaded GVW    |
       | Farm Tractor              | Not Available |

@orv2-2818-14
Rule: Vehicle sub-type choice determines available options for conditional license fees (CLF)

 # see: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true 

   Scenario: choosing vehicle sub-types
      When a user chooses a vehicle sub-type
      Then the associated CLF options are available:
        | Vehicle Sub-type                                                     | CLF Options                             |
        | Buses/Crummies                                                       | None / Conditional ($12)                |
        | Concrete Pumper Trucks                                               | None / Industrial (X-Plate type) Y/N    |
        | Cranes, Rubber-Tired Loaders, Firetrucks - All Terrain               | None / Industrial (X-Plate type) Y/N    |
        | Cranes, Rubber-Tired Loaders, Firetrucks - Mobile                    | None / Industrial (X-Plate type) Y/N    |
        | Double Decker Buses                                                  | None / Conditional ($12)                |
        | Fixed Equipment - Trucks/Graders etc.                                | None / Industrial (X-Plate type)        |
        | Intercity Buses (Pulling Pony Trailers)                              | None / Conditional ($12)                |
        | Logging Trucks                                                       | None / Conditional ($12)                |
        | Logging Trucks - Off-Highway                                         | None / Conditional ($12)                |
        | Long Combination Vehicles (LCV) - Rocky Mountain Doubles             | None / Conditional ($12)                |
        | Long Combination Vehicles (LCV) - Turnpike Doubles                   | None / Conditional ($12)                |
        | Long Wheelbase Truck Tractors Exceeding 6.2 m up to 7.25 m           | None / Conditional ($12)                |
        | Municipal Fire Trucks                                                | None / Conditional ($12)                |
        | Oil and Gas - Bed Trucks                                             | None / Industrial (X-Plate type)        |
        | Oil and Gas - Oilfield Sows, Oilfield Pumper Trucks & Snubber Trucks | None / Industrial (X-Plate type)        |
        | Oil and Gas - Service Rigs                                           | None / Industrial (X-Plate type)        |
        | Oil and Gas - Service Rigs and Rathole Augers Only ...               | None / Industrial (X-Plate type)        |
        | Picker Truck Tractors                                                | None / Conditional ($12)                |
        | Scrapers                                                             | None / Industrial (X-Plate type)        |
        | Specially Authorized Vehicles                                        | None / Conditional ($12)                |
        | Taxis                                                                | None / Conditional ($12)                |
        | Tow Vehicles                                                         | None / Conditional ($12)                |
        | Truck Tractors                                                       | None / Conditional ($12) / Farm Vehicle |
        | Truck Tractors - Stinger Steered                                     | None / Conditional ($12)                |
        | Trucks                                                               | None / Conditional ($12) / Farm Vehicle |
        | Trucks Equipped with Front or Underbody Plow Blades                  | None / Conditional ($12)                |
        | Farm Tractor                                                         | Farm Tractor default selected           |

@orv2-2818-6
Rule: Show application details inputted by the user prior to submission or adding to cart

 Scenario: Display motive fuel permit application details summary
     Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see permit applicaton header and footer information
     And they see:
       | Please review and confirm warning                                     |
       | Company information edit message                                      |
       | Company mailing Address of permitee                                   |
       | Contact information submitted in Permit Application                   |
       | Permit details submitted in Permit Application                        |
       | Selected commodities listed with links to the source of truth         |
       | Vehicle information submitted in Permit Application                   |
       | Vehicle weight submitted in the permit application                    |
       | Conditional licensing fees option submitted in the permit application |

@orv2-2818-7
Rule: Indication of vehicle saved to inventory is shown if save was chosen

 Scenario: Save vehicle indication
     Given a user chose to save a vehicle submitted in the permit application to inventory
     When they continued from the "Permit Application" page
     Then they see "This vehicle has been added/updated to your Vehicle Inventory."

@orv2-2818-8
Rule: A user can see the source of truth for CVSE forms

 Scenario: Display permit application details summary
     Given a user has continued from the "Permit Application" page
     When they select a "Conditions" link
     Then they are directed to the chosen CVSE Form stored at https://www.cvse.ca/whatsnew.html

@orv2-2818-9
Rule: A Non-Resident Single Trip License permit is 1/12th the fee rate rounded to the nearest dollar calculated using COMMERCIAL TRANSPORT FEES REGULATION tables based on the vehicle type, loaded GVW and conditional license fee if chosen

 # see current fee tables here: https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/328_91

 Scenario: calculate fee
     Given a user has chosen a <vehicle sub-type>, inputted a <loaded gvw> and chosen a <conditional license fee option>
     When they arrive at the "Review and Confirm Details" page
     Then they see <permit applicaton fee> for the permit application

   Examples:
     | vehicle sub-type | loaded gvw | conditional license fee option     | permit application fee |
     | Scraper          | 6000       | none                               | $18.00                 |
     | Scraper          | 6000       | Industrial (X-Plate Type) fee rate | $9.00                  |
     | Truck Tractors   | 24400      | Farm Vehicle fee rate              | $109.00                |
     | Truck Tractors   | 25000      | none                               | $104.00                |

  Scenario: max fee
     When the vehicle weight is equal to or higher then the maximum fee table rate
     Then the maximum fee is charged

Rule: maximimum weight for farm vehicle is 24,400kg

  Scenario: 25,000 kg vehicle weight
     Given a user has chosen a vehicle sub-type of Truck Tractors
     And they have chosend farm vehicle fee rate in accordance with Commercial Transport Fees Regulation Item 2(d)
     When they arrive at the "Review and Confirm Details" pa     
     Then they see "The maximum fee for a farm vehicle is Net weight may not exceed 24,400 kg for a farm vehicle"
      And the fee is calculated based on the maximum weight of 24,400 kg

# below rules will soon be removed and saved as common in a single feature file
@orv2-2818-10
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

@orv2-2818-11
Rule: A user can edit an application 

 Scenario: At "Review abd Confirm Details" page
     Given a user is at the "Review abd Confirm Details" page
     When they choose to edit the application
     Then they are directed to the "Permit Application" page

Rule: Conditional License Fees are available for specific 
