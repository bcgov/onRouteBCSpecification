Feature: staff apply for single trip oversize (STOS) permit 

staff = SA, PC, CTPO, Trainee

@orv2-2387-40
Rule: staff may choose any start date

  Scenario: Permit start date accepted
    Given staff is at permit details
     When they enter a start date in the past
     Then their start date is accepted
      And the see "Start Date is in the past."

@orv2-2387-41 @orv2-2561-47
Rule: staff may add an STOS permit to the cart

@orv2-2387-2 @orv2-4274-1
Rule: staff must choose a permit length in increments of one day, with a maximum of 30 days

  Scenario: Permit length accepted
     When they choose 1 from the list of days availavle:
       | 1 Day |
       | 2 Days |
       | 3 Days |
       | 4 Days |
       | 5 Days |
       | 6 Days |     
       | 7 Days |
       | 8 Days |
       | 9 Days |
       | 10 Days |
       | 11 Days |
       | 12 Days |
       | 13 Days |
       | 14 Days |
       | 15 Days |
       | 16 Days |
       | 17 Days |
       | 18 Days |
       | 19 Days |
       | 20 Days |
       | 21 Days |
       | 22 Days |
       | 23 Days |
       | 24 Days |
       | 25 Days |
       | 26 Days |
       | 27 Days |
       | 28 Days |
       | 29 Days |
       | 30 Days |
     Then their permit length is accepted

