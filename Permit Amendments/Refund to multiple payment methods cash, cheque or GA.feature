Feature: Refund to multiple payment methods cash, cheque or GA

Staff = SA

Note: See common refund to multiple payment methods features that apply to this feature. Where users are directed to refund to multiple payment methods from the void workflow refer to void permit feature for related rules and behaviour.

@orv2-4535-1
Rule: cheque, cash and GA historical transactions have cheque chosen by default when staff are directed to finish amendment or void

  Scenario: cash 
    Given permit A has cash historical transaction 1
     When staff are directed to finish amendment or void
     Then cheque is chosen by default for cash historical transaction 1

@orv2-4535-2
Rule: refund tran id is not an available input for cheque, cash or GA historical transactions

  Scenario: cheque
    Given permit A has cheque historical transaction 1
     When staff are directed to finish amendment or void
     Then refund tran id is not an available input for cheque historical transaction 1

@orv2-4535-3
Rule: cheque refund cannot be unchosen for cheque, cash or GA historical transactions

  Scenario: GA payment
    Given permit A has GA historical transaction 1
     When staff are directed to finish amendment or void
     Then cheque cannot be unchosen for GA historical transaction 1

@orv2-4535-4
Rule GA payment historical transactions will always show a provider tran id that was inputted manually by staff at the time of purchase