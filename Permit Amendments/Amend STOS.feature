Feature: Amend Single Trip Oversize Permit

Rule: 

  Scenario: 
    Given 
     When 
     Then 

Rule: extend duration up to 30 days $0

  Scenario: active permit 
    Given 
     When 
     Then 

Rule: shorten duration can create an expired permit $0

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



Rule: duration to up to 30 days

  Scenario: 20 days chosen 
    Given 
     When when they choose 30 days
     Then end date is 10 days later

  Scenario: 30 days chosen
    Given 
     When they choose to change duration
     Then they cannot add additional days can only reduce duration

Rule: back date start date

  Scenario: expire permit
    Given 
     When 
     Then 

  Scenario: not expire permit
    Given 
     When 
     Then 

Rule: forward date start date

  Scenario: changing form an active to an issued permit
    Given 
     When 
     Then 

  Scenario: 
    Given 
     When 
     Then 

Rule: can change commodity details
 remove vehicle details and loaded dimensions - no! Warning modal

change vehicle details 
 change power unit
  change power unit individual information
   edit everything by the vehicle sub-type
  change power unit
  
  trailers get reset
 change trailers
  reset removes all trailers

change loaded dimensions
 subject to mandatory field behaviour and data behaviour

change trip details
 subject to mandatory field behaviour

all changes will be $0 and continue to finish

start date needs to be 14 days in advance 


