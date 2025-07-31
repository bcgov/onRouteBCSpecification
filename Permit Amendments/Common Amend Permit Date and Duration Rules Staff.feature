
Feature: Amend Permit Date and Duration Rules Staff

Staff = SA, PC, CTPO, Trainee

Start Date Overview:
| Permit | Rule                                             |
| TROS   | Any past date to 60 days from today              |
| TROW   | Any past date to 60 days from today              |
| STOS   | Any past date to 60 days from today              |
| MFP    | Any past date to 60 days from today              |
| STFR   | Any past date to 60 days from today              |
| QRFR   | Same quarter as Start date to 60 days from today |
| NRSCV  | Any past date to 60 days from today              |
| NRQCV  | Same quarter as Start date to 60 days from today |

Rule: staff can forward start date to a maximum of 60 days from today (current date and time the amend is initiated)

   Scenario: forward greater than 60 days
    Given the current date is 05/01/2025
    When staff choose to amend the start date to 07/05/2025
    Then 07/05/2025 is not available
    
   Scenario: forward within 60 days
    Given the current date is 05/01/2025
    When staff choose to amend the start date to 06/01/2025
    Then 06/01/2025 is available
   
  Scenario: forward date remains active
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


Rule: staff can backdate the permit start date to any date from today (current date and time the amend is initiated) except quarterly permits

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

Rule: staff can backdate the start date within the calendar quarter for a qrtly permit

  Scenario: backdate greater than quarter
   Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date to 04/01/2025
     Then 04/01/2025 is not available

  Scenario: back within quarter
   Given permit A has a start date of 05/01/2025
     When staff choose to amend the start date 
     Then they can chose a maximum past start date of 04/01/2025

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

Duration Overview:
| Permit | Amend Duration                              |
| TROS   | Up to 330 days back in 30 day increments    |
| TROW   | Up to 330 days back in 30 day increments    |
| STOS   | Up to 30 days back to up to 30 days forward |
| MFP    | Up to 7 days back to up to 7 days forward   |
| STFR   | Up to 30 days back to up to 30 days forward |
| QRFR   | N/A                                         |
| NRSCV  | Up to 30 days back to up to 30 days forward |
| NRQCV  | N/A                                         |

Rule: staff can reduce the duration of an issued or active STOS, STFR, NRSCV permit by Up to 30 days back

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

Rule: staff can extend the duration of an issued or active STOS, STFR, NRSCV permit by Up to 30 days forward

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

Rule: staff can extend the duration of an issued or active MFP permit by Up to 7 days forward

  Scenario: extend issued duration valid
    Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff extend the duration to 10 days
      Then the Permit Expiry Date is 05/12/2025

Rule: staff can reduce the duration of an issued or active MFP permit by Up to 7 days forward

  Scenario: reduce issued duration valid
     Given permit A has the following issued date details:
      | data               | issued data |
      | Start Date         | 05/02/2025  |
      | Permit Duration    | 5           |
      | Permit Expiry Date | 05/07/2025  |
     When staff reduce the duration to 3 days
     Then the Permit Expiry Date is 05/05/2025

Rule: staff can reduce the duration of an issued or active TROS and TROW permits by Up to 330 days back in 30 day increments

