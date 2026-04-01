Feature: Add edit and view Power Unit
    As a CV Client, I need to be able to add a new Power Unit to my vehicle inventory, edit it and view its details so that I can use this vehicle in a permit application.
 
Background:
     Given a customer is authenticated and logged in and has the appropriate onRouteBC role
 
@orv2-141-1
Scenario: Create a Power Unit 
    Given the CV Client is viewing the vehicle inventory
    When they choose to add a vehicle
    And they choose to add a Power Unit to inventory 
    Then they are directed to an empty Power Unit page
 
@orv2-141-2
Scenario: Save changes to a Power Unit
    Given the CV Client is editing a Power Unit
    When they save changes
    Then the Power Unit is saved
    And they are directed to the vehicle inventory
    And the saved Power Unit is shown in the vehicle inventory with the saved data
 
@orv2-141-3
Scenario: Cancel create Power Unit
    Given the CV Client is editing a Power Unit
    When they cancel edit
    Then they see "You have unsaved changes. If you continue, all your changes will be lost."
 
@orv2-141-4
Scenario: Cancel create Power Unit discard changes
    Given the CV Client is editing a Power Unit
    When they cancel edit
    And they choose to continue without saving
    Then the Power Unit is not saved
    And they are directed to the vehicle inventory
    And the cancelled Power Unit is not shown in the vehicle inventory
 
@orv2-141-5
Scenario: Show mandatory fields 
    Given the CV Client is editing a Power Unit 
    When they do not enter valid data into a <mandatory field>
    And they choose to add vehicle 
    Then they see <mandatory field error message>  
    And they cannot save the Power Unit
 
    Examples:
    | mandatory field  | mandatory field error message |
    | VIN              | This is a required field      |
    | Plate            | This is a required field      |
    | Year             | This is a required field      |
    | Make             | This is a required field      |
    | Licensed GVW     | This is a required field      |
    | Vehicle Sub-type | This is a required field      |
    | Country          | This is a required field      |

@orv2-3144-1
Rule: Licensed GVW(kg) cannot exceed 63,500 for power units in vehicle inventory

  Scenario: input 63,000 (kg)
     When they input 63,000 (kg)
     Then they can continue

  Scenario: input 65,000 (kg)
     When they input 65,000 (kg)
     Then they see "Can't Exceed 63,500"
      And they can not continue

  Scenario: -number
     When a user inputs -100
     Then they see "Invalid Input"
    
Feature: Add edit and view trailers
    As a CV Client, I need to be able to add a new trailer to my vehicle inventory, edit it and view its details so that I can use this vehicle in a permit application.

@orv2-2381
Rule: Choosing to edit a vehicle is the list edits the choosen vehicle

  Scenario: multiple vehicle selected
     When a user chooses to edit a vehicle
     Then the row for which the edit action was selected is the vehicle chosen 

@orv-325-1
Scenario: Choose vehicle type to add to inventory  
    Given the CV Client is at the vehicle inventory page
    When they select "Add Vehicle"  
    Then they are directed to choose to add a Power Unit or Trailer to inventory

@orv-325-2
Scenario: Create a Trailer 
    Given the CV Client is at the choose to add a Power Unit or Trailer to inventory
    When they select Trailer
    Then they are directed to an empty Add Trailer page

@orv-325-3
Scenario: Save changes to a Trailer
    Given the CV Client at the Trailer page
    When they save
    Then the Trailer is saved
    And they are directed to the vehicle inventory 
    And the saved Trailer is shown in the vehicle inventory with changed data
    And they see "Vehicle has been saved successfully"

@orv-325-4
Scenario: Cancel create Trailer continue without saving
    Given the user is editing a Trailer
    When the user cancels edit
    And the user chooses to continue without saving
    Then the Trailer is not saved
    And the user is directed to the vehicle inventory

@orv-325-5
Scenario: Show mandatory fields
    Given the user is editing a Trailer
    When the user does not enter valid data into a mandatory field
    Then the user sees <manadatory field error message>
    And the user cannot save the Trailer

    Examples:
    | mandatory field  | mandatory field error message |
    | VIN              | This is a required field      |
    | Plate            | This is a required field      |
    | Year             | This is a required field      |
    | Make             | This is a required field      |
    | Vehicle Sub-type | This is a required field      |
    | Country          | This is a required field      |


Feature: Delete Vehicles
As a CV Client, I need to delete individual vehicles or a group of vehicles I no longer need in my vehicle inventory.

