Feature: CV Client pay for permit with credit card

@orv2-1119
Rule: A CV Client can pay for a permit with VISA, Master Card or American Express

  Scenario: CV Client attempts to pay with valid credit card
    Given the CV Client is at the 
     When they 
     Then 

  Scenario: CV Client attempts to pay with non-supported credit card
    Given 
     When 
     Then 

  Scenario: CV Client attempts to pay with over limit credit card
    Given 
     When 
     Then

Rule: A CV Client can 