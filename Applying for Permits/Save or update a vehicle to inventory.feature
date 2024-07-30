Feature: Save or update a vehicle to inventory from a permit application

User = CA, PA, SA, PC, CTPO, Tainee

@orv2-2574, @orv2-2388, @orv2-1095-19, @orv2-551-5
Rule: A user may optionally save a new vehicle to inventory from a permit application

 Scenario: Save new vehicle to "Vehicle Inventory"
     Given The CV Client manually inputted their "Vehicle Information"
     When the VIN an existing VIN in their "Vehicle Inventory"
     And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
     Then the Vehicle will be added to their "Vehicle Inventory" when they select "continue"
     And if they select NO the vehicle will not be saved to their "Vehicle Inventory"

@orv2-2574, @orv2-2388, @orv2-1095-19, @orv2-551-5
Rule: A user may optionally update an existing vehicle to inventory from a permit application

   Scenario: Update existing vehicle to "Vehicle Inventory"
     Given The CV Client manually inputted their "Vehicle Information"
     When the VIN does match an existing VIN in their "Vehicle Inventory"
     And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
     Then the Vehicle will update the previously existing Vehicle to their "Vehicle Inventory" when they select "continue"
     And if they select NO the vehicle will not be updated in their "Vehicle Inventory"

@orv2-2574, @orv2-2388, @orv2-1095-19, @orv2-551-5
Rule: A cv client vehicle is updated if the inputted VIN matches an existing vehicle in their inventory
