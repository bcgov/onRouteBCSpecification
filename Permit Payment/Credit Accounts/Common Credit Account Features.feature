Feature: Common credit account features

cv client = CA, PA
staff = SA, CTPO, PC, Trainee

Rule: Choosing credit account is indicated

  Scenario: 
    Given 
     When 
     Then 

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