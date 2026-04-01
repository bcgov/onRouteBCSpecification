Feature: Application Vehicle Details
   As a CV Client I need to be able to recall a vehicle from vehicle inventory or add new vehicle information to my permit application so that I can receive a valid permit for my vehicle.

# Rule: A user can input a vehicle manually

  Scenario: The Client inputs their Vehicle information
     When a user chooses to input their Vehicle Information 
     Then they fill in the following vehicle information:
       | VIN (last 6 digits) | 
       | Plate               |
       | Make                |
       | Year                |
       | Country             |
       | Province            |
       | Vehicle Type        |
       | Vehicle Sub-type    |
       | Licensed GVW (kg)   |

 Scenario: no input to mandatory fields 
     Given the CV Client is inputting vehicle details
     When they do not enter valid data into a mandatory field
     Then they see "this is a required field"
     And they can not continue
     And the mandatory field is indicated

Rule: a user can recall an allowable vehicle from inventory

  Scenario: Find vehicle in inventory by Unit Number
    Given the CV Client has selected Unit Number in "Choose from"
     When they enter <unit number> in "Select Vehicle"
      And they select their desired vehicle
     Then the <vehicle> is displayed
      And they are grouped by the <vehicle type> either "Power Unit" or "Trailer"
      And Vehicle Type is disabled
  
  Examples:
    | unit number | vehicle | vehicle type |
    | 123         | 1       | Power Unit   |
    | 123         | 12      | Power Unit   |
    | 123         | 123     | Power Unit   |
    | 1           | 1       | Trailer      |
    | 1           | 12      | Trailer      |
    | 1           | 123     | Power Unit   |


  Scenario: Find vehicle in inventory by Plate Number
    Given the CV Client has selected Plate Number Number in "Choose from"
     When they enter <plate number> in "Select Vehicle"
      And they select their desired vehicle
     Then the <vehicle> is displayed
      And they are grouped by the <vehicle type> either power unit or trailer
      And Vehicle Type is disabled
      
  Examples:
    | plate number | vehicle | vehicle type |
    | 123          | 1       | Power Unit   |
    | 123          | 12      | Power Unit   |
    | 123          | 123     | Power Unit   |
    | 1            | 1       | Trailer      |
    | 1            | 12      | Trailer      |
    | 1            | 123     | Power Unit   |


