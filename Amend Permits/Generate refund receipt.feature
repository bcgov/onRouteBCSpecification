Feature: Generate refund receipt

@orv2-1064-3
Rule: The void receipt contains void refund details

  Scenario: refund receipt is generated
    Given a refund transaction was successfully completed
     When the refund receipt is generated
     Then it contains all required variable data fields from the voided permit application:
      | 

@orv2-938-23
Rule: Generate amended permit pdf receipt

  Scenario: Refund is calculated
    Given the PPC SA has inputted all mandatory information at finish amendment
     When they choose to finish amending the permit
     Then the amended permit pdf receipt is generated 
      And the total amount is represented as a negative number with a "-" preceding the "$"

  Scenario: Refund by cheque
    Given the PPC SA has chosen to refund by cheque
     When the amended permit receipt pdf is generated
     Then the transaction id is the onRouteBC transaction number

  Scenario: Refund to previous payment method
    Given the PPC SA has chosen to refund to the previous payment method
      And they input a transaction id
     When the amended permit receipt pdf is generated
     Then the transaction id is the transaction id inputted at finish amendment