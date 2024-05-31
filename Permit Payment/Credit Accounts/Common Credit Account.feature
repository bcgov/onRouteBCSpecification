Feature: Common credit account features

cv client = CA, PA
staff = SA, CTPO, PC, Trainee

Rule: A cv client can have only one active credit account

  Scenario: company A credit account closed
     When fin chooses to add company A to company Bs credit account as a user
     Then company A becomes a user of company Bs credit account

  Scenario: company A is a user of company Bs credit account
     When fin chooses to add company A to company Cs credit account as a user
     Then fin does not have the option to add company A to company Cs credit account
     #see 1797-1   

Rule: a cv client is assigned a credit account permenantly

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

 #

Rule: The credit account holder is sent copies of issued permit documents when purchased for a credit account user

  Scenario: cv client purchases
    Given cv client a is the holder
     And cv client b is the user
     When cv client b purchases using the credit account
     Then the permit issuance email and attached permit and receipt pdf are sent to cv client a company email address

  Scenario: staff purchases
    Given cv client a is the holder
     And cv client b is the user
     When staff purchase on behalf of cv client b using the credit account
     Then the permit issuance email and attached permit and receipt pdf are sent to cv client a company email address

Rule: User permit payment receipt Payer Name is the credit account holder Company Legal Name

 #

Rule: Permit payment receipt payment method is Credit Account

 #