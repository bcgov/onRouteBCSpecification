Feature: Permit start and duration Staff

| Permit | Rule                                |
| TROS   | Any past date to 60 days from today |
| TROW   | Any past date to 60 days from today |
| STOS   | Any past date to 60 days from today |
| MFP    | Any past date to 60 days from today |
| STFR   | Any past date to 60 days from today |
| QRFR   | Any past date to 60 days from today |
| NRSCV  | Any past date to 60 days from today |
| NRQCV  | Any past date to 60 days from today |


Rule: staff can choose a start date to a maximum of 60 days from today (current date and time the application is initiated)

  Scenario: 5 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/15
     Then their start date is available

  Scenario: 15 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/25
     Then their start date is not available

