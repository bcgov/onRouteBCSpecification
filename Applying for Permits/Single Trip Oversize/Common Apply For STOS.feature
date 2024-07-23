Feature: Apply for Single Trip Oversize Permit

Users = CA, PA, SA, PC, CTPO, Trainee

@orv2-2574, @orv2-2388
Rule: Users may optionally choose to apply for a single trip oversize permit (STOS)

@orv2-2574, @orv2-2388
Rule: Single trip permits are issued to the power unit only

@orv2-2574, @orv2-2388
Rule: Users are required to choose a permit length in increments of one day, with a maximum of 7 days from the date they submit their application

@orv2-2574, @orv2-2388
Rule: CVSE Forms 1000 and 1070 are chosen by default and attached to the issued permit

@orv2-2574, @orv2-2388
Rule: CVSE Forms may be optionally chosen for attachement to the issued permit

  Scenario: choose an option cvse form
     When a user choose to attach a cvse form the following list:
      | Routes Pre-Approved for 5.0 m OAW CVSE-1001                          |
      | General Permit Conditions to 6.1 m in the Peace River Area CVSE-1002 |
      | East-West Overheight Corridors in the Lower Mainland CVSE-1010       |
      | Routes for Wood Chip & Residual CVSE-1012                            |
      | Restricted Routes for Wide Bunks Hauling Wood CVSE-1013              |
      | LCV Operating Conditions & Routes CVSE-1014                          |
     Then the chosen cvse form is attached to the issued permit pdf

@orv2-2574, @orv2-2388
Rule: Only commodities allowable for an STOS permit may be chosen

@orv2-2574, @orv2-2388
Rule: Users may change the chosen commodity

@orv2-2574, @orv2-2388
Rule: Users must input a load description

@orv2-2574, @orv2-2388
Rule: Users may only input one power unit allowable for an STOS permit may be added or chosen from inventory 

  Scenario: pu exists
    Given 
     When 
     Then 

  Scenario: no pu
    Given 
     When 
     Then 

@orv2-2574, @orv2-2388
Rule: Only vehicles with a licensed GVW of 63,500 (kg) or lower may be added or chosen from inventory

@orv2-2574, @orv2-2388
Rule: Power unit province / state is not available when Mexico is chosen as the country

@orv2-2574, @orv2-2388
Rule: User may optionally save a power unit to vehicle inventory

@orv2-2574, @orv2-2388
Rule: Details of the chosen power units are shown in the application form

@orv2-2574, @orv2-2388
Rule: Users may remove a power unit from the application

@orv2-2574, @orv2-2388
Rule: Users may optionally choose from a list of allowable trailers

  Scenario: no allowable
     When the user has chosen a commodity and power unit with no allowable trailer
     Then there is no option to add a trailer

@orv2-2574, @orv2-2388
Rule: The selection of trailers must adhere to an allowable order

@orv2-2574, @orv2-2388
Rule: The choice and order of allowable trailers is determined by the STOS permit type, chosen commodity, and selected power unit.

@orv2-2574, @orv2-2388
Rule: Details of the chosen trailers are shown in the application form below previously added trailers

@orv2-2574, @orv2-2388
Rule: Users may remove all added trailers from the application

@orv2-2574, @orv2-2388
Rule: There is no limit to the number of trailers that can be added to the application

@orv2-2574, @orv2-2388
Rule: Users must input load dimensions as numbers

@orv2-2574, @orv2-2388
Rule: Load dimensions are a decimal number rounded to 2 decimal places

@orv2-2574, @orv2-2388
Rule: Users must input an origin

@orv2-2574, @orv2-2388
Rule: The origin is resolved and replaces text inputted by the user

@orv2-2574, @orv2-2388
Rule: Users must input an destination

@orv2-2574, @orv2-2388
Rule: The destination is resolved and replaces text inputted by the user

@orv2-2574, @orv2-2388
Rule: Users must input at least one trip three character sequence step

@orv2-2574, @orv2-2388
Rule: A maximum of 32 sequence steps may be inputted

@orv2-2574, @orv2-2388
Rule: Show one row of eight steps with an option to add additional rows of eight steps

@orv2-2574, @orv2-2388
Rule: Show sequence information box

@orv2-2574, @orv2-2388
Rule: Users must input specific route details

@orv2-2574, @orv2-2388
Rule: Users may optionally input application notes

@orv2-2574, @orv2-2388
Rule: Show application notes info box

@orv2-2574, @orv2-2388
Rule: Show application details inputted by the user when continuing