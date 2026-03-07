@ORV2-5255 https://moti-imb.atlassian.net/browse/ORV2-5255
Feature: As a user I need to be able to record my OL number so that I can submit a STOW permit application with ASW evaluation errors for approval by the PPC.

Users:
CA, PA, PC, SA, TRAIN, CTPO

Rule: hide approval no. feild if left at default no

  Scenario: 
    Given 
     When 
     Then 
#
Rule: show on review and confirm if no or yes if no do not show the Approval No. header   

  Scenario: 
    Given 
     When 
     Then 
#
# Questions:

# Notes:
# 2026-03-05
- Extraordinary Load Request
 - Is this an extraordinary load permit application?
	 - Default to No
	 - Input Yes 
		- Approval No. - required field
- Future coniderations: Add a third radio button to request an EOL - disables the Approval No. Field
 - Likely in STWS only the OL number will likely be used
 - will want these shown in queue in some way to differentiate them from other permit applications
- Staff edit in queue 
- Staff reject permit application
- CV Client edit rejected application  

- Overload OL Number (weight)
	- STOW
	- Alphanumeric
	- Search?
	- not mandatory
	- Is this an Extraordinary Overload EOL? Yes/No
		- Yes
			- OL number field available
		- No
			- OL Number is not available
	- If OL number exists then a user can submit the STOW application with eval errors
	 - Expiry date exists - if this is true then how do we handle the the expiry date if we are allowing the permit application to be submitted with errors?

- TR Number (size)
	- STOS
	- STWS
- Size and weight may need both numbers for overweight we only need one
- Alphanumeric
- indicate in the 