Feature: SA, PC, CTPO Pay with Credit Account

Staff = SA, PC, CTPO

@orv2-1802-1
Rule: The credit account payment method is available when a cv client user or holder has a credit account

  Scenario: user or holder
    Given the cv client is a user or holder of a credit account
     When staff choose to pay
     Then they see option to pay using credit account

  Scenario: not a user or holder
    Given the cv client is not a user or holder of a credit account
     When staff choose to pay
     Then they do not see the option to pay using credit account

@orv2-1802-2
Rule: The credit account payment method is not available when the credit account is on hold

  Scenario: user
    Given the cv client credit account is on hold
     When staff choose to pay for a user transaction
     Then they do not see the option to pay using credit account

  Scenario: holder
    Given the cv client credit account is on hold
     When staff choose to pay for a holder transaction
     Then they do not see the option to pay using credit account

@orv2-1802-3
Rule: The credit account payment method is not available when the credit account holder is suspended

  Scenario: user
    Given the cv client holder is suspended
     When staff choose to pay for a user transaction
     Then they do not see the option to pay using credit account

 # not sure if this is valid
  Scenario: holder
    Given the cv client is a holder is suspended
     When staff choose to pay for a holder transaction
     Then they do not see the option to pay using credit account

@orv2-1802-4
Rule: The credit account payment method is not available when the credit account is closed

  Scenario: user
    Given the cv client credit account is closed
     When staff choose to pay for a user transaction
     Then they do not see the option to pay using credit account

  Scenario: holder
    Given the cv client credit account is closed
     When staff choose to pay for a holder transaction
     Then they do not see the option to pay using credit account

@orv2-1802-5
Rule: There must be sufficient credit available to purchase the total transaction amount

  Scenario: insufficient credit
    Given available credit is $500
     When staff attempt to pay a $501 transaction
     Then they see "Transaction failed. Credit account unavailable."
      And they cannot complete the transaction 

  Scenario: sufficient credit
    Given available credit is $500
     When staff attempt to pay a $500 transaction
     Then they complete the transaction 
      And the permit is issued

 # not sure this is valid
  Scenario: available credit unknown
    Given credit limit cannot be found
     When staff attempt to pay a transaction
     Then they see "Transaction failed. Credit account unavailable."
      And they cannot complete the transaction 