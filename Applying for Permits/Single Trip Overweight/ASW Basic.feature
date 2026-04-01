@orv2-5245 https://moti-imb.atlassian.net/browse/ORV2-5245
Feature: As a user I want to be able to view the ASW table upon inputting my commodity and vehicle configuration that so that I can input the axle spacings and weights for the load and vehicle that I want permitted.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5245-1
Rule: The ASW table is updated when power unit or trailer(s) are added, reset/removed and includes section headers for the power unit and trailer(s) as well as interaxle spacing between axle units
  
  Scenario: truck tractor added
     When a user adds a truck tractor power unit
     Then axle units 1 and 2 are shown in the ASW table
      And interaxle spacing between Axle Unit 1 and 2 is shown in the ASW table
      And they see the axle unit section header "Truck Tractor"

  Scenario: trailer added
    Given a user has added a power unit
     When they add a trailer "Jeep"
     Then they see the ASW table is shown with the power unit and trailer
      And interaxle spacing between axles units 2 and 3 is shown in the ASW table
      And they see the axle unit section header "Jeep"

  Scenario: reset trailers
    Given there are trailers shown in the ASW table
     When a user clicks "Reset Trailers"
     Then the trailer axle units are removed from the ASW table
      And the interaxle spacing between the power unit and first trailer is removed from the ASW table
      And the trailer section headers are removed from the ASW table

  Scenario: remove power unit
    Given there is a power unit and trailers shown in the ASW table
     When a user removes the power unit
     Then all axle units are removed from the ASW table
      And all interaxle spacing is removed from the ASW table
      And all section headers are removed from the ASW table

@orv2-5245-2
Rule: Show 1 interaxle spacing row for every 2 axle units

  Scenario: add power unit
     When a user arrives at a new STOW permit application
      And they add a truck tractor power unit
     Then they see 1 interaxle spacing row and input field

  Scenario: add axle unit
     When a user adds an axle unit
     Then they see an interaxle spacing row and input field preceding the newly added axle unit

@orv2-5245-3
Rule: The ASW table section is not visible until a power unit has been added to the application

  Scenario: no pu added
     When a user arrives at a new STOW permit application
     Then the ASW table section is not visible

  Scenario: pu added
    Given a user has added a power unit
     When they view the application form
     Then the ASW table section is visible 
      And the section name is "Axle Spacings and Weights" 
      And the ASW table includes the following columns:
        | Axle Unit             |
        | No. of Axles          |
        | No. of Wheels         |
        | Tire Size (mm)        |
        | Interaxle Spacing (m) |
        | Axle Spread (m)       |
        | Axle Unit Weight (kg) |
      And the ASW table includes the following rows:
        | Axle Unit 1                                           |
        | Interaxle Spacing Between Axle Unit 1 and Axle Unit 2 |
        | Axle Unit 2                                           |
      And the ASW table includes a power unit section header

@orv2-5245-4
Rule: Users can choose from a list of available tire sizes for each axle unit in the ASW table

  Scenario: ASW table shown
    Given a user has added a power unit
     When they view the ASW table
     Then they can choose from a list of available tire sizes for each axle unit:
       | 254 (10")   |
       | 279.4 (11") |
       | 304.8 (12") |
       | 315 (12.4") |
       | 325 (12.8") |
       | 330 (13")   |
       | 355 (14")   |
       | 365 (14.4") |
       | 368 (14.5") |
       | 381 (15")   |
       | 385 (15.2") |
       | 393 (15.5") |
       | 406 (16")   |
       | 425 (16.7") |
       | 431 (17")   |
       | 445 (17.5") |
       | 457 (18")   |
       | 502 (19.8") |
       | 508 (20")   |
       | 520 (20.5") |
       | 525 (20.7") |
       | 550 (21.7") |
       | 609 (24")   |
       | 622 (24.5") |
       | 636 (25")   |
       | 711.2 (28") |
     And the default tire size for all axle units is 279.4 mm

@orv2-5245-5
Rule: The default tire size is 279.4 for all axle units

  Scenario: new table
    Given a user has added a power unit
     When they view the ASW table
     Then they see that the default tire size for all axle units is 279.4 mm

@orv2-5245-6
Rule: The default number of axles is 1 for all axle units

  Scenario: new table
    Given a user has added a power unit
     When they view the ASW table
     Then they see that the default number of axles for all axle units is 1

@orv2-5245-7
Rule: Axle spread is available when there are 2 or more axles in number of axles or number of axles is empty

  Scenario: number of axles is 2
     When a user inputs 2 
     Then axle spread is available
  
  Scenario: number of axles is 1
     When a user inputs 1 
     Then axle spread is not available

  Scenario: number of axles is empty
     When number of axles is empty
     Then axle spread is available

@orv2-5245-8
Rule: Users can see conversion facts when ASW table is shown

  Scenario: ASW table shown  
     When they ASW table is shown
     Then they see: "Conversion facts: 1 mm = 0.1 cm; 1 inch = 2.54 cm; 1 lb = 0.455 kg; 1 ft = 0.305 m."

@orv2-5245-9
Rule: Users can see a legend for the ASW table when ASW table is shown

  Scenario: ASW table shown  
     When the ASW table is shown
     Then users see "Legend: Interaxle Spacing (SPC); Axle Spread (SPD); Gross Combination Vehicle Weight (GCVW)"

@orv2-5245-10
Rule: User can choose to see a description of axle unit and no. of axles when ASW table is shown
@orv2-5245-11
Rule: Keyboard tab order is left to right per row

  Scenario: axle unit 1 to axle unit 2
     Given a user is in axle unit 1 no. of axles
     When they use keyboard tab 6 times
     Then the cursor is at axle unit 2 no. of axles

  Scenario: axle unit 1 to interaxle spacing between axle unit 1 and 2
     Given a user is in axle unit 1 no. of axles
     When they use keyboard tab 5 times
     Then the cursor is at interaxle spacing between axle unit 1 and 2

