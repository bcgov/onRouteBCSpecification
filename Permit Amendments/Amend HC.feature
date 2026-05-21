Feature: Amend Highway Crossing Permit

Staff = PC, SA, TRAIN, CTPO

@orv2
Rule: staff can amend all contact information except company email

@orv2
Rule: staff can change the start date of an issued or active permit

  Scenario: change start date to previous year
    Given the current date is 05/02/2025
     When staff amend the start date to 05/01/2024
     Then they see "Start date is in the past"

create expired condition

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

Rule: staff can change the choice of certificate of insurance and update the certificate number

  Scenario: change certificate of insurance to yes
    Given a permit has a certificate of insurance selected
     When staff choose to change the certificate of insurance
     Then they are directed to the edit certificate of insurance screen
      And they can choose a different certificate of insurance from the dropdown
      And they can enter a new certificate number
      And they can save the changes
      And they are directed to the review and confirm screen
      And they see the updated certificate of insurance and certificate number
      
  Scenario: change certificate of insurance to no
    Given a permit has a certificate of insurance selected
     When staff choose to change the certificate of insurance to no
     Then they certificate number is deleted
      And they certificate number field is hidden
      And they are directed to the review and confirm screen
      And they see the updated certificate of insurance and that the certificate number is removed

@orv2
Rule: staff can amend any power unit detail except vehicle sub-type and recall a new power unit with an allowable vehicle sub-type without impacting other application data

  Scenario: edit power unit
    Given there is a power unit
     When staff choose to edit
     Then they are directed to the edit power unit screen
      And vehicle sub-type is not available

  Scenario: edit plate
    Given staff have chosen to edit the power unit
     When they amend the plate to ABC123
      And choose done
     Then they are directed to the application form
      And the plate is ABC123

  Scenario: recall new vehicle
    Given a commodity is chosen
     When staff choose to recall a new vehicle
     Then only allowable vehicle sub-types are available

Other vehicle sub-type considerations
no licensed GVW

@orv2
Rule: amendments to trailers are subject to policy restrictions that exist in the new STOS application form

@orv21
Rule: all amendments are $0 and continue to finish amendment screen

@orv2-4099-9
Rule: if staff amend results in the NPV being equal to the CPV  ($0) they can continue to refund to multiple payment methods
@orv2-4099-10
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

  Scenario: > CPV
    Given the CPV is $15
     When staff amend the return trip designation to return trip
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $15 |
       | New Permit Value     | $30 |
       | Total                | $15 |

  Scenario: < CPV
    Given the CPV is $30
     When staff amend the return trip designation to one way
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30  |
       | New Permit Value     | $15  |
       | Total                | -$15 |

  Scenario: = CPV ($0 amend)
    Given the CPV is $30
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0   |