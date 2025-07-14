Feature: Common credit account features

cv client = CA, PA
staff = SA, CTPO, PC, Trainee

Rule: a cv client can have only one active credit account

  Scenario: company A credit account closed
     When fin chooses to add company A to company Bs credit account as a user
     Then company A becomes a user of company Bs credit account

  Scenario: company A is a user of company Bs credit account
     When fin chooses to add company A to company Cs credit account as a user
     Then fin does not have the option to add company A to company Cs credit account
     #see 1797-1   

  Scenario: co A had credit account
    Given co A 
     When 
     Then 

 Co A CA closed
  - Co A user of Co B
  - Fin sees Co A as user of Co B on Co A CA tab

Rule: a cv client is assigned a credit account permanently

  Scenario: company A ceases activity  
    Given company A is active with credit account WS0001
     When company A ceases operations
     Then credit account WS0001 is closed

  Scenario: company A restarts activity  
    Given company A had an active credit account WS0001
     When company A restarts operations
      And fin opens credit account WS0001
     Then credit account WS0001 is open

Rule: Choosing credit account as the payment method is indicated

@orv2-1801-1
Rule: The credit account holder is sent copies of issued permit documents when purchased by a credit account user

  Scenario: cv client purchases
    Given cv client A is the holder
     And cv client B is the user
     When cv client B purchases using the credit account
     Then the permit pdf and receipt pdf are sent to the cv client B and cv client A as follows:
      | email address                            | pdfs sent to email address    |
      | cv client B - company email              | amend permit pdf, receipt pdf |
      | cv client B - additional email (if used) | amend permit pdf, receipt pdf |
      | cv client A - company email              | amend permit pdf, receipt pdf |

  Scenario: staff purchase user
    Given cv client A is the holder
     And cv client B is the user
     When staff purchase on behalf of cv client B using the credit account
     Then the permit pdf and receipt pdf are sent to the cv client B and cv client A as follows:
      | email address                            | pdfs sent to email address    |
      | cv client B - company email              | amend permit pdf, receipt pdf |
      | cv client B - additional email (if used) | amend permit pdf, receipt pdf |
      | cv client A - company email              | amend permit pdf, receipt pdf |

  Scenario: staff purchase holder
    Given cv client A is the holder
     When staff purchase on behalf of cv client A using the credit account
     Then the permit pdf and receipt pdf are sent to the cv client A as follows:
      | email address                            | pdfs sent to email address    |
      | cv client A - company email              | amend permit pdf, receipt pdf |
      | cv client A - additional email (if used) | amend permit pdf, receipt pdf |

@orv2-1801-2
Rule: User permit payment receipt Payer Name is the credit account holder Client Name

@orv2-1801-3
Rule: Permit payment receipt payment method is Credit Account


Shopping Cart Module
Credit limit - 1000
Current Balance - 970
Available Balance - 30
Let’s say we have 2 TROS permits $30 each in the shopping cart
We display the Credit Account option because it’s valid in both EGarms and TPS.
When client tries to pay for both applications, it shouldn’t succeed as it will go above the credit limit. What error message must be displayed at the time to user?
A generic payment error?