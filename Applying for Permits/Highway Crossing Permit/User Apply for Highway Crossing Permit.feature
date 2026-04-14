@orv2-5484-20 https://moti-imb.atlassian.net/browse/ORV2-5484-21-5484-22
Feature: As a user, I need to be able to apply for a Highway Crossing Permit so that I can legally cross a highway with an oversize or overweight load.

# Application Form
@orv2-5484-1
Rule: the default start date is select and the date format is hinted as YYY-MM-DD

  Scenario: default state arrive
    When a user arrives at the application form
    Then the start date field shows "Select"
     And there is a hint that the date format is YYYY-MM-DD

  Scenario: default date delete
    Given a user has chosen a start date
     When they delete the chosen start date
      Then the start date field shows "Select"
       And there is a hint that the date format is YYYY-MM-DD 

@orv2-5484-2
Rule: the default expiry date is the end of the current year at 11:59:59 PM

  Scenario: default state
    When a user arrives at the application form
    Then the expiry date is December 31 of the current year at 11:59:59 PM
 
@orv2-5484-3
Rule: the expiry date is always December 31 at 11:59:59 PM

 #See: Applying for Permits/Permit start and duration CV Client.feature And Applying for Permits/Permit start and duration Staff.feature for start date rules and duration rules for Highway Crossing Permits

  Scenario: choose start date next year
    Given it is 2026-11-15
     When a user chooses a start date of 2027-01-01
     Then the expiry date is December 31, 2027 at 11:59:59 PM

@orv2-5484-4
Rule: the permit fee is a flat fee of $30

  Scenario: review and confirm page
     Given a user has filled out the application form
      And they are on the review and confirm page
     Then the permit fee is shown as $30

@orv2-5484-5
Rule: the only CVSE form is CVSE-1070 and it is chosen by default 

  Scenario: default state
    When a user arrives at the application form
    Then the only CVSE form option is "CVSE-1070"
     And "CVSE-1070" is selected by default 
     And cannot be changed

@orv2-5484-6
Rule: a section ICBC Certificate of Insurance is shown with information about the certificate and a question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?" with options Yes and No

@orv2-5484-7
Rule: show ICBC Certificate of Insurance info box

 "A valid ICBC Certificate of Insurance is required in addition to a Highway Crossing Permit.
 If the vehicle has a valid BC license plate and insurance, please select No and proceed to the Vehicle Information section below.

 If the vehicle does not have a valid BC license plate and insurance, an ICBC Certificate of Insurance for Crossing Permit (MV1805/
 APV36) must be obtained by contacting the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca

 Once the MV1805/APV36 is obtained, please select Yes to enter the certificate number and enter "NA" for Plate in the Vehicle
 Information section below."

@orv2-5484-8
Rule: No is the default answer for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?" and the user must select Yes to see the Certificate Number input field

  Scenario: default state
    When a user arrives at the application form
    Then the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?" is answered with "No" by default
     And the input field for the Certificate Number is not visible

  Scenario: select yes
    Given a user has arrived at the application form
     When they select "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"
      Then an input field for the Certificate Number is shown

@orv2-5484-9
Rule users can choose to input a Certificate of Insurance number and must enter the certificate number and "NA" for the plate if they select "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"

  Scenario: input cert number and NA for plate
    Given a user has selected "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"
     When they input a certificate number and "NA" for the plate
      Then the certificate number and "NA" for the plate are saved in the application

  Scenario: select yes but do not input NA for plate
    Given a user has selected "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"
     When they do not input "NA"for the plate
      Then they see "This is a required field" error messages for plate input field
       And plate input field is highlighted in red
       And they cannot continue with the application until they input "NA" for the plate

  Scenario: select yes but do not input cert number
    Given a user has selected "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"
     When they do not input a certificate number
      Then they see "This is a required field" error messages for Certificate Number input field
       And Certificate Number input field is highlighted in red
       And they cannot continue with the application until they input a certificate number

@orv2-5484-10
Rule: vehicle type defaults to select and vehicle sub-type is disabled

  Scenario: default state
    When a user arrives at the application form
    Then the vehicle type field shows "Select"
     And the vehicle sub-type field is disabled

@orv2-5484-11
Rule: vehicle sub-type is only available when vehicle type is power unit or trailer

  Scenario: select power unit
    Given a user has arrived at the application form
     When they select "Power Unit" for the vehicle type
      Then the vehicle sub-type field is enabled and shows "Select"

  Scenario: select trailer
    Given a user has arrived at the application form
     When they select "Trailer" for the vehicle type
      Then the vehicle sub-type field is enabled and shows "Select"

  Scenario: select other
    Given a user has arrived at the application form
     When they select "Other" for the vehicle type
      Then the vehicle sub-type field is disabled and shows "Other"
      And a new input field for "Vehicle Description" is shown

@orv2-5484-12
Rule: choosing a vehicle type of "Other" disables the vehicle sub-type input field

  Scenario: other then recall from inventory
    Given vehicle type is "Other"
      And there is a vehicle description
     When a user recalls vehicle A from inventory with the following details:
      | Vehicle Type | Vehicle Sub-Type |
      | Power Unit   | Truck Tractor    |
     Then the vehicle type is updated to "Power Unit"
      And the vehicle sub-type is updated to "Truck Tractor"
      And the vehicle description is cleared
      And the vehicle description input field is unavailable

  Scenario: recall from inventory then other
    Given vehicle A is in inventory with the following details:
      | Vehicle Type | Vehicle Sub-Type |
      | Power Unit   | Truck Tractor    |
     When a user recalls vehicle A from inventory
      And they change the vehicle type to "Other"
     Then the vehicle sub-type is "Other" and disabled
      And the vehicle description input field is available 

  Scenario: change vehicle type to power unit or trailer
    Given vehicle type is "Other"
      And there is a vehicle description
     When a user changes the vehicle type to "Power Unit"
     Then the vehicle description is cleared
      And the vehicle description input field is unavailable
      And the vehicle sub-type is enabled and shows "Select"
      And the user can choose to save the vehicle to inventory

@orv2-5484-13
Rule: choosing a vehicle type of "Other" enables a new input field for "Vehicle Description"

  Scenario: other then recall from inventory
    Given vehicle type is "Other"
      And there is a vehicle description
     When a user recalls vehicle A from inventory with the following details:
      | Vehicle Type | Vehicle Sub-Type |
      | Power Unit   | Truck Tractor    |
     Then the vehicle type is updated to "Power Unit"
      And the vehicle sub-type is updated to "Truck Tractor"
      And the vehicle description is cleared
      And the vehicle description input field is unavailable

  Scenario: recall from inventory then other
    Given vehicle A is in inventory with the following details:
      | Vehicle Type | Vehicle Sub-Type |
      | Power Unit   | Truck Tractor    |
     When a user recalls vehicle A from inventory
      And they change the vehicle type to "Other"
     Then the vehicle sub-type is "Other" and disabled
      And the vehicle description input field is available 

  Scenario: change vehicle type to power unit or trailer
    Given vehicle type is "Other"
      And there is a vehicle description
     When a user changes the vehicle type to "Power Unit"
     Then the vehicle description is cleared
      And the vehicle description input field is unavailable
      And the vehicle sub-type is enabled and shows "Select"
      And the user can choose to save the vehicle to inventory

@orv2-5484-14
Rule: a vehicle type of "Other" cannot be saved to vehicle inventory

  Scenario: other then save to inventory
    Given vehicle type is "Other"
      And there is a vehicle description
     When a user tries to save the vehicle to inventory
     Then the option to save the vehicle to inventory is not available

@orv2-5484-15
Rule: the maximum number of characters for the "Vehicle Description" field is 100 characters

  Scenario: max characters
    Given a user has selected "Other" for the vehicle type
     When they input a vehicle description that is 100 characters long
     Then the vehicle description is accepted

  Scenario: exceed max characters
    Given a user has selected "Other" for the vehicle type
     When they input a vehicle description that is 101 characters long
     Then the 101st character is not accepted

@orv2-5484-16
Rule: "Vehicle Description" field is required when vehicle type is "Other"

  Scenario: required field
    Given a user has selected "Other" for the vehicle type
     When they do not input a vehicle description
      Then they see "This is a required field" error message for the vehicle description input field
       And the vehicle description input field is highlighted in red
       And they cannot continue with the application until they input a vehicle description

@orv2-5484-17
Rule: choosing a different answer to the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?" clears the vehicle plate and the Certificate No. input field

  Scenario: yes to no
    Given a user has selected "Yes" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?" and inputted a certificate number and "NA" for the plate
     When they change their answer to "No"
      Then the certificate number and plate input fields are cleared

  Scenario: no to yes
    Given a user has selected "No" for the question "Do you have an ICBC Certificate of Insurance for Crossing Permit (MV1805/APV36)?"
     And there is plate information inputted for the vehicle
     When they change their answer to "Yes"
      Then the plate input fields are cleared

# Review and Confirm
@orv2-5484-18
Rule: if "No" is selected for the question "Do you have an ICBC Certificate of Insurance?" the ICBC Certificate of Insurance section is shown on "review and confirm" page with the following information:
 "ICBC Certificate of Insurance: No"

@orv2-5484-19
Rule: if "Yes" is selected for the question "Do you have an ICBC Certificate of Insurance?" the ICBC Certificate of Insurance section is shown on "review and confirm" page with the following information:
 "ICBC Certificate of Insurance: Yes
 Certificate Number: [user inputted certificate number]"

# Notes:
- confirm the start date rules for staff any day in past to 90 days from today?
- Amend, VOID, Revoke