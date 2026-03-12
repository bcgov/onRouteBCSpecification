@orv2-5245 https://moti-imb.atlassian.net/browse/ORV2-5245
Feature: As a user I want to be able to view the ASW table upon inputting my commodity and vehicle configuration that so that I can input the axle spacings and weights for the load and vehicle that I want permitted.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5245
Rule: The ASW table is updated when power unit or trailer(s) are added, removed or changed
  
  Scenario: truck tractor added
     When a user adds a truck tractor power unit
     Then axle units 1 and 2 are shown in the ASW table
      And they see the axle unit section header "Truck Tractor"

  Scenario: trailer added
    Given a user has added a power unit
     When they add a trailer
     Then they see the ASW table is shown with the power unit and trailer
      And they see the axle unit section header "Trailer 1"

@orv2-5245
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

@orv2-5245
Rule: The default tire size is 279.4 for all axle units

  Scenario: new table
    Given a user has added a power unit
     When they view the ASW table
     Then they see that the default tire size for all axle units is 279.4 mm

@orv2-5245
Rule: The default number of axles is 1 for all axle units

  Scenario: new table
    Given a user has added a power unit
     When they view the ASW table
     Then they see that the default number of axles for all axle units is 1

@orv2-5245
Rule: Users can see conversion facts when ASW table is shown

  Scenario: ASW table shown  
     When they ASW table is shown
     Then they see: "Conversion facts: 1 mm = 0.1 cm; 1 inch = 2.54 cm; 1 lb = 0.455 kg; 1 ft = 0.305 m."

@orv2-5245
Rule: Users can see a legend for the ASW table when ASW table is shown

  Scenario: ASW table shown  
     When the ASW table is shown
     Then users see "Legend: Interaxle Spacing (SPC); Axle Spread (SPD); Gross Combination Vehicle Weight (GCVW)"

@orv2-5245
Rule: User can choose to see a description of axle unit and no. of axles when ASW table is shown

