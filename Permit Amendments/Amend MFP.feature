Feature: Amend Motive Fuel Permit

staff = 

Background

Are we going to allow reduction and increases in km - Yes
   - New Permit Value would be the same as Current Permit Value 
  - at maximum value before amend
  - directed to finish
  - transact refund
 
- do we want to use the STOS date amend behaviour - yes except 30 days
 - duration 7 days for new and amend
- do we need to worry about refunds? - same as any other refund
	- distance reduced
	- are there special handling given its a deposit - no
	- don't refund a permit that is $20 or less - not applicable
- start date matches STOS

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

Rule: a change that results in a debit (New Permit Value is greater than Current Permit Value) is directed to the shopping cart

  Scenario: > current permit value
    Given 
     When 
     Then 

  Scenario: = current permit value
    Given 
     When 
     Then 

  Scenario: maximum permit value
    Given MFP permit A has a current permit value of $140
     When staff add km to total distance
     Then permit A NPV is $140


Rule: a change that results in a credit (New Permit Value is less than Current Permit Value) is directed to refund to multiple payment methods

  Scenario: < current permit value
    Given 
     When 
     Then the APA is 



Rule: a change that results in the New Permit Value being equal to the Current Permit Value is directed to refund to multiple payment methods


Rule: a change...