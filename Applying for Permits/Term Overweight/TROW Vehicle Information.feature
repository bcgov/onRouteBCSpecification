Feature: CV Client complete TROW application vehicle details
   As a CV Client I need to be able to recall a vehicle from m vehicle inventory or add new vehicle information to my permit application so that I can receive a valid TROW permit for my vehicle.

CV Client = PA, CA

@orv2-1095-15
Rule: Show CV Client "Can't find a vehicle from your inventory?" information box
@orv-1095-16
Rule: Only power units and trailers eligible for TROW permits are available to permit

  Scenario: TROW eligible "Power Unit"
    Given a CV Client is at "Vehicle Details" for a TROW permit application
     When they choose to recall a "Power Unit" from their inventory 
     Then they see only "Power Units" eligible for a TROW permit

  Scenario: TROW eligible "Trailer"
    Given a CV Client is at "Trailer" for a TROW permit application
     When they choose to recall a "Trailer" from their inventory 
     Then they see only "Trailers" eligible for a TROW permit

 # See Data Discovery
@orv-1095-17
Rule: The CV Client must input a vehicle to permit

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

@orv-1095-18
Rule: Mandatory vehicle fields are indicated

 Scenario: Mandatory fields 
     Given the CV Client is inputting their "Vehicle Information" 
     When they do not enter valid data into a <mandatory field>
     Then they see <mandatory field error message> (as presented in the Wireframe)  
     And they wont be able to "continue" until resolved
     And the <mandatory field> is outlined in red
  
     Examples:
       | mandatory field  | mandatory field error message |
       | VIN              | This is a required field      |
       | Plate            | This is a required field      |
       | Year             | This is a required field      |
       | Make             | This is a required field      |
       | Vehicle Type     | This is a required field      |
       | Vehicle Sub-type | This is a required field      |
       | Country          | This is a required field      |

@orv2-1095-20
Rule: The CV Client can recall a vehicle from their vehicle inventory

  Scenario: Find vehicle in inventory by Unit Number
    Given the CV Client has selected Unit Number in "Choose from"
    When they enter <unit number> search parameter in "Select Vehicle"
    And they select their desired vehicle
    Then the chosen <vehicle> information is shown
    And "Vehicle Type" is read only
 
  Examples:
    | unit number | vehicle |
    | 12          | 123     |
    | 12          | 12      |
    | 123         | 123     |
    | 1           | 1       |
    | 1           | 12      |
    | 1           | 123     |
    | 2           | 123     |
    | 2           | 321     |
    | 23          | 123     |

  Scenario: Find vehicle in inventory by Plate Number
    Given the CV Client has selected Plate Number Number in "Choose from"
    When they enter <plate number> search parameter in "Select Vehicle"
    And they select their desired vehicle
    Then the chosen <vehicle> information is shown
    And "Vehicle Type" is read only

  Examples:
    | unit number | vehicle |
    | D12         | D123456 |
    | D12         | D123456 |
    | D123        | D123456 |
    | D654        | D654321 |
    | D6          | D654321 |                     