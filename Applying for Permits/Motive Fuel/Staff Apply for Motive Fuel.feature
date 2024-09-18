Feature: CV Client Apply for a Motive Fuel Permit

CV Client = CA, PA


Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."