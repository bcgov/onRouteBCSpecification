Feature: As user I need to permit a Long Combination Vehicle (LCV) so that I can legally move this power unit vechile sub-type.

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-1490-1
Rule: LCV vehicles are shown in permit applications if the CV Client is designated as LCV capable

  Scenario: LCV capable CV Client
    Given CV Client has the LCV designation
     When a user applies for a permit
     Then they see the following additional power unit vehicle sub-types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |
      And the vehicle can be saved to the vehicle inventory

  Scenario: CV Client is not LCV capable
    Given CV Client does not have the LCV designation
     When a user applies for a permit
     Then they do not see the following additional power unit vehicle sub-types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |

@orv2-1490-2
Rule: CVSE1014 is attached to the issued permit document when an LCV is chosen as the permit vehicle type

  Scenario: LCV vehicle is chosen
    Given CV Client is LCV capable
     When a user chooses aany LCV power unit vehicle sub-type at the permit application vehicle:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |
     Then the CVSE1014 is attached to the generated permit pdf

@orv2-1490-6
Rule: CVSE1014 not available if an LCV vehicle is not chosen

  Scenario: LCV vehicle chosen
     When a user chooses an LCV vehicle sub-type
     Then they see "LCV Operating Conditions & Routes" CVSE form
      And it is selected
      And it cannot be deselected

  Scenario: LCV vehicle not chosen
     When a user does not choose an LCV vehicle sub-type
     Then they do not see "LCV Operating Conditions & Routes" CVSE form

@orv2-1490-3
Rule: LCV vehicles can be added to the CV Clients vehicle inventory from the permit application

  Scenario: in permit applications
    Given CV Client is LCV capable
     When a user chooses an LCV vehicle sub-type
     Then they can save the LCV to their vehicle inventory

  Scenario: in vehicle inventory
    Given CV Client is LCV capable
     When a user chooses to create a new vehicle
     Then they see the following additional power unit vehicle sub-types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |


