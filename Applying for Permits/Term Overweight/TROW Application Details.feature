Feature: CV Client complete TROW permit details
    As a CV Client I need to enter the parameters of my desired TROS permit so that I can get approved and receive my permit.

CV Client = PA, CA

@orv2-1095-1
Rule: Permit start date can be a maximum of 14 days from the date application has started

  Scenario: Permit start date accepted
    Given the CV Client is at "Permit Application"
     When they enter a start date up to 14 days into the future of the current date
     Then their start date is accepted

@orv2-1095-2
Rule: Permit start date cannot be a past date

  Scenario: Permit start date not accepted
    Given the CV Client is at "Permit Application"
     When they enter a start date before the current date
     Then the start date is not accepted
     And they see "Start Date cannot be in the past."
     And "Start Date" is outlined in red

@orv2-1095-3
Rule: Permit duration is a maximum of 1 year, available in 30 day increments

  Scenario: Permit duration
    Given the CV Client is at "Permit Application"
     When they select "Permit Duration"
     Then they see increments of 30 days as follows:
        | 30  |
        | 60  |
        | 90  |
        | 120 |
        | 150 |
        | 180 |
        | 210 |
        | 240 |
        | 270 |
        | 300 |
        | 330 |
        | 1y  |
      And 1y is equal to 1y 

  Scenario: Permit duration calculation
    Given the CV Client is at "Permit Application"
     When they select a <permit duration>
     Then the <permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <start date>

     Example:
       | start date | permit duration | permit expiry date |
       | 03/01/2023 | 30              | March 30, 2023     |
       | 03/15/2023 | 30              | April 13, 2023     |

@orv2-1095-5
Rule: Show the liability information box

  Scenario: User sees an liability information box
    Given the CV Client has completed the date options
    When they review commodities checklist
    Then they see the liability information box

@orv2-1095-6
Rule: Relevant CVSE forms are selected by default

  Scenario: Commodities and relevant CVSE forms
    Given the CV Client is at permit details
     When they review the commodities description checklist
     Then the following CVSE forms are selected:
       | General Permit Conditions            |
       | Permit Scope and Limitation          |
       | Highways and Restrictive Load Limits |
