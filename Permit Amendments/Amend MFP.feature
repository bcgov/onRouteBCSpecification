Feature: Amend Motive Fuel Permit

Are we going to allow reduction and increases in km
 - reduction refund
  - =< the minimum charge
  - > minimum charge
  _ < than the rounding amount e.g., .7 km added .49
   - New Permit Value would be the same as Current Permit Value 
  - at maximum value before amend
  - directed to finish
  - transact refund
 - addition will be new purchase
  - =< the maximum charge
  _ < than the rounding amount e.g., .7 km added .49
   - New Permit Value would be the same as Current Permit Value
  - > the maximum charge
  - at maximum value before amend
  - directed to cart
  - allow unique payment 
- do we want to use the STOS date amend behaviour - yes
- do we need to worry about refunds?
	- distance reduced
	- are there special handling given its a deposit
	- don't refund a permit that is $20 or less
	- add the the additional km to the existing total km e.g., 1617km add 500km = 2117km or $35 more, BUT if this hits the max limit so we would charge the max = $27
- duration 7 days for new and amend
- start date matches STOS

Rule: 

  Scenario: 
    Given 
     When 
     Then 

