Feature: Permit duration calculation

Rule: Te permit duration begins on the chosen start date and ends at 00:00:00 on the expiry date

  Scenario: 30 day term
    Given the chosen start date is 2024/08/17
     When a user chooses a permit duration of 30 days
     Then the permit expiry is Sept 15, 2024 at 23:59:59

  Scenario: 3 day term
    Given the chosen start date is 2024/05/10
     When a user chooses a permit duration of 3 days
     Then the permit expiry is May 12, 2024 at 23:59:59


