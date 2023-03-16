Feature: Complete TROS permit details
    As a CV Client I need to enter the parameters of my desired TRS permit so that I can get approved and recieve my permit.

@orv2-561
  Scenario: Permit start date accepted
    Given the CV Client is at "Permit Application"
     When they enter a start date up to 14 days into the future of the current date
     Then their start date is accepted

@orv2-561
  Scenario: Permit start date not accepted
    Given the CV Client is at "Permit Application"
     When they enter a "Start Date" before the current date
     Then the start date is not accepted
     And they see ""

@orv2-561
  Scenario: Permit duration
    Given the CV Client is at "Permit Application"
     When they select "Permit Duration"
     Then they see increments of 30 as follows:
        | 30 |
        | 60 |
        | 90 |
        | 120 |
        | 150 |
        | 180 | 
        | 210 |
        | 240 | 
        | 270 |
        | 300 |
        | 330 |
        | 360 |
        | 1y |
      And 1y is equal to 365 days 

@orv2-561
  Scenario: Permit duration calculation
    Given the CV Client is at "Permit Application"
     When they select a <permit duration>
     Then the <permit expiry date> displays a future date that is a multiple of the <permit duration> and the <current date>

     Example:
       | current date | permit duration | permit expiry date |
       | 03/15/2023 | 30 | April 14, 2023 |
       | 

