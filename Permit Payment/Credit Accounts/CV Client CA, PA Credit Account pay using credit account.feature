Feature: CV Client CA, PA Credit Account pay using credit account

CV Client = CA, PA

@orv2-1996-1 @orv2
Rule: The credit account payment method is available when a cv client user or holder has a credit account

  Scenario: user or holder
    Given the cv client is a user or holder of a credit account
     When cv client choose to pay
     Then they see option to pay using credit account

  Scenario: not a user or holder
    Given the cv client is not a user or holder of a credit account
     When cv client choose to pay
     Then they do not see the option to pay using credit account

@orv2-1996-2
Rule: The credit account payment method is not available when the credit account is on hold

  Scenario: user
    Given the cv client credit account is on hold
     When cv client user choose to pay
     Then they do not see the option to pay using credit account

  Scenario: holder
    Given the cv client credit account is on hold
     When cv client holder choose to pay
     Then they do not see the option to pay using credit account

@orv2-1996-3
Rule: The credit account payment method is not available when the credit account holder is suspended

  Scenario: user
    Given the cv client holder is suspended
     When cv client user choose
     Then they do not see the option to pay using credit account

  Scenario: holder
    Given the cv client holder is suspended
     When cv client holder choose to pay
     Then they do not see the option to pay using credit account

@orv2-1996-4
Rule: The credit account payment method is not available when the credit account is closed

  Scenario: user
    Given the cv client credit account is closed
     When cv client user choose to pay=
     Then they do not see the option to pay using credit account

  Scenario: holder
    Given the cv client credit account is closed
     When cv client holder choose to pay
     Then they do not see the option to pay using credit account

@orv2-1996-5
Rule: There must be sufficient credit available to purchase the total transaction amount

  Scenario: insufficient credit
    Given available credit is $500
     When cv client attempt to pay a $501 transaction
     Then they see "Transaction failed. Credit account unavailable."
      And they cannot complete the transaction 

  Scenario: sufficient credit
    Given available credit is $500
     When cv client attempt to pay a $500 transaction
     Then they complete the transaction 
      And the permit is issued

 # not sure this is valid
  Scenario: available credit unknown
    Given credit limit cannot be found
     When cv client attempt to pay a transaction
     Then they see "Transaction failed. Credit account unavailable."
      And they cannot complete the transaction 

