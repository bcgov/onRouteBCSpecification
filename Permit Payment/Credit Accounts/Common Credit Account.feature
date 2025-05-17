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
    Given cv client a is the holder
     And cv client b is the user
     When cv client b purchases using the credit account
     Then the permit issuance email with attached permit and permit purchase receipt email with attached receipt pdf are sent to cv client a company email address

  Scenario: staff purchases for user
    Given cv client a is the holder
     And cv client b is the user
     When staff purchase on behalf of cv client b using the credit account
     Then the permit issuance email with attached permit and permit purchase receipt email with attached receipt pdf are sent to cv client a company email address

  Scenario: staff purchases for holder
    Given cv client a is the holder
     When staff purchase on behalf of cv client a using the credit account
     Then the permit issuance email with attached permit and permit purchase receipt email with attached receipt pdf are sent to cv client a company email address
      But they are not sent duplicate permit issuance email with attached permit and permit purchase receipt email with attached receipt pdf

@orv2-1801-2
Rule: User permit payment receipt Payer Name is the credit account holder Company Legal Name

@orv2-1801-3
Rule: Permit payment receipt payment method is Credit Account

