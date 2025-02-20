Feature: As a user I need to use one or more active letter of authorization(s) (LOA's) in a permit application so that I can purchase a permit using the special authorizations granted by the LOA(s).

Users = SA, HQA, PC, CTPO, Trainee, CA, PA 

@orv2-2261-1 @orv2-2860-14
Rule: The LOA(s) feature is hidden if there are no active or expired LOA(s)

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

  Scenario: available LOA(s)
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then they see:
       | LOA B number      |
       | LOA B expiry date |
      And LOA B is unavailable

@orv2-2261-2
Rule: Using an LOA(s) in a permit application is optional

@orv2-2261-3 @orv2-2860-9
Rule: LOA(s) must match the permit type to be available in the permit application

  Scenario: term LOA(s)
    Given the cv client has LOA(s) for term permits
     When users apply for a term permit
     Then they see the active LOA(s) for term permits

  Scenario: no term LOA(s)
    Given the cv client has no LOA(s) for term permits
     When users apply for a term permit
     Then option to use LOA(s) is not shown

@orv2-2261-4 @orv2-2860-8
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

  Scenario: LOA(s) has not started
    Given a cv client has one LOA(s)
     And the LOA(s) starts on 02/22/2025
     When a user applies for a term permit on 02/07/2025
     Then the LOA(s) cannot be chosen

@orv2-2261-5 @orv2-2860-7
Rule: Permit start date and duration are limited by the chosen LOA(s) with the shortest term length

  Scenario: two LOA(s) chosen one expires sooner
    Given the chosen LOA(s) expiry dates are:
      | 03/01/2024 |
      | 02/01/2024 |
      And the application date is 01/01/2024
     When a user chooses a start date that is 01/11/2024
     Then LOA with an expiry of 02/01/2024 is unavailable

  Scenario: LOA(s) expires before maximum allowable term duration
    Given the chosen LOA(s) expires on 04/01/2024 |
     When a user chooses a start date that is 01/11/2024
     Then they can choose only the following valid term durations:
       | 30 |
       | 60 |

@orv2-2261-6 @orv2-2860-6
Rule: A term permit application can have one or more LOA(s) chosen to apply with

@orv2-2261-7 @orv2-2860-4
Rule: Vehicle VIN must be associated to the LOA(s) to be available in the permit application (and therefore must be an inventory vehicle)
 
#Available vehicles only from associated LOA are available ???

  Scenario: LOA(s) vehicle chosen LOA(s) removed
    Given the user has chosen LOA(s) 1
      And LOA(s) 1 has vehicle A
      And vehicle A is not allowed for the permit type without an LOA(s)
      And they have chosen vehicle A
     When they remove LOA(s) 1
     Then the vehicle A is not available in the permit application

  Scenario: vehicle removed from inventory
    Given active LOA(s) 1 has vehicle A
     When vehicle A is removed from inventory
      And LOA(s) 1 is chosen
     Then vehicle A is not available in the permit application

  Scenario: 2 loas chosen only 1 has valid vehicle 
    Given active LOA(s) 1 has vehicle A
     When LOA(s) 1 and 2 are chosen
      And vehicle A is not on LOA(s) 2
     Then vehicle A is not available in the permit application

  Scenario: no vehicle chosen
     When no vehicle is chosen
     Then a user cannot edit vehicle details

@orv2-2261-8 @orv2-2860-5
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

@orv2-2261-9 @orv2-2860-10
Rule: The user can review the chosen LOA(s) parameters before completing the permit application workflow

  Scenario: LOA(s) chosen
    Given the user has chosen one or more LOA(s) 
     When they review the inputted permit application parameters
     Then they see the following information about the LOA(s):
      | data          | description                                                                  |
      | LOA number(s) | the unique number generated by onRouteBC when the LOA(s) is created by staff |

@orv2-2261-10 @orv2-2860-11
Rule: The chosen LOA(s) numbers are printed on the issued permit pdf

@orv2-2261-12 @orv2-2860-13
Rule: A permit application is unaffected by changes to the LOA(s) used during the application submission process

  #Scenario: vehicle removed from inventory allowable with permit
    Given permit A uses LOA X and LOA Y
      And permit A uses vehicle 1 only on LOA Y
      And vehicle 1 has been removed from LOA Y
      And vehicle 1 is allowed for the permit A permit type
     When staff amend permit A
     Then vehicle 1 is shown
     Then the the original vehicle is shown

  Scenario: vehicle removed from inventory
    Given permit A uses LOA X and LOA Y
      And permit A uses vehicle 1 only on LOA Y
      And vehicle 1 has been removed from inventory
     When staff amend permit A
     Then vehicle 1 is not shown
  
    Scenario: vehicle removed from LOA allowable with permit
    Given permit A uses LOA B and LOA C
      And permit A uses vehicle 1 only on LOA B
      And vehicle 1 has been removed from LOA B
      And vehicle 1 is allowed for the permit A permit type
     When staff amend permit A
     Then vehicle 1 is shown
      

  Scenario: vehicle removed from LOA not allowable with permit
    Given permit A uses LOA B and LOA C
      And permit A uses vehicle 1 only on LOA B
      And vehicle 1 has been removed from LOA B
      And vehicle 1 is not allowed for the permit A permit type
     When staff amend permit A
     Then vehicle 1 is not shown

  Scenario: LOA deleted
    Given 
     When 
     Then 

  Scenario: LOA term shortened
    Given 
     When 
     Then 

   Scenario: LOA term lengthened
     Given 
      When 
      Then 

  Scenario: 1 LOA expired
    Given 
     When 
     Then 

  Scenario: 2 LOA 1 expired
    Given 
     When 
     Then 

#Current behaviour 
 #can't delete a vehicle used in an expired, deleted or active LOA

#Should force validation at the amending permit application or it will get caught at the cart anyways

#Should we copy the vehicle to the LOA and separate from vehicle inventory ???
 #Copy info out of inventory and into the LOA this LOA is for this VIN and this plate ???

#Currently if the vehicle is attached to ANY LOA you can edit the vehicle in inventory but can't delete it

# vehicle changes will not be reflected in the LOA 
    # removal from inventory - test
    # updates to other information? - test
# VIN is not the link to an LOA it is a onRouteBC generated unique id
    # If the VIN is updated for a vehicle on an LOA then it will be a valid LOA vehicle? - test

# expired LOA before permit expiry will be handled manually 
# Vehicle VIN deletion would be handled manually look up existing permits and amend or void, revoke.