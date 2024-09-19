Feature: Staff Apply for a Motive Fuel Permit

Staff = SA, PC, CTPO, Trainee

@orv2-2612-16
Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."