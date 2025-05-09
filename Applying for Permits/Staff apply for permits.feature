Feature: Staff apply for permits

Staff = SA, PC, CTPO, Trainee

@orv2-3835-1
Rule: only authorized staff can apply for a permit on behalf of a cv client

  Scenario: authorized
     When PC, SA, TRAIN, FIN, CTPO are at a cv client permits
     Then they see the option to start a permit application

  Scenario: not authorized
     When Fin, EO, HQA are at a cv client permits
     Then they see the option to start a permit application
      And they see the available permit types
      But they cannot start a permit application

Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

Rule: Staff may add an STOS permit to the cart


