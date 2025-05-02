Feature: Amend Single Trip Oversize Permit

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

Rule: staff can forward date start date

  Scenario: changing form an active to an issued permit
    Given 
     When 
     Then 

  Scenario: 
    Given 
     When 
     Then 

Rule: changing commodity details are bound by policy 

  Scenario: 
    Given 
     When 
     Then 


 remove vehicle details and loaded dimensions - no! new application Warning modal

Rule: staff can change any vehicle detail except vehicle sub-type without impacting other application data

  Scenario: recall vehicle
    Given 
     When 
     Then only allowable vehicle sub-type is available

Rule: change power unit
  change power unit individual information
   edit everything by the vehicle sub-type
  change power unit
  
Rule: staff trailers get reset
 change trailers
  reset removes all trailers

Rule: change loaded dimensions
 subject to mandatory field behaviour and data behaviour

Rule: change trip details
 subject to mandatory field behaviour

all changes will be $0 and continue to finish


