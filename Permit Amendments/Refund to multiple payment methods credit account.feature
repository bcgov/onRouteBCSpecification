Feature: Refund to multiple payment methods cash, cheque or GA

Staff = SA

Note: See common refund to multiple payment methods features that apply to this feature. Where users are directed to refund to multiple payment methods from the void workflow refer to void permit feature for related rules and behaviour.

@orv2-2004
Rule: Refund tran id is unavailable for credit account historical transactions

Rule: credit account void and amend with refund generated permit pdf and receipt are always sent to the credit account holder

  Scenario: credit account holder
    Given 
     When 
     Then they only get one email

  Scenario: credit account user
    Given 
     When 
     Then 