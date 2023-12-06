Feature: View generated void refund receipt

@orv2-1064-3
Rule: The void receipt contains void refund details

  Scenario: refund receipt is generated
    Given a refund transaction was successfully completed
     When the refund receipt is generated
     Then it contains all required variable data fields from the voided permit application:
      | 