@e2e5
Feature: TROS Application Vehicle Details
   As a CV Client I need to be able to recall a vehicle from m vehicle inventory or add new vehicle informatin to my permit application so that I can receive a valid TROS permit for my vehicle.

@orv-551-1
  Scenario: TROS eligible "Power Unit"
    Given a CV Client is at "Vehicle Details" for a TROS permit application
     When they choose to recall a "Power Unit" from their inventory 
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

  @orv-551-2
  Scenario: TROS eligible "Trailer"
    Given a CV Client is at "Trailer" for a TROS permit application
     When they choose to recall a "Trailer" from their inventory 
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

@orv-551-3
  Scenario: The Client inputs their Vehicle information
    Given the CV Client is at the "Permit Application" page
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

@orv2-551-4 @orv2-555-8
Scenario: Show mandatory fields 
    Given the CV Client is inputing their "Vehicle Information" 
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

@orv2-551-5
Scenario: Save new vehicle to "Vehicle Inventory"
    Given The CV Client manually inputed their "Vehicle Information"
    When the VIN + Company dosent match an existing VIN in their "Vehicle Inventory"
    And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
    Then the Vehicle will be added to their "Vehicle Inventory" when they select "continue"
    And if they select NO the vehicle will not be saved to their "Vehicle Inventory"

@orv2-551-8
  Scenario: Update exsiting vehicle to "Vehicle Inventory"
    Given The CV Client manually inputed their "Vehicle Information"
    When the VIN + Company does match an existing VIN in their "Vehicle Inventory"
    And if they select YES to "would you like to add/update this vehicle to your vehicle inventory?"
    Then the Vehicle will update the previously existing Vehicle to their "Vehicle Inventory" when they select "continue"
    And if they select NO the vehicle will not be updated in their "Vehicle Inventory"

@orv2-551-6
  Scenario: Find vehicle in inventory by Unit Number
    Given the CV Client has selected Unit Number in "Choose from"
    When they enter <unit number> in "Select Vehicle"
    And they select their desired vehicle
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

@orv2-551-7
  Scenario: Find vehicle in inventory by Plate Number
    Given the CV Client has selected Plate Number Number in "Choose from"
    When they enter <plate number> in "Select Vehicle"
    And they select their desired vehicle
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

@orv2-1015
Scenario: TROS eligible "Power Unit"
    Given a CV Client is at "Vehicle Details" for a TROS permit application
      And they are designated as an LCV CV Client
     When they choose to recall a "Power Unit" from their inventory 
     Then they see only "Power Units" eligible for a TROS permit:
       | Concrete Pumper Trucks                                                                                                           |
       | Double Decker Buses                                                                                                              |
       | Fixed Equipment - Trucks/Graders etc.                                                                                            |
       | Intercity Buses (Pulling Pony Trailers)                                                                                          |
       | Logging Trucks                                                                                                                   |
       | Logging Trucks - Off-Highway                                                                                                     |
       | Long Combination Vehicles (LCV) - Rocky Mountain Doubles                                                                         |
       | Long Combination Vehicles (LCV) - Turnpike Doubles                                                                               |
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
       | Oil and Gas - Service Rigs and Rathole Augers Only Equipped with Heavy Front Projected Crane (must exceed 14,000 kg tare weight) |
       | Cranes, Rubber-Tired Loaders, Firetrucks - All Terrain                                                                           |
       | Cranes, Rubber-Tired Loaders, Firetrucks - Mobile                                                                                |
       
       
@orv2-1016
Feature: TROS to PPC Queue

  Scenario: Auto-approve, permit queue...
    Given 
     When 
     Then 

 The following scenario describes the complete list of available power unnits that can receieve a TROS permit. Including those that are not auto-approvable and if selected must go to the PPC queue for manual approval. 

  Scenario: TROS eligible "Power Unit"
    Given a CV Client is at "Vehicle Details" for a TROS permit application
     When they choose to recall a "Power Unit" from their inventory 
     Then they see only "Power Units" eligible for a TROS permit:
       | Concrete Pumper Trucks                                                                                                                                                                                                                                     |
       | Cranes, Rubber-Tired Loaders, Firetrucks - All Terrain (TROS - NOT AUTO-APPROVABLE - this would need to go into a PPC Queue for manual review CTPO, ACTPO, PPC Admin)                                                                                      |
       | Cranes, Rubber-Tired Loaders, Firetrucks - Mobile (TROS - NOT AUTO-APPROVABLE - this would need to go into a PPC Queue for manual review CTPO, ACTPO, PPC Admin)                                                                                           |
       | Double Decker Buses                                                                                                                                                                                                                                        |
       | Fixed Equipment - Trucks/Graders etc.                                                                                                                                                                                                                      |
       | Intercity Buses (Pulling Pony Trailers)                                                                                                                                                                                                                    |
       | Logging Trucks                                                                                                                                                                                                                                             |
       | Logging Trucks - Off-Highway                                                                                                                                                                                                                               |
       | Long Wheelbase Truck Tractors Exceeding 6.2 m up to 7.25 m                                                                                                                                                                                                 |
       | Oil and Gas - Oilfield Sows                                                                                                                                                                                                                                |
       | Oil and Gas - Bed Trucks                                                                                                                                                                                                                                   |
       | Oil and Gas - Service Rigs and Rathole Augers Only Equipped with Heavy Front Projected Crane (must exceed 14,000 kg tare weight) (TROS - NOT AUTO-APPROVABLE - this would need to go into a PPC Queue for manual review PPC Clerk, CTPO, ACTPO, PPC Admin) |
       | Picker Truck Tractors                                                                                                                                                                                                                                      |
       | Specially Authorized Vehicles                                                                                                                                                                                                                              |
       | Tow Vehicles                                                                                                                                                                                                                                               |
       | Truck Tractors                                                                                                                                                                                                                                             |
       | Truck Tractors - Stinger Steered                                                                                                                                                                                                                           |
       | Trucks                                                                                                                                                                                                                                                     |
       | Trucks Equipped with Front or Underbody Plow Blades                                                                          |
     And they do not see:
       | Oil and Gas - Service Rigs |
       | Scrapers                   |
       | Taxis                      |
       | Buses/Crummies             |
       | Farm Vehicles              |