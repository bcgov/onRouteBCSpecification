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

Rule: staff are notified when start date and/or expiry date are in the past

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
      And the vehicle plate will be replaced by the certificate number
      And they are unable to recall a vehicle from inventory
      And they cannot save the vehicle to inventory

  Scenario: change certificate number
    Given the certificate number is 123
     When staff change the certificate number to 456
     Then the certificate number is updated to 456
      And the vehicle plate is updated to 456
      And they see the updated certificate number and that the vehicle plate is updated to match

  Scenario: change certificate of insurance to no
    Given a permit has a certificate of insurance selected
     When staff choose to change the certificate of insurance to no
     Then they certificate number is deleted
      And the vehicle plate will be deleted
      But the other vehicle details remain
      And they certificate number field is hidden
      And they are directed to the review and confirm screen
      And they see the updated certificate of insurance and that the certificate number is removed

@orv2
Rule: staff can amend power unit details and recall a new power unit with an allowable vehicle sub-type without impacting other application data

  Scenario: icbc is no
     When a permit has certificate of insurance as no and a vehicle sub-type that is not other
     Then staff can recall a new vehicle from inventory

  Scenario: icbc is yes
     When a permit has certificate of insurance as yes and a certificate number
     Then staff cannot recall a new vehicle from inventory

  Scenario: icbc no recall new vehicle that is not other
    Given 
     When 
     Then 

Rule: staff can only recall a new power unit from inventory when 

@orv21
Rule: all amendments are $0 and continue to finish amendment screen

@orv2-4099-9
Rule: if staff amend results in the NPV being equal to the CPV ($0) they can continue to refund to multiple payment methods

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