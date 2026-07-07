@orv2-5685-1 https://moti-imb.atlassian.net/browse/ORV2-5685
Feature: As an authorized staff user, I want to be able to amend a Heavy Commercial (HC) permit so that I can update the permit details on behalf of the applicant.

Staff = PC, SA, TRAIN, CTPO

# Note
# See the following feature files for additional specs:
# - User Apply for HC
# - Staff Apply for HC
# - Common amend Permit Rules
# - Permit start and duration Staff

# Contact Information
@orv2-5685-2
Rule: staff can change all contact information except company email
# Permit Details
 # see Permit start and duration Staff feature file for rules related to permit start and duration
@orv2-5685-3
Rule: staff can change the start date of an issued or active permit

  Scenario: change start date to previous year
    Given the current date is 05/02/2025
     When staff change the start date to 05/01/2024
     Then they see "Start date is in the past"

Rule: staff are notified when start date and/or expiry date are in the past

   Scenario: on application form
     Given the current date is 05/02/2025
      When staff change the start date to 05/01/25
      Then they see "Start date is in the past"
 
   Scenario: on review and confirm
     Given the current date is 05/02/2025
      When staff change the start date to 05/01/25
       And continue to review and confirm
      Then they see "Start date and/or expiry date is in the past"

# ICBC Certificate of Insurance
@orv2-5685-4
Rule: staff can change the choice of certificate of insurance and update the certificate number

  Scenario: change certificate of insurance to yes
    Given a permit has a certificate of insurance selected
     When staff choose to change the certificate of insurance
     Then they can enter a new certificate number
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
     Then the certificate number is deleted
      And the vehicle plate will be deleted
      And they can edit the vehicle plate field
      And they are able to recall a vehicle from inventory
      And the certificate number field is hidden
      But the other vehicle details remain

# Vehicle Information
 # see the following feature file for rules related to vehicle information:
 # - User Apply for HC
 # - Staff Apply for HC
@orv2-5685-5
Rule: staff can change power unit details and recall a new power unit with an allowable vehicle sub-type without impacting other application data

  Scenario: other then recall from inventory
    Given vehicle type is "Other"
      And there is a vehicle description
     When staff recalls vehicle A from inventory with the following details:
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
     When staff recalls vehicle A from inventory
      And they change the vehicle type to "Other"
     Then the vehicle sub-type is "Select" and disabled
      And the vehicle description input field is available 
      And staff cannot save the vehicle to inventory

  Scenario: change vehicle type to power unit or trailer
    Given vehicle type is "Other"
      And there is a vehicle description
     When staff changes the vehicle type to "Power Unit"
     Then the vehicle description is cleared
      And the vehicle description input field is unavailable
      And the vehicle sub-type is enabled and shows "Select"
      And staff can choose to save the vehicle to inventory

# Finish, Refund and Add to Cart Submission Rules
@orv2-5685-6
Rule: if staff amend results in the NPV being equal to the CPV ($0) they can continue to finish amendment screen

  Scenario: $0 amend plate change
    Given the CPV is $30
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0  |
      And they can continue to finish amendment screen

  Scenario: $0 amend forward date to next year
    Given the CPV is $30
     When staff amend the return trip designation to one way
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0  |
      And they can continue to finish amendment screen

  Scenario: $0 amend backdate to previous year
    Given the CPV is $30
     When staff amend the start date to 05/01/2024
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0  |
      And they can continue to finish amendment screen

# Review and Confirm
@orv2-5685-7
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

  Scenario: > CPV
    Given the CPV is $15
     When staff change the return trip designation to return trip
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $15 |
       | New Permit Value     | $30 |
       | Total                | $15 |

  Scenario: < CPV
    Given the CPV is $30
     When staff change the return trip designation to one way
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30  |
       | New Permit Value     | $15  |
       | Total                | -$15 |

  Scenario: = CPV ($0 change)
    Given the CPV is $30
     When staff change the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0   |

# Fee Calculation and Fee Summary
 #see fee calculation and fee summary rules in the following feature files:
 # - User Apply for HC       