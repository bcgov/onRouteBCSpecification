Feature: Amend TROS Application Vehicle Details
   As PPC staff I need to be able to amend an active TROS permit by changing the vehicle plate and vehicle so that I can assist PPC SA or PCs.

@orv2-938-1
Rule: PPC SA and PC can change a TROS permit vehicle plate 

   Scenario: Change vehicle plate
     Given a PPC SA or PC has chosen to change the plate number
      When they update the vehicle plate number
      Then the change is accepted

@orv2-938-2
Rule: PPC SA and PC can change a TROS permit vehicle 

  Scenario: Change vehicle
    Given a PPC SA or PC has chosen to change the vehicle
     When they update the vehicle
     Then the change is accepted

  Scenario: TROS eligible "Power Unit"
    Given a PPC SA or PC is at "Vehicle Details" for a TROS permit application
     When they choose to recall a "Power Unit" from inventory 
     Then they see only "Power Units" eligible for a TROS permit:
       | Concrete Pumper Trucks                                                                                                           |
       | Double Decker Buses                                                                                                              |
       | Fixed Equipment - Trucks/Graders etc.                                                                                            |
       | Intercity Buses (Pulling Pony Trailers)                                                                                          |
       | Logging Trucks                                                                                                                   |
       | Logging Trucks - Off-Highway                                                                                                     |
       | Long Wheelbase Truck Tractors Exceeding 6.2 m up to 7.25 m                                                                       |
       | Oil and Gas - Oilfield Sows                                                                                                      |
       | Oil and Gas - Bed Trucks                                                                                                         |
       | Picker Truck Tractors                                                                                                            |
       | Specially Authorized Vehicles                                                                                                    |
       | Tow Vehicles                                                                                                                     |
       | Truck Tractors                                                                                                                   |
       | Truck Tractors - Stinger Steered                                                                                                 |
       | Trucks                                                                                                                           |
       | Trucks Equipped with Front or Underbody Plow Blades                                                                              |
     And they do not see:
       | Oil and Gas - Service Rigs                                                                                                       |
       | Scrapers                                                                                                                         |
       | Taxis                                                                                                                            |
       | Buses/Crummies                                                                                                                   |
       | Farm Vehicles                                                                                                                    |
       | Cranes, Rubber-Tired Loaders, Firetrucks - All Terrain                                                                           |
       | Cranes, Rubber-Tired Loaders, Firetrucks - Mobile                                                                                |
       | Oil and Gas - Service Rigs and Rathole Augers Only Equipped with Heavy Front Projected Crane (must exceed 14,000 kg tare weight) |
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles                                                                         |
       | Long Combination Vehicles (LCV) - Turnpike Doubles                                                                               |

  Scenario: TROS eligible "Trailer"
    Given a PPC SA or PC is at "Trailer" for a TROS permit application
     When they choose to recall a "Trailer" from inventory 
     Then they see only "Trailers" eligible for a TROS permit:
       | Boosters                                                                                       |
       | Dollies                                                                                        |
       | Fixed Equipment - Conveyors                                                                    |
       | Fixed Equipment - Counter Flow Asphalt Drum Mixers                                             |
       | Fixed Equipment - Pony Trailers                                                                |
       | Fixed Equipment - Portable Asphalt Baghouses                                                   |
       | Fixed Equipment - Semi-Trailers                                                                |
       | Fixed Equipment - Wheeler Semi-Trailers                                                        |
       | Float Trailers                                                                                 |
       | Full Trailers                                                                                  |
       | Jeeps                                                                                          |
       | Legacy Logging Trailer Combinations - Non-TAC B-Trains                                         |
       | Legacy Logging Trailer Combinations - Single Axle Jeeps, Tandem Axle Pole Trailers, Dogloggers |
       | Legacy Logging Trailer Combinations - Single Axle Jeeps, Tri Axle Trailers                     |
       | Legacy Logging Trailer Combinations - Tandem Pole Trailers, Dogloggers                         |
       | Logging Semi-Trailer - Empty, 3.2 m Bunks                                                      |
       | Logging Trailers - Full Trailers, Tri Axle, Quad Axle                                          |
       | Logging Trailers - Overwidth Bunks                                                             |
       | Oil and Gas - Oversize Oilfield Flat Deck Semi-Trailers                                        |
       | Overdimensional Trailers and Semi-Trailers (For Export)                                        |
       | Platform Trailers                                                                              |
       | Pole Trailers                                                                                  |
       | Pony Trailers                                                                                  |
       | Expando Semi-Trailers                                                                          |
       | Ready Mix Concrete Pump Semi-Trailers                                                          |
       | Semi-Trailers                                                                                  |
       | Semi-Trailers - B-Trains                                                                       |
       | Semi-Trailers - Hiboys/Expandos                                                                |
       | Semi-Trailers - Hiboys/Flat Decks                                                              |
       | Semi-Trailers - Insulated Vans with Reefer/Refrigeration Units                                 |
       | Semi-Trailers - Logging                                                                        |
       | Semi-Trailers - Non-Tac Short Chassis                                                          |
       | Semi-Trailers - Single Drop, Double Drop, Step Decks, Lowbed, Expandos, etc.                   |
       | Semi-Trailers - Stinger Steered Automobile Transporters                                        |
       | Semi-Trailers - Walled B-Trains (Chip Trucks)                                                  |
       | Semi-Trailers - With Crane                                                                     |
       | Semi-Trailers - Wide Wheelers                                                                  |
       | Semi-Trailers - Wheelers                                                                       |
       | Stinger Steered Automobile Transporters                                                        |
    And they do not see:
      | Manufactured Homes, Modular Buildings, Structures and Houseboats (<= 5.0 m OAW) with Attached Axles |
      | Manufactured Homes, Modular Buildings, Structures and Houseboats (> 5.0 m OAW) with Attached Axles  |
      | Park Model Homes with Attached Axles                                                                |
      | Semi-Trailers - Steering Trailers                                                                   |
      | Semi-Trailers - Spread Tandems                                                                  |
      | Semi-Trailers - A-Trains and C-Trains                                                               |
      | Specially Authorized Vehicles                                                                       |
      | Steering Trailers - Manned                                                                          |
      | Steering Trailers - Self/Remote                                                                     |

  Scenario: Input Vehicle information
    Given the PPC SA or PC is at the "Permit Application" page
     When They are at the "Vehicle Information" section
     And  Choose to input their Vehicle Information and not select a previously saved Power unit or Trailer
     Then they fill in the following vehicle information:
       | VIN (last 6 digits) |
       | Plate               |
       | Make                |
       | Year                |
       | Country             |
       | Province            |
       | Vehicle Type        |
       | Vehicle Sub-type    |

 Scenario: Show mandatory fields 
     Given the PPC SA or PC is inputing their "Vehicle Information" 
     When they do not enter valid data into a <mandatory field>
     Then they see <mandatory field error message> (as presented in the Wireframe)  
     And they wont be able to "continue" until resolved
  
     Examples:
       | mandatory field  | mandatory field error message |
       | VIN              | This is a required field      |
       | Plate            | This is a required field      |
       | Year             | This is a required field      |
       | Make             | This is a required field      |
       | Vehicle Type     | This is a required field      |
       | Vehicle Sub-type | This is a required field      |
       | Country          | This is a required field      |

