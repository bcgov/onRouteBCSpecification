Feature: Amend Non-Resident Single Trip License

Staff = SA, PC, CTPO, Trainee

- do staff need to be able to change the vehicle sub-type?
- do we retain the information in the weight fields when one is disabled due to a conditional license change?
 - it is possible but very complex to implement

Rule: staff can change the vehicle sub-type?

Rule staff can't change the vehicle sub-type?

  Scenario: recall different vehicle sub-type
    Given 
     When 
     Then they

  Scenario: recall same vehicle sub-type
    Given 
     When 
     Then 

Rule: staff can amend the permit duration up to 30 days

Rule: staff can forward date to any date?
- 5 years into The future?

Rule: staff can backdate the start date for a single trip - same as STOS amend

Rule: staff can backdate the start date for a qrtly within the calendar quarter

  Scenario: forward within quarter
    Given 
     When 
     Then 

  Scenario: forward outside quarter
    Given 
     When 
     Then 

  Scenario: back 
    Given 
     When 
     Then 

Rule: staff can change the vehicle weight

Rule: staff can change conditional licensing fees

  Scenario: none to x-plate
    Given x-plate vehicle type
     When 
     Then 

  Scenario: x-plate to none
    Given x-plate vehicle type
     When 
     Then 

  Scenario: none to x-plate 
    Given 
     When 
     Then 

  Scenario: change loaded gvw
    Given 
     When 
     Then 

  Scenario: none or conditional to farm
    Given 
     When 
     Then the inputted loaded GVW is removed 
      And loaded GVW is unavailable
      And net weight is available

  Scenario: farm to none or Conditional
    Given 
     When 
     Then the inputted net weight is removed 
      And net weight GVW is unavailable
      And loaded GVW is available

Rule: Changing NR Quarterly start date is a $0 change

  Scenario: 
    Given 
     When 
     Then 

