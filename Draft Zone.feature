NOTE: This file is not a specification!

User Groups: https://moti-imb.atlassian.net/wiki/spaces/ORV2/pages/102498349/Roles+Services+and+Permissions+Matrix

Data Discovery: 

User = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA
CV Client = CA, PA
Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA
Auth Staff = PC, SA, TRAIN, CTPO
Non Auth Staff = FIN, EO, HQA


Feature: Refund to multiple payment methods credit account

Rule: credit account void and amend with refund permit pdf and receipt are always sent to the credit account holder

  Scenario: credit account holder
    Given 
     When 
     Then they only get one email

  Scenario: credit account user
    Given 
     When 
     Then 



Rule: Maximum 15 characters allowed in Transaction ID

Enter 16 characters
they see "Maximum 15 characters"

In staff shopping cart:

   Scenario: date extension
     Given permit A 
      When 
      Then 
 
   Scenario: km added
     Given 
      When 
      Then 
 
   Scenario: weight increased
     Given 
      When 
      Then 
 
  Scenario: dangerous goods
    Given 
     When 
     Then 


Feature: Basic BCeID CV Client Create a New onRouteBC Profile

Feature: Basic BCeID CV Client Claim a onRouteBC Profile

Feature: Basic BCeID CV Client Invited User Log Into onRouteBC

User = CA, PA

# Rule: credential X must match invited username in onRouteBC

Rule: a user can choose to create a new onRouteBC Profile

Rule: a user can choose to claim an onRouteBC profile

Rule: a user must update mandatory contact details

Rule: 

  Scenario: 
    Given 
     When 
     Then 

