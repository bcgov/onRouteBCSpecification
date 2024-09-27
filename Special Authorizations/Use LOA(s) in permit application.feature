Feature: As a user I need to use one or more active letter of authorization(s) (LOA's) in a permit application so that I can purchase a permit using the special authorizations granted by the LOA(s).

Users = SA, HQA, PC, CTPO, Trainee, CA, PA 

@orv2-2261-1
Rule: The LOA(s) feature is hidden if dataless

  Scenario: no active LOA(s)
     When users apply for a permit
     Then option to use LOA(s) is not shown
     
  Scenario: active LOA(s) exist
    Given the active valid LOA(s) are for the permit type applied for
     When users apply for a permit
     Then they see a list of active LOA(s) that include:
       | data            | description                                                      |
       | LOA number      | the unique number generated by onRouteBC when the LOA is created |
       | LOA expiry date | the date the LOA expires                                         |
      And they see the "To find details about the LOA go to the Special Authorizations page." info box

@orv2-2261-2
Rule: Using an LOA(s) in a permit application is optional

@orv2-2261-3
Rule: LOA(s) must match the permit type to be available in the permit application

  Scenario: term LOA(s)
    Given the cv client has LOA(s) for term permits
     When users apply for a term permit
     Then they see the active LOA(s) for term permits

  Scenario: no term LOA(s)
    Given the cv client has no LOA(s) for term permits
     When users apply for a term permit
     Then option to use LOA(s) is not shown

@orv2-2261-4
Rule: LOA(s) must have valid term length to be available in the permit application
 
  Scenario: LOA(s) expired before application
    Given a cv client has one LOA(s)
     And the LOA(s) expires on 02/01/2024
     When a user applies for a permit on 02/02/2024
     Then option to use LOA(s) is not shown

  Scenario: LOA(s) expires before minimum allowable permit term length
    Given a cv client has one LOA(s)
     And the LOA(s) expires on 02/28/2024
     When a user applies for a term permit on 02/02/2024
     Then the LOA(s) is shown
      But the LOA(s) cannot be chosen

@orv2-2261-5
Rule: Permit start date and duration are limited by the chosen LOA(s) with the shortest term length

  Scenario: two LOA(s) chosen one expires sooner
    Given the chosen LOA(s) expiry dates are:
      | 03/01/2024 |
      | 02/01/2024 |
      And the application date is 01/01/2024
     When a user chooses a start date that is 01/11/2024
     Then 02/01/2024 is unavailable

  Scenario: LOA(s) expires before maximum allowable term duration
    Given the chosen LOA(s) expires on 04/01/2024 |
     When a user chooses a start date that is 01/11/2024
     Then they can choose only the following valid term durations:
       | 30 |
       | 60 |

@orv2-2261-6
Rule: A term permit application can have one or more LOA(s) chosen to apply with

@orv2-2261-7
Rule: Vehicle VIN must match the LOA(s) to be available in the permit application (and therefore must be an inventory vehicle)
 
  Scenario: LOA(s) vehicle chosen LOA(s) removed
    Given the user has chosen an LOA(s)
     When they remove the chosen LOA(s)
     Then the chosen LOA(s) vehicle is not available in the permit application

  Scenario: vehicle removed from inventory
    Given an active LOA(s) has vehicle A
     When vehicle A is removed from inventory
     Then vehicle A is not available in the permit application

@orv2-2261-8
Rule: The chosen LOA vehicle cannot be edited or saved to the vehicle inventory

  Scenario: no LOA(s) vehicle in inventory
    Given a valid LOA(s) is chosen
      But there are no valid LOA(s) vehicle(s) in inventory
     When a user looks for an LOA vehicle
     Then they cannot find the vehicle

  Scenario: LOA(s) vehicle in inventory
    Given a valid LOA(s) is chosen
      And a VIN for the chosen LOA(s) is in the vehicle inventory
     When a user looks for an LOA vehicle
     Then they can find the vehicle

@orv2-2261-9
Rule: The user can review the chosen LOA(s) parameters before completing the permit application workflow

  Scenario: LOA(s) chosen
    Given the user has chosen one or more LOA(s) 
     When they review the inputted permit application parameters
     Then they see the following information about the LOA(s):
      | data          | description                                                                  |
      | LOA number(s) | the unique number generated by onRouteBC when the LOA(s) is created by staff |

@orv2-2261-10
Rule: The chosen LOA(s) numbers are printed on the issued permit pdf

@orv2-2261-11
Rule: Issued or active permit(s) are unaffected by changes to the LOA(s) used in their initial permit application submission

@orv2-2261-12
Rule: A permit application is unaffected by changes to the LOA(s) used during the application submission process

