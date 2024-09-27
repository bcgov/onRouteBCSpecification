Feature: Amend LOA Permit

Staff = SA, PC, CTPO, Trainee

Rule: Vehicle details are removed from an amending LOA permit when the LOA vehicle is removed from the LOA used in the LOA permit

  Scenario: 
    Given 
     When 
     Then 

Rule: Vehicle details are removed from an amending LOA permit when the LOA vehicle is removed from the LOA used in the LOA permit

	- LOA expired | amend permit | LOA is shown check is cleared and unavailable | vehicle information cleared, permit duration shows all options

- LOA vehicle removed in LOA | amend permit | see valid LOAs | clear the vehicle information in amending permit application

Use LOA 638 in permit A
LOA 638 is expired
Amend 638 loa permit 
- 