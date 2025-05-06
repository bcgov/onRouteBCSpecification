Feature: Staff apply for single trip oversize (STOS) permit 

Staff = SA, PC, CTPO, Trainee

@orv2-2387-40
Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

@orv2-2387-41 @orv2-2561-47
Rule: Staff may add an STOS permit to the cart

@orv2-2387-2 @orv2-4274-1
Rule: Staff must choose a permit length in increments of one day, with a maximum of 30 days from their chosen start date

