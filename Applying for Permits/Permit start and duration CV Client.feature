Feature: Permit start and duration CV Client

Start Date Rules:

| Permit | Rule                        |
| TROS   | Today to 14 days from today |
| TROW   | Today to 14 days from today |
| STOS   | Today to 14 days from today |
| STOW   | Today to 14 days from today |
| MFP    | Today to 14 days from today |
| STFR   | Today to 14 days from today |
| QRFR   | Today to 14 days from today |
| NRSCV  | Today to 14 days from today |
| NRQCV  | Today to 14 days from today |

Rule: a CV Client can choose a start date up to 14 days from today (current date and time the application is initiated)

  Scenario: 5 days
    Given todays date is 2024/05/10
     When a user chooses a start date of 2024/05/15
     Then their start date is available

  Scenario: 15 days
    Given todays date is 2024/05/10
     When a user chooses a start date of 2024/05/25
     Then their start date is not available

Permit Duration Rules:

Duration Overview:
| Permit | Amend Duration                  |
| TROS   | Up to 30 days from from today   |
| TROW   | Up to 30 days from from today   |
| STOS   | Up to 7 days forward from today |
| STOW   | Up to 7 days forward from today |
| MFP    | Up to 7 days forward from today |
| STFR   | Up to 30 days forward           |
| QRFR   | N/A                             |
| NRSCV  | Up to 30 days forward           |
| NRQCV  | N/A                             |