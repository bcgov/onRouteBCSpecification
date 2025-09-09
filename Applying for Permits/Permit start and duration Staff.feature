Feature: Permit start and duration Staff

staff = PC, SA, TRAIN, CTPO

Permit Start Date Overview:

| Permit | Rule                                |
| TROS   | Any past date to 60 days from today |
| TROW   | Any past date to 60 days from today |
| STOS   | Any past date to 60 days from today |
| STOW   | Any past date to 60 days from today |
| MFP    | Any past date to 60 days from today |
| STFR   | Any past date to 60 days from today |
| QRFR   | Any past date to 60 days from today |
| NRSCV  | Any past date to 60 days from today |
| NRQCV  | Any past date to 60 days from today |

Rule: staff must choose a start date to a maximum of 60 days from today (current date and time the application is initiated)

  Scenario: 5 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/15
     Then their start date is available

  Scenario: 15 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/25
     Then their start date is not available

Rule: staff can backdate the permit start date to any date from today (current date and time the application is initiated) except quarterly permits

  Scenario: permit start date accepted
    Given staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

  Scenario: backdate causes expiry
    Given permit application A has the following chosen date details:
      | data               | date data  |
      | Start Date         | 05/02/2025 |
      | Permit Duration    | 5          |
      | Permit Expiry Date | 05/07/2025 |
      And today is 05/08/2025
     When staff continue to review and confirm
     Then they see "Start date and/or expiry date is in the past"
      And the permit is expired  

  Scenario: backdate remains active
    Given permit A has the following chosen date details:
      | data               | date data  |
      | Start Date         | 05/02/2025 |
      | Permit Duration    | 5          |
      | Permit Expiry Date | 05/07/2025 |
      And today is 05/06/2025
     When staff continue to review and confirm
     Then they do not see "Start date and/or expiry date is in the past"
      And the permit is active   

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

Permit Duration Overview:

Duration Overview:
| Permit | Amend Duration                         |
| TROS   | Up to 1 y forward in 30 day increments |
| TROW   | Up to 1 y forward in 30 day increments |
| STOS   | Up to 30 days forward                  |
| STOW   | Up to 30 days forward                  |
| MFP    | Up to 7 days forward                   |
| STFR   | Up to 30 days forward                  |
| QRFR   | N/A                                    |
| NRSCV  | Up to 30 days forward                  |
| NRQCV  | N/A                                    |

Rule: staff must choose a permit length in increments of one day, with a maximum of 30 days for STOS, STFR, NRSCV and STOW

  Scenario: Permit length accepted
     When they choose 1 from the list of days availavle:
       | 1 Day |
       | 2 Days |
       | 3 Days |
       | 4 Days |
       | 5 Days |
       | 6 Days |     
       | 7 Days |
       | 8 Days |
       | 9 Days |
       | 10 Days |
       | 11 Days |
       | 12 Days |
       | 13 Days |
       | 14 Days |
       | 15 Days |
       | 16 Days |
       | 17 Days |
       | 18 Days |
       | 19 Days |
       | 20 Days |
       | 21 Days |
       | 22 Days |
       | 23 Days |
       | 24 Days |
       | 25 Days |
       | 26 Days |
       | 27 Days |
       | 28 Days |
       | 29 Days |
       | 30 Days |
     Then their permit length is accepted