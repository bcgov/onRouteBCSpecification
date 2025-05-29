Feature: Amend Non-Resident ICBC Basic Insurance (Single Trip and QTRLY)

Staff = SA, PC, CTPO, Trainee

- FRCR?
 - Yes
- Issued with LCV, LCV flag removed then LCV not available to issue on amend
 - same design as other permits
- QTRLY if they are into the calendar quarter do we prorate the refund? Do we need to handle this? - no there is no proration for these
- are we allowing any start date? This will change the calendar qtr - update ticket #nextaction
 - new application start date any future date
 - amend backdate only with calendar qtr future any date

@orv2-4211
Rule: Changing ICBC Basic Insurance start date is a $0 change

-finish screen
  Scenario: 
    Given 
     When 
     Then 

Rule: staff can amend the permit duration up to 30 days

Rule: staff can forward date to any date

Rule: staff can backdate the start date for a qtrly within the calendar quarter

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

Rule: Staff can amend vehicle details except vehicle sub-type

Rule: Staff can change the third party liability?
- this will increase or decrease the fee
- impacts fees

Rule: Debit add to cart if its credit continue to finish refund to multiple payment methods (RMPM)
