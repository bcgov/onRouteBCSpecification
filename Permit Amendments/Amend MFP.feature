Feature: Amend Motive Fuel Permit
Amend Motive Fuel Permit (MFP) feature contains rules and scenarios specific to amending a MFP. Related features amend active permit, staff apply for motive fuel and user apply for motive fuel features will also apply to this feature.

staff = PC, SA, TRAIN, CTPO

Rule: staff can amend all contact information except company email
Rule: staff can change the start date 
Rule: staff can extend the duration up to 7 days
Rule: staff can reduce the duration of an issued or active permit
@orv2-
Rule: staff can amend the start date of an issued or active permit

  Scenario: backdate causes expiry
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 04/25/2025
      Then the Permit Expiry Date is 04/30/2025
       And the permit is expired       

  Scenario: backdate remains active
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 05/03/2025
      Then the Permit Expiry Date is 05/08/2025
       And the permit is expired     

  Scenario: forward date remains active
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 05/05/2025
      Then the Permit Expiry Date is 05/10/2025

  Scenario: forward date forward expiry
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 05/05/2025
      Then the Permit Expiry Date is 05/10/2025

  Scenario: forward date and reduce duration
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 05/05/2025
      And staff reduce duration to 2 days
      Then the Permit Expiry Date is 05/07/2025 

  Scenario: forward date and extend duration
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff amend the start date to 05/05/2025
      And staff extend duration to 20 days
      Then the Permit Expiry Date is 05/25/2025 


Rule: staff are notified when start date an/or expiry date are in the past

   Scenario: on application form
     Given the current date is 05/02/2025
      When staff amend the start date to 05/01/25
      Then they see "Start date is in the past"
 
   Scenario: on review and confirm
     Given the current date is 05/02/2025
      When staff amend the start date to 05/01/25
       And continue to review and confirm
      Then they see "Start date and/or expiry date is in the past"

Rule: staff can change all vehicle information except vehicle type
Rule: staff can change all trip details
Rule: staff can change the number of km(S) in total distance

  - reduction refund
   - =< the minimum charge
   - > minimum charge
   _ < than the rounding amount e.g., .7 km added .49

  - add the the additional km to the existing total km e.g., 1617km add 500km = 2117km or $35 more, BUT if this hits the max limit so we would charge the max = $27

 - addition will be new purchase
   - =< the maximum charge
   _ < than the rounding amount e.g., .7 km added .49
    - New Permit Value would be the same as Current Permit Value
   - > the maximum charge
   - at maximum value before amend

  Scenario: 
    Given 
     When 
     Then 

Rule: staff are shown the Current Permit Value (CPV) and New Permit Value (NPV) at review and confirm fee summary
Rule: if staff amend results in a debit (New Permit Value is greater than Current Permit Value) they can add the APA to the shopping cart

  Scenario: > current permit value
    Given 
     When 
     Then 

  Scenario: = current permit value
    Given 
     When 
     Then 

  Scenario: maximum permit value
    Given MFP permit A has a CPV of $140
     When staff add km to total distance
     Then permit A NPV remains at the maximum allowable fee of $140


Rule: if staff amend results in a credit (NPV is less than CPV) they can continue to refund to multiple payment methods

	- distance reduced
  Scenario: < CPV
    Given 
     When 
     Then the APA is 



Rule: if staff amend results in the NPV being equal to the CPV they can continue to refund to multiple payment methods

Rule: a change...