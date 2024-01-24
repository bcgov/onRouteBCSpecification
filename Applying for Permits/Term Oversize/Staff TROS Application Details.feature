Feature: Staff complete TROS permit details
    As a PPC SA or PC I need to enter the parameters of a CV Clients TROS permit so that I can issue the permit on behalf of a CV Client.

@orv2-1384-5
Rule: Staff can input any start date

  Scenario: Permit start date accepted
    Given Staff is at permit details
     When they enter a start date
     Then their start date is accepted

 