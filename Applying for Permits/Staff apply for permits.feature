Feature: Staff apply for permits

Staff = SA, PC, CTPO, Trainee

Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

Rule: Staff may add an STOS permit to the cart