@orv2-938-3
Rule: PPC SA or PC can update or save new vehicles to inventory

 Scenario: Save new vehicle to "Vehicle Inventory"
     Given The PPC SA or PC manually inputted "Vehicle Information"
     When the VIN + Company doesn't match an existing VIN in "Vehicle Inventory"
     And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
     Then the Vehicle will be added to "Vehicle Inventory" when they select "continue"
     And if they select NO the vehicle will not be saved to "Vehicle Inventory"


  Scenario: Update existing vehicle to "Vehicle Inventory"
    Given The PPC SA or PC manually inputted "Vehicle Information"
    When the VIN + Company does match an existing VIN in "Vehicle Inventory"
    And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
    Then the Vehicle will update the previously existing Vehicle to "Vehicle Inventory" when they select "continue"
    And if they select NO the vehicle will not be updated in "Vehicle Inventory"

@orv2-938-4
Rule: PPC SA or PC can search for and recall vehicles in inventory

  Scenario: Find vehicle in inventory by Unit Number
    Given the PPC SA or PC has selected Unit Number in "Choose from"
    When they enter <unit number> in "Select Vehicle"
    And they select the desired vehicle
    Then the <vehicle> is displayed
    And they are grouped by the <vehicle type> either "Power Unit" or "Trailer"
  
  Example:
    | unit number | vehicle | vehicle type |
    | 123         | 1       | Power Unit   |
    | 123         | 12      | Power Unit   |
    | 123         | 123     | Power Unit   |
    | 1           | 1       | Trailer      |
    | 1           | 12      | Trailer      |
    | 1           | 123     | Power Unit   |

  Scenario: Find vehicle in inventory by Plate Number
    Given the PPC SA or PC has selected Plate Number Number in "Choose from"
    When they enter <plate number> in "Select Vehicle"
    And they select their desired vehicle
    Then the <vehicle> is displayed
    And they are grouped by the <vehicle type> either "Power Unit" or "Trailer"

    Example:
      | plate number | vehicle | vehicle type |
      | 123          | 1       | Power Unit   |
      | 123          | 12      | Power Unit   |
      | 123          | 123     | Power Unit   |
      | 1            | 1       | Trailer      |
      | 1            | 12      | Trailer      |
      | 1            | 123     | Power Unit   |
