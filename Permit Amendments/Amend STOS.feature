Feature: Amend Single Trip Oversize Permit

Staff = PC, SA, TRAIN, CTPO

all changes will be $0 and continue to finish

@orv2-4015
Rule: staff can amend all contact information except company email

@orv2-4015
Rule: staff can extend duration up to 30 days

  Scenario: issued with 7 days
    Given permit A has a start date of 05/02/2025
      And a duration of 7 days
     When staff amend permit A duration to 20 days
     Then the end date is 05/22/2025

  Scenario: issued with 30 days
    Given permit A have a 30 day duration
     When staff choose to change duration
     Then they cannot add additional days
      But they can reduce duration

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
Rule: amendments to commodity information are subject to policy restrictions

  Scenario: vehicles exist warning
    Given vehicles have been added to the permit application
     When a user chooses to chnage the commodity
     Then they see "Change Commodity Type Changing your commodity will require you to re-enter your vehicle information and loaded dimensions."

  Scenario: vehicles exist confirm change
    Given a user initiated a commodity change
     When a user chooses to continue
     Then the commodity type is removed 
      And all inputted vehicle information is removed
      And all inputted loaded dimensions is removed

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




