Feature: Staff Apply for Single Trip Overweight Permit

staff = PC, SA, TRAIN, CTPO

@orv2-4467
Rule: staff must choose a start date to a maximum of 60 days from today (current date and time the application is initiated)

 see: Permit start and duration Staff.feature



  Scenario: 5 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/15
     Then their start date is available

  Scenario: 15 days
    Given todays date is 2024/05/10
     When staff chooses a start date of 2024/05/25
     Then their start date is not available

@orv2-4467
Rule: staff must choose a permit length in increments of one day, with a maximum of 30 days

 See: Permit start and duration Staff.feature

@orv2-4467
Rule: staff can add a permit to the shopping cart with policy validation warnings

@orv2-4467
Rule: staff can are shown an additional warning when continuing to review and confirm for a permit application with policy validation warnings

