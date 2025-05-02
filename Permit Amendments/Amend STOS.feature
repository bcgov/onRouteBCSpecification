Feature: Amend Single Trip Oversize Permit

Staff = PC, SA, TRAIN, CTPO

all changes will be $0 and continue to finish
@orv2-4015
Rule: staff can extend duration up to 30 days

  Scenario: active permit 
    Given 
     When 
     Then 

  Scenario: 20 days chosen 
    Given 
     When when they choose 30 days
     Then end date is 10 days later

  Scenario: 30 days chosen
    Given 
     When they choose to change duration
     Then they cannot add additional days can only reduce duration

@orv2-4015
Rule: staff can shorten duration and  create an expired permit

  Scenario: shorten active term expired
    Given the permit duration is 3 days
      And it is day 2 before 11:59:99 pm of the 3 days
     When staff choose to shorten the duration they cannot shorten the duration

  Scenario: shorten issued term expired
    Given the start date 1 day in the future 
      And the permit duration is 3 days
      And it is day 2 before 11:59:99 pm of the 3 days
     When staff choose to shorten the duration they cannot shorten the duration

  Scenario: shorten issued term not expired
    Given 
     When 
     Then 
     directed to global search results
     they 

  Scenario: shorten active term not expired
    Given 
     When 
     Then 

  Scenario: 
    Given 
     When 
     Then 

@orv2-4015
Rule: staff can back date start date

  Scenario: expire permit
    Given 
     When 
     Then 

  Scenario: not expire permit
    Given 
     When 
     Then 

 start date is in the past at application form
 start date and/or expiry date is in the past on review and confirm

@orv2-4015
Rule: staff can forward date start date

  Scenario: changing form an active to an issued permit
    Given 
     When 
     Then 

  Scenario: 
    Given 
     When 
     Then 

@orv2-4015
Rule: changing commodity details are bound by policy 

  Scenario: 
    Given 
     When 
     Then 


 remove vehicle details and loaded dimensions - no! new application Warning modal

@orv2-4015
Rule: staff can change any vehicle detail except vehicle sub-type without impacting other application data

  Scenario: recall vehicle
    Given 
     When 
     Then only allowable vehicle sub-type is available

@orv2-4015
Rule: staff update the existing power unit or recall a new power unit

  change power unit individual information
   edit everything but the vehicle sub-type
  
  Scenario: 
    Given 
     When 
     Then 

  Scenario: recall
    Given 
     When 
     Then 

@orv2-4015
Rule: staff trailers get reset
 change trailers
  reset removes all trailers

@orv2-4015
Rule: staff can change loaded dimensions
 subject to mandatory field behaviour and data behaviour

@orv2-4015
Rule: staff can change change trip details




