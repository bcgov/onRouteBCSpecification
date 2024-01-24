@e2e4
Feature: Complete TROS permit details
    As a CV Client I need to enter the parameters of my desired TROS permit so that I can get approved and receive my permit.

@orv2-550-1
  Scenario: Permit start date accepted
    Given the CV Client is at "Permit Application"
     When they enter a start date up to 14 days into the future of the current date
     Then their start date is accepted

@orv2-550-2
  Scenario: Permit start date not accepted
    Given the CV Client is at "Permit Application"
     When they enter a "Start Date" before the current date
     Then the start date is not accepted
     And they see "Start Date cannot be in the past."

@orv2-550-3
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

@orv2-550-4 @orv2-555-7
  Scenario: Permit duration calculation
    Given the CV Client is at "Permit Application"
     When they select a <permit duration>
     Then the <permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <start date>

     Example:
       | start date | permit duration | permit expiry date |
       | 03/01/2023 | 30              | March 30, 2023     |
       | 03/15/2023 | 30              | April 13, 2023     |

@orv2-550-5
  Scenario: User sees an information box
    Given the CV Client is at "Permit Application"
    When they are about to select a <commodities Decription>
    Then they see an an information box above <commodities Decriptions> with text {See UX Hifi Design for text and format}

@orv2-550-6
  Scenario: Select the Commodities and relevant CVSE forms
    Given the CV Client is at "Permit Application"
     When they select a <"commodities" Decription> 
     Then the selected CVSE form will be attached to their permit after payment
     And they are able to select multiple <"commodities" Descriptions>
     And by default <Gerneral Permit Conditions> and <Permit Scope and limitation> are already selected for the user and cannont be unselected. 