@orv2-340-1
Scenario: Choose a vehicle to perform an action on
    Given the CV Client is at their vehicle inventory
    And they are viewing either Power Units or Trailers
    When they choose a vehicle in the list
    Then The chosen vehicle is indicated
     And The vehicle delete option is enabled

@orv2-340-2
Scenario: Delete vehicle warning
    Given the CV Client chooses a vehicle in either Power Units or Trailers
    When they choose delete vehicle 
    Then they see "Are you sure you want to delete this? This action cannot be undone."

@orv2-340-3
Scenario: Delete a vehicle continue with delete
    Given the CV Client chooses a vehicle in either Power Units or Trailers
    And the choosen vehicle is indicated
    And they choose delete vehicle 
    When they choose to continue delete
    Then The chosen vehicle is removed from their vehicle inventory
    And they are directed to their vehicle inventory 
    And they see "Vehicle Deleted"
    And the deleted vehicle is not shown in their vehicle inventory

@orv2-340-4 @orv2-2381
Scenario: Bulk delete multiple vehicles
    Given the CV Client chooses more than one vehicle in either Power Units or Trailers
    And delete is available
    When they choose delete
    Then the chosen vehicles are removed from their vehicle inventory
    And they are directed to their vehicle inventory 
    And they see "Vehicle Deleted"
    And the deleted vehicles are not shown in their vehicle inventory

Feature: Edit Vehicle Details
As a CV Client, I need to edit individual vehicle details so that I can keep my individual vehicle details up to date.

@orv2-341-1
Scenario: Indicate chosen vehicle
    Given the user is at their vehicle inventory
    And the user is viewing either Power Units or Trailers
    When the user chooses a vehicle in the list
    Then The chosen vehicle is indicated
   
@orv2-341-2
Scenario: Edit vehicle details
    Given the user chooses a vehicle in either Power Units or Trailers
    And the user chooses edit vehicle 
    And the user make changes to the vehicle details
    When the user saves changes
    Then the changes are saved
    And the user is directed to their vehicle inventory 
    And the saved vehicle is displayed in their vehicle inventory with changed data

Feature View vehicle inventory lists
   As a CV Client, I need to be able to view all vehicles in my inventory so that I can select them to complete actions.

@orv2-145-1  
Scenario: View Power Units Inventory
  Given the CV Client is at Vehicle Inventory
   When they choose to view Power Units
   Then they are directed to the Power Unit page

@orv2-145-2
Scenario: View Trailer inventory list
  Given the CV Client is at Vehicle Inventory
   When they choose to view Trailer
   Then they are directed to the Trailer page

@orv2-145-3
Scenario: Vehicle list columns
  Given the CV Client is at Vehicle Inventory
   When they choose to view a Power Unit or Trailer lists
   Then they see the folling columns
     | Unit #       |
     | Make         |
     | VIN          |
     | Plate        |
     | Vehicle Type |
     | Date Created |
   And it is sorted by Date Created in descending order

# Rule: Sort vehicles list by a chosen column

@orv2-145-4
 Scenario: date created
  Given the CV Client is at Power Unit or Trailer tab
   When they choose to sort by Date Created
   Then the list is sorted in reverse order from the previously chosen sort order

Rule: As a CV Client I need to search my vehicle inventory so that I can find specific vehicles in my inventory

@orv2-292-1
  Scenario: Search vehicle inventory by 
    Given a CV Client is at their vehicle inventory
    And they view either Power Units or Trailers
    When they choose to <search>
    And they enter a <parameter>
    Then <displayed> vehicles are shown

   Examples:
     | search       | parameter | displayed                                                |
     | Unit Number  | 12345     | all vehicles with Unit Number 12345                      |
     | Plate        | Bob24     | all vehicles with Plate Bob24                            |
     | Make         | 123       | all vehicles with Unit Number with the characters 123    |
     | Vehicle Type | Bob       | all vehicles with Vehicle Type with the 3 characters Bob |
     | VIN          | 568       | all vehicles with VIN with the 3 characters 568          |
     | Date Created | 23        | all vehicles with Date Created with the 2 characters 23  |

 @orv2-3835-10
 Rule: only authorized staff can view a cv client's vehicle inventory

  Scenario: authorized
     When PC, SA, TRAIN, FIN, CTPO are at a cv client profile
     Then they see the option to view vehicle inventory

  Scenario: not authorized
     When Fin, EO, HQA are at a cv client profile
     Then they do not see the option to view vehicle inventory

