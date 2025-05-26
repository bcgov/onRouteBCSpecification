Feature: Amend Non-Resident ICBC Basic Insurance (Single Trip and QTRLY)


Staff = SA, PC, CTPO, Trainee

- GL coding? - Garima #nextaction
- FRCR?
- Issued with LCV, LCV flag removed then LCV not available to issue on amend
- QTRLY if they are into the calendar quarter do we prorate the refund? Do we need to handle 
- are we allowing any start date? Is this true also for new? This will change the calendar qtr

@orv2-4211
Rule: Changing ICBC Basic Insurance start date is a $0 change

-finish screen
  Scenario: 
    Given 
     When 
     Then 

Rule: Staff can amend the permit duration up to 30 days

Rule: Staff can change the start date

Rule: Staff can amend vehicle details except vehicle sub-type

Rule: Staff can change the third party liability?
- this will increase or decrease the fee
- impacts fees

Rule: Debit add to cart if its credit continue to finish refund to multiple payment methods (RMPM)
