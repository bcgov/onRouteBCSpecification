Feature: As CV Client I need to permit a Long Combination Vehicle (LCV) so that I can legally move this vehicle.

CV Client = CA, PA

@orv2-1532-1
Rule: LCV vehicles are shown in permit applications if the CV Client is designated as LCV capable

  Scenario: LCV capable CV Client
    Given CV Client has the LCV designation
     When they apply for a permit
     Then they see the following additional vehicle types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |
      And the vehicle can be saved to their vehicle inventory

  Scenario: CV Client is not LCV capable
    Given CV Client does not have the LCV designation
     When they apply for a permit
     Then they do not see the following additional vehicle types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |

@orv2-1532-2
Rule: CVSE1014 is attached to the issued permit document when an LCV is chosen as the permit vehicle type

  Scenario: LCV vehicle is chosen
    Given CV Client is LCV capable
     When they choose any LCV as the permit vehicle:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |
     Then the CVSE1014 is attached to the generated permit pdf

@orv2-1532-3
Rule: LCV vehicles can be added to the CV Clients vehicle inventory

  Scenario: in permit applications
    Given CV Client is LCV capable
     When they choose an LCV
     Then they can save the LCV to their vehicle inventory

  Scenario: in vehicle inventory
    Given CV Client is LCV capable
     When they choose to create a new vehicle
     Then they see the following additional vehicle types:
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles |
       | Long Combination Vehicles (LCV) - Turnpike Doubles       |


