Feature: Permit start and duration

Rule: The permit duration begins on the chosen start date and ends at 23:59:59 on the expiry date

  Scenario: 30 day term
    Given the chosen start date is 2024/08/17
     When a user chooses a permit duration of 30 days
     Then the permit expiry is Sept 15, 2024 at 23:59:59

  Scenario: 3 day term
    Given the chosen start date is 2024/05/10
     When a user chooses a permit duration of 3 days
     Then the permit expiry is May 12, 2024 at 23:59:59

Rule: A permit start date can be chosen up to 14 days from the current date

  Scenario: 5 days
    Given todays date is 2024/05/10
     When a user chooses a start date of 2024/05/15
     Then their start date is available

  Scenario: 15 days
    Given todays date is 2024/05/10
     When a user chooses a start date of 2024/05/25
     Then their start date is not available

