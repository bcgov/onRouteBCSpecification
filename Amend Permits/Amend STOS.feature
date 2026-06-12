Feature: Amend Single Trip Oversize Permit

Staff = PC, SA, TRAIN, CTPO

@orv2-4015-1
Rule: staff can amend all contact information except company email

@orv2-4015-2
Rule: staff can extend duration up to 30 days

  Scenario: issued with 7 days
    Given permit A has a start date of 05/02/2025
      And a duration of 7 days
     When staff amend permit A duration to 20 days
     Then the end date is 05/22/2025

  Scenario: issued with 30 days
    Given permit A have a 30 day duration
     When staff amend duration
     Then they cannot add additional days
      But they can reduce duration

@orv2-4015-3
Rule: staff can reduce duration of an issued or active permit

  Scenario: reduce issued duration expired
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff reduce the duration to 2 days
      Then the Permit Expiry Date is 05/04/2025
       And the permit is expired

  Scenario: reduce issued duration not expired
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff reduce the duration to 2 days
      Then the Permit Expiry Date is 05/04/2025
       And the permit remains active

@orv2-4015-4
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

@orv2-4015-5
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

@orv2-4015-6
Rule: amendments to commodity information are subject to policy restrictions that exist in the new STOS application form

  Scenario: vehicles exist warning
    Given vehicles have been added to the permit application
     When a user chooses to chnage the commodity
     Then they see "Change Commodity Type Changing your commodity will require you to re-enter your vehicle information and loaded dimensions."

  Scenario: vehicles exist confirm change
    Given a user initiated a commodity change
     When a user chooses to continue
     Then the commodity type is removed 
      And all inputted vehicle information is removed
      And all inputted loaded dimensions is removed

@orv2-4015-7
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

@orv2-4015-8
Rule: amendments to trailers are subject to policy restrictions that exist in the new STOS application form

@orv2-4015-9
Rule: amendments to loaded dimensions are subject to policy restrictions that exist in the new STOS application form

@orv2-4015-10
Rule: amendments to trip details are subject to mandatory field behaviour that exist in the new STOS application form

@orv2-4015-11
Rule: all STOS amendments are $0 and continue to finish amendment screen

@orv2-4099-6
Rule: staff can amend the return trip designation

@orv2-4099-7
Rule: if staff amend results in a debit (NPV is greater than CPV) they can add the APA to the shopping cart

  Scenario: one way to return trip
    Given the APA is a one way trip
     When staff amend the return trip designation to return trip
      And continue to review and confirm
     Then they see the trip type as "Return Trip"
      And they see "Permitted for return trip along the same route."
      And the NPV is $30
      And they can add the APA to the shopping cart

@orv2-4099-8
Rule: if amend results in a credit (NPV is less than CPV) then only SA can continue to refund to multiple payment methods

  Scenario: NPV less than CPV
    Given the CPV is $30
     When staff amend the return trip designation to one way
      And continue to review and confirm
     Then they see the trip type as "One Way Trip"
      And the NPV is $15
      And SA can continue to refund to multiple payment methods

  Scenario: NPV less than CPV PC, Train, CTPO
    Given the NPV is less than CPV
     When PC, Train, CTPO choose to continue
     Then they see "Authorization Required Your changes have been saved Amending Permit #: P2-00011018-750 This amendment results in a refund. Note the Amending Permit # and inform authorized staff to process the refund. Exit"

  Scenario: NPV less than CPV PC, Train, CTPO warning continue
    Given PC, Train, CTPO are at authorization required warning modal
     When they choose to exit
     Then they are directed to the location they initiated the amendment action from

@orv2-4099-9
Rule: if staff amend results in the NPV being equal to the CPV they can continue to refund to multiple payment methods
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