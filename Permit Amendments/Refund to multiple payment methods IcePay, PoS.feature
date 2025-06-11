Feature: Refund to multiple payment IcePay and PoS

Staff = SA

Note: See common refund to multiple payment methods features that apply to this feature.

@orv2-4555-3
Rule: cheque refund cannot be unchosen for cheque, cash or GA historical transactions

  Scenario: GA payment
    Given permit A has GA historical transaction 1
     When staff are directed to finish amendment or void
     Then cheque cannot be unchosen for GA historical transaction 1

@orv2-4555-4
Rule GA payment historical transactions will always show a provider tran id that was inputted manually by staff at the time of purchase
