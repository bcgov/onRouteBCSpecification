Feature: 
As PPC Staff I need to be able to accept Cash, Cheque, Debit card via PoS, GA received payments so that our customers have payment flexibility for purchasing permits.

Staff = SA, PC, CTPO, Trainee

@orv2-2141-1
Rule: Staff can pay for a permit using in-person payment types

  Scenario: at ppc
    Given a cv client chooses to pay with cash
     When staff choose to pay using in-person at ppc
     Then in-person at a ppc is indicated
      And they can input a payment type and transaction id

  Scenario: at service BC office
    Given a cv client chooses to pay at a service BC office
     When staff choose to pay using in-person at a service BC office
     Then in-person at a service BC office is indicated
      And they can input a service BC office number

@orv2-2141-4
Rule: Staff must input a service BC office id number 

  Scenario: service BC office id not inputted
     When they attempt to finish
     Then they see "This is a required field"
      And "Service BC Office ID Number " is indicated
      And they cannot finish

@orv2-2141-2
Rule: Staff must choose from a list of in-person payment types

  Scenario: available in-person payment types
     When they choose to input a payment type from te following list:
      | Amex               |
      | Cash               |
      | Checque            |
      | Debit              |
      | Mastercard         |
      | Mastercard (Debit) |
      | Visa               |
      | Visa (Debit)       |
     Then their choosen option is shown

  Scenario: in-person payment type is mandatory
    Given Staff have not inputted a payment type
     When they attempt to finish
     Then they see "This is a required field"
      And "Payment Type" is indicated
      And they cannot finish

@orv2-2141-3
Rule: Staff must input a transaction ID (Provider Transaction ID) manually for all transactions except cash or cheque

  Scenario: not inputted a transaction ID
     When they attempt to finish
     Then they see "This is a required field"
      And "Transaction ID" is indicated
      And they cannot finish

  Scenario: cash or cheque
     When staff have chosen cash or cheque
     Then transactiona id is not available

