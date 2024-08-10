Feature: CV Client apply for single trip oversize (STOS) permit 

CV Client = CA, PA

@orv2-2387-40
Rule: Staff may choose any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

@orv2-2387-41
Rule: Staff may add an STOS permit to the cart


