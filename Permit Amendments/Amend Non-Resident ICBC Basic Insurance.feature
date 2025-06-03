Feature: Amend Non-Resident ICBC Basic Insurance (Single Trip and QTRLY)

Staff = SA, PC, CTPO, Trainee

Note: Non-resident ICBC Basic Insurance (Single Trip and QTRLY) amending permit applications share rules and scenarios with new applications (e.g., mandatory fields, province/sate error) and common amend permit applications (e.g., reason for amendment, revision history).

@orv2-4211-1
Rule: staff can amend all contact information except company email

@orv2-4211-2
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

@orv2-4211-3
Rule: staff can reduce duration for a single trip permit

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

@orv2-4211-4
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

@orv2-4211-5     
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

@orv2-4211-6
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
     
@orv2-4211-7
Rule: staff can amend all vehicle information except vehicle type and recall an allowable vehicle from inventory

@orv2-4211-8
Rule: staff can change the third party liability

  Scenario: increase CPV single trip
    Given single trip permit A has a CPV of $84 (general goods)
     When staff change third party liability to dangerous goods
     Then permit A NPV is $89
     And they can add the APA to the shopping cart

  Scenario: decrease CPV single trip
    Given single trip permit A has a CPV of $89 (dangerous goods)
     When staff change third party liability to general goods
     Then permit A NPV is $84
      And they can continue to refund to multiple payment methods

  Scenario: increase CPV qrtly
    Given single trip permit A has a CPV of $843 (general goods)
     When staff change third party liability to dangerous goods
     Then permit A NPV is $899
     And they can add the APA to the shopping cart

  Scenario: decrease CPV qrtly
    Given single trip permit A has a CPV of $899 (dangerous goods)
     When staff change third party liability to general goods
     Then permit A NPV is $843
      And they can continue to refund to multiple payment methods  

@orv2-4211-9
Rule: if staff amend results in the NPV being equal to the CPV ($0 amend) they can continue to refund to multiple payment methods
@orv2-4211-10
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary
