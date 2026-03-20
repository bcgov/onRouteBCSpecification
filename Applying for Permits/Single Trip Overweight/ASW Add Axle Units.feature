@orv2-5269 https://moti-imb.atlassian.net/browse/ORV2-5269
Feature: As a user when I add certain vehicle configurations to a STOW permit template I need to be able to add axle units for either the power unit or trailers to the ASW table, so that I can enter all the axle spacings and weights details for the load and trip I am applying for.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5269-1
Rule: users can optionally add axle units for vehicle configurations that allow it to the ASW table when applying for a STOW permit template.

 # See Commodity to Vehicle to Trailer Mapping Tab for all allowable vehicle configurations that can have additional axle units: https://bcgov.sharepoint.com/:x:/r/teams/04314/Shared%20Documents/Product%20Team%20(ORBC)/onRouteBC%20Policy%20Data/Over%20Weight%20Dimension%20Set.xlsx?d=w881efcec946246d8a9081e7df42f113a&csf=1&web=1&e=hV9UD3

  Scenario: crane - all terrain
     When a user has selected a crane - all terrain power unit
     Then they have the option to add axle units for the power unit 

  Scenario: truck tractor with steering dolly
     When a user has selected a truck tractor power unit with a steering dolly trailer
     Then they have the option to add axle units for the steering dolly trailer but not the truck tractor power unit

  Scenario: picker truck tractor with dolly
     When a user has selected a picker truck tractor power unit with a dolly trailer
     Then they have the option to add axle units for the dolly trailer but not the picker truck tractor power unit

@orv2-5269-2
Rule: users can optionally remove axle units they have added to the ASW table

  Scenario: user removes axle units from ASW table
    Given a user has added axle units to the ASW table for a vehicle configuration that allows axle units
     When the user clicks the remove button for an axle unit entry in the ASW table
     Then the axle unit entry is removed from the ASW table

@orv2-5269-3
Rule: users can hover on the add axle unit button to see a tooltip with information about adding axle units

  Scenario: add axle unit
    When a user hovers on the add axle unit button for a vehicle configuration that allows axle units
    Then they see "Add Axle Unit" tooltip

  Scenario: remove axle unit
     When a user hovers on the remove axle unit button for an axle unit entry in the ASW table
     Then they see "Remove Axle Unit" tooltip

@orv2-5269-4
Rule: there is no limit to the number of axle units a user can add for a vehicle configuration that allows axle units

  Scenario: user adds multiple axle units
    Given a user has selected a vehicle configuration that allows axle units
     When the user clicks the add axle unit button multiple times
     Then a new axle unit entry is added to the ASW table

# Notes:
- Crane - All Terrain - add AUs
	- Dollies - add AUs
- Cranes - Mobile - no AUs
	- Dollies - add AUs
- Concrete Pumpers - add AUs
- Truck tractors - no AUs
	- Steering Trailers - Manned - change to Steering Dollies 
		- add AUs
		- can be behind Jeep but Jeep can't add axle units
		- can have booster no AUs
	- Steering Trailers - Self/Remote - change Steering Dollies
		- add AUs
		- can be behind Jeep but Jeep can't add axle units
		- can have booster no AUs
	- Platform Trailers
		- add AUs
		- can be behind Jeep but Jeep can't add axle units
		- can have booster no AUs
	- Platform Trailers - Wheelers
		- add AUs
		- can be behind Jeep but Jeep can't add axle units
		- can have booster no AUs
	- Dollies - add AUs
- Picker Truck Tractor - no AUs
	- same as truck tractor