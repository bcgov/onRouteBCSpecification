Feature: Amend Non-Resident License (Single Trip and QTRLY)

Staff = SA, PC, CTPO, Trainee

Note: Non-resident License (Single Trip and QTRLY) amending permit applications share rules and scenarios with new applications (e.g., mandatory fields, province/sate error) and common amend permit applications (e.g., reason for amendment, revision history). Single Trip permit fees are calculated per month (x/12) and QTRLY permit fees are calculated per calendar quarter (x/4). Like new permit applications, changes to the vehicle sub type, conditional licensing fees, and or vehicle weight can all impact the NPV of a permit.

@orv2-4220-1
Rule: staff can amend all contact information except company email

@orv2-4220-2
Rule: staff can extend duration up to the maximum 30 days for a single trip permit

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

@orv2-4220-3
Rule: staff can reduce duration for a single trip permit up to a maximum of 30 days for a single trip permit

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

@orv2-4220-4
Rule: staff can amend the start date to any date for a single trip permit

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

@orv2-4220-5
Rule: staff can amend the start date within the calendar quarter for a qrtly permit

  Scenario: forward within quarter
    Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date
     Then they can chose a maximum future start date of 06/30/2025

  Scenario: forward outside quarter
    Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date to 07/05/2025
     Then 07/05/2025 is not available

  Scenario: back within quarter
   Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date 
     Then they can chose a maximum past start date of 04/01/2025

@orv2-4220-6
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

@orv2-4220-7
Rule: staff can amend all vehicle information except vehicle type and recall an allowable vehicle from inventory

  Scenario: recall different vehicle sub-type affects CLF
    Given permit A has the vehicle sub type Scraper
      And CLF Industrial (X-Plate type) selected
     When staff recall a different vehicle 1
      And vehicle 1 sub type is Truck Tractors
     Then the CLF in none

  Scenario: recall same vehicle sub-type 
    Given permit A has the vehicle sub type Scraper
      And CLF Industrial (X-Plate type) selected
     When staff recall a different vehicle 1
      And vehicle 1 sub type is Scraper
     Then the CLF is Industrial (X-Plate type)

@orv2-4220-8
Rule: staff can forward date 60 days from the current calendar date

  Scenario: 
    Given 
     When 
     Then 

@orv2-4220-9
Rule: staff can amend the start date within the calendar quarter for a qrtly permit

  Scenario: forward within quarter
    Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date
     Then they can chose a maximum future start date of 06/30/2025

  Scenario: forward outside quarter
    Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date to 07/05/2025
     Then 07/05/2025 is not available

  Scenario: back within quarter
   Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date 
     Then they can chose a maximum past start date of 04/01/2025

@orv2-4220-10
Rule: staff can change the NPV by amending the vehicle weight

  Scenario: increase only weight single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option | CPV    |
     | Scraper          | 6000       | none       | $18.00 |
     When staff increase the loaded gvw to 8000
     Then the NPV is $24.00
      And the total is $6.00

  Scenario: decrease only weight single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option | CPV    |
     | Scraper          | 6000       | none       | $18.00 |
     When staff increase the loaded gvw to 4000
     Then the NPV is $11.00
      And the total is -$7.00

  Scenario: maximum permit value reached single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option                | CPV   |
     | Scraper          | 6000       | Industrial (X-Plate Type) | $9.00 |
     When staff increase the loaded gvw to 24000
     Then the NPV is $22
      And the total is $4.00

@orv2-4220-11
Rule: staff can change NPV by amending the conditional licensing fees

  Scenario: x-plate to none
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option                | CPV   |
     | Scraper          | 6000       | Industrial (X-Plate Type) | $9.00 |
     When staff change the CLF to none
     Then the NPV is $18
      And the total is $9.00

  Scenario: none to x-plate single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option | CPV    |
     | Scraper          | 6000       | none       | $18.00 |
     When staff change the CLF to none
     Then the NPV is $18
      And the total is $9.00

  Scenario: none or conditional to farm single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option | CPV     |
     | Truck Tractors   | 25000      | none       | $104.00 |
     When staff change CLF to farm vehicle
     Then the NPV is $109
      And the total is $5.00
      And the inputted loaded GVW is removed 
      And loaded GVW is unavailable
      And net weight is available

  Scenario: farm to none or Conditional single trip
    Given permit A has the following:
     | vehicle sub-type | loaded gvw | CLF option            | CPV     |
     | Truck Tractors   | 25000      | Farm Vehicle fee rate | $109.00 |
     When staff change CLF to farm vehicle
     Then the NPV is $104
      And the total is -$5.00
      And the inputted loaded GVW is removed 
      And loaded GVW is available
      And net weight is unavailable

@orv2-4220-12
Rule: if staff amend results in a debit (NPV is greater than CPV) they can add the APA to the shopping cart

  Scenario: increased NPV
    Given permit A has the following CPV $104.00
     When staff change CLF to farm vehicle
     Then the NPV is $109
      And they can add the permit to the shopping cart

  Scenario: decreased NPV
    Given permit A has the following CPV $109.00
     When staff change CLF to none
     Then the NPV is $104
      And they can continue to refund to multiple payment methods

@orv2-4220-13
Rule: if staff amend results in a credit (NPV is less than CPV) they can continue to refund to multiple payment methods

  Scenario: increased NPV
    Given permit A has the following CPV $104.00
     When staff change CLF to farm vehicle
     Then the NPV is $109
      And they can add the permit to the shopping cart

  Scenario: decreased NPV
    Given permit A has the following CPV $109.00
     When staff change CLF to none
     Then the NPV is $104
      And they can continue to refund to multiple payment methods

@orv2-4220-14
Rule: if staff amend results in the NPV being equal to the CPV ($0 amend) they can continue to refund to multiple payment methods

  Scenario: plate change
    Given permit A has the following CPV $109.00
     When staff change the vehicle plate
     Then the NPV is $109 ($0 amend)
      And they can continue to refund to multiple payment methods

@orv2-4220-15
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

  Scenario: > CPV CLF single trip
    Given the CPV is $104
     When staff change CLF to farm vehicle
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $104 |
       | New Permit Value     | $109 |
       | Total                | $5  |

  Scenario: < CPV CLF single trip
    Given the CPV is $109
     When change the CLF to none
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $109 |
       | New Permit Value     | $104  |
       | Total                | -$5 |

  Scenario: = CPV ($0 amend)
    Given the CPV is $100
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $100 |
       | Total                | $0   |