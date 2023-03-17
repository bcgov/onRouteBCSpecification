Feature: Add and view Power Unit
    As a CV Client, I need to be able to add a new Power Unit to my vehicle inventory, so that they can use this vehicle in a permit application.
 
Background:
 
    Given a customer is authenticated and logged in and has the appropriate onRouteBC role
 
@orv2-141
Scenario: Create a Power Unit 
    Given the CV Client is viewing the vehicle inventory
    When they choose to add a vehicle
    And they choose to add a Power Unit to inventory 
    Then they are directed to an empty Power Unit page
 
@orv2-141
Scenario: Save changes to a Power Unit
    Given the CV Client is editing a Power Unit
    When they save changes
    Then the Power Unit is saved
    And they are directed to the vehicle inventory
    And the saved Power Unit is shown in the vehicle inventory with the saved data
 
@orv2-141
Scenario: Cancel create Power Unit
    Given the CV Client is editing a Power Unit
    When they cancel edit
    Then they see "You have unsaved changes. If you continue, all your changes will be lost."
 
@orv2-141
Scenario: Cancel create Power Unit discard changes
    Given the CV Client is editing a Power Unit
    When they cancel edit
    And they choose to continue without saving
    Then the Power Unit is not saved
    And they are directed to the vehicle inventory
    And the cancelled Power Unit is not shown in the vehicle inventory
 
@orv2-141
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

Feature: Add edit and view trailers
    As a CV Client, I need to be able to add a new trailer to my vehicle inventory, edit it and view its details so that I can use this vehicle in a permit application.

@orv-325
Scenario: Choose vehicle type to add to inventory  
    Given the CV Client is at the vehicle inventory page
    When they select "Add Vehicle"  
    Then they are directed to choose to add a Power Unit or Trailer to inventory

@orv-325
Scenario: Create a Trailer 
    Given the CV Client is at the choose to add a Power Unit or Trailer to inventory
    When they select Trailer
    Then they are directed to an empty Add Trailer page

@orv-325
Scenario: Save changes to a Trailer
    Given the CV Client at the Trailer page
    When they save
    Then the Trailer is saved
    And they are directed to the vehicle inventory 
    And the saved Trailer is shown in the vehicle inventory with changed data
    And they see "Vehicle has been saved successfully"

@orv-325
Scenario: Cancel create Trailer continue without saving
    Given the user is editing a Trailer
    When the user cancels edit
    And the user chooses to continue without saving
    Then the Trailer is not saved
    And the user is directed to the vehicle inventory

@orv-325
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
    | Licensed GVW     | This is a required field      |
    | Vehicle Sub-type | This is a required field      |
    | Country          | This is a required field      |

