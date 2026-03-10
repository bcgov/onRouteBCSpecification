@ORV2-5255 https://moti-imb.atlassian.net/browse/ORV2-5255
Feature: As a user I need to be able to record my Overload (OL) number so that I can submit a STOW permit application with ASW evaluation errors for approval by the PPC.

Users:
CA, PA, PC, SA, TRAIN, 

Rule: The approval number question default answer is no and the approval no. field is hidden on the application form until the user selects yes for the extraordinary load request question

  Scenario: chose no for extraordinary load request
    Given the user has selected "No" for the question "Is this an extraordinary load permit application?"
     Then the "Approval No." field is not be visible

  Scenario: chose yes for extraordinary load request
    Given the user has selected "Yes" for the question "Is this an extraordinary load permit application?"
     Then the "Approval No." field is visible
#
Rule: The approval number field is required if the user selects yes for the extraordinary load request question

  Scenario: chose yes for extraordinary load request and inputted approval no.
    Given the user has selected "Yes" for the question "Is this an extraordinary load permit application?"
     When they have inputted "12345" into the "Approval No." field
     Then they can continue to review and confirm

  Scenario: chose yes for extraordinary load request and did not input approval no.
    Given the user has selected "Yes" for the question "Is this an extraordinary load permit application?"
     When they have not inputted anything into the "Approval No." field
      And they have attempted to continue to review and confirm
     Then they see "This is arequired field" error message for the "Approval No." field
      And the "Approval No." field is highlighted in red
      And they cannot continue to review and confirm
      
#
Rule: Show user inputted selection on review and confirm if no or yes if no do not show the Approval No. header   

  Scenario: chose no for extraordinary load request
    Given the user is applying for a STOW permit and is on the review and confirm page
     When the user has selected "No" for the question "Do you have an extraordinary load approval??"
      And they have continued to review and confirm
     Then the review and confirm page should show:
      | Question                                          | Answer |
      | Do you have an extraordinary load approval? | No     |
      And the review and confirm page should not show the header "Approval No."

  Scenario: chose yes for extraordinary load request
    Given the user is applying for a STOW permit and is on the review and confirm page
     When the user has selected "Yes" for the question "Do you have an extraordinary load approval?"
      And they have inputted "12345" into the "Approval No." field
      And they have continued to review and confirm
     Then the review and confirm page should show:
      | Question                                          | Answer |
      | Is this an extraordinary load permit application? | Yes    |
      | Approval No.                                      | 12345  |
#
Rule: A user can submit a STOW permit application with ASW evaluation errors if they have inputted an OL number

  Scenario: submit with ASW evaluation errors
    Given the user is applying for a STOW permit and is on the review and confirm page
     When the user has inputted "OL12345" into the "Overload Number" field
      And they have continued to review and confirm
     Then the user can submit the STOW permit application even if there are ASW evaluation errors
#
# Questions:
- Do we want to indicate that it is an OL appl in AIP?
- Indicate the OL app in the queue
- permissions? Staff uniqueness? - not that I am aware of
	 - Expiry date exists - if this is true then how do we handle the the expiry date if we are allowing the permit application to be submitted with errors? - Not yet, we will rely on humans to confirm the OL number is valid.

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


- TR Number (size)
	- STOS
	- STWS
- Size and weight may need both numbers for overweight we only need one
- Alphanumeric
- indicate in the 