@orv2-5585 https://moti-imb.atlassian.net/browse/ORV2-5585
Feature: As staff I want to apply for a Single Trip Overweight Oversize Empty (STWSE) permit with a length over 27.5m so that I can move my vehicle given the length beyond 27.5m triggers a legal "overload" condition regardless of whether a commodity is being carried.

users = PC, SA, TRAIN, CTPO

# Permit Details
See User Apply for STWSE feature AND staff date rules
Applying for Permits/Permit start and duration Staff.feature

# Vehicle Information
See User Apply for STWSE feature

# Dimensions (Metres)
See User Apply for STWSE feature

# Dimension Based Submission Rules
See User Apply for STWSE feature

@orv2-5585
Rule: staff can add an STWSE permit application to the cart with violations for OAW, OAL, OAH

  Scenario: > OAW, OAL, OAH violations add to cart
    Given staff have inputted any of the following dimensions:
      | Dimension | Value |
      | OAW       | > 3.2 |
      | OAL       | > 31  |
      | OAH       | > 4.3 |
      And they have continued to review and confirm the application
     When staff choose to add the application to the cart
     Then staff see the following modal warning message:
      "Application has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit application and would like to add it to the cart." 
      And they have the option to "Cancel" or "Add to Cart"
  
  Scenario: < 27.5m OAL violation
    Given staff have inputted any of the following dimensions:
      | Dimension | Value  |
      | OAL       | < 27.5 |
      And they have continued to review and confirm the application
     When staff choose to add the application to the cart
     Then staff see the following modal warning message:
      "Application has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit application and would like to add it to the cart." 
      And they have the option to "Cancel" or "Add to Cart"

# Overload (kg)
See User Apply for STWSE feature

# Trip Details
See User Apply for STWSE feature

# Review and Confirm
See User Apply for STWSE feature

# Fee Calculation and Fee Summary
See User Apply for STWSE feature

# Notes:
staff new application always goes to cart
	- always goes to the cart 
	- less than 27.5 still stops staff
	- allow OAW, OAL, OAH with any number
- do staff see the the must submit warning
	- yes but generic now
	- +pop up warning
		- lists only what triggered the warning
		- shows on amend as well
- Refunds 
	- do we ever need to refund a portion of the fee, like the falt rate vs 10km rate
		- all or nothing
	- increase permit value possible
		- add weight and kilometers can increase the permit value
	- refund to multiple payment methods summary table
		- no specific issues
- Free Flag
	- Permit can be free
- LCV
	- no LCV vehicles
- LOA
	- not LOA 
- Receipt