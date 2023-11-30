Feature: Choose permit payment method
   As a CV Client I want to be able to choose my preferred payment method, so that I can use the one most appropriate to my current needs.

@orv2-553-1
Scenario: Proceed to pay
    Given a CV Client is at the "Review abd Confirm Details" page
    When they choose to pay for the permit
    Then they are directed to the "Pay for Permit" page
     And they see option to "Pay Now"

@orv2-553-3
Scenario: Permit application purchase summary
    Given a CV Client is at the is at the "Pay for Permit" page
    When they review the permit application purchase summary
    Then they see the following:
       | information                          | description                                                 |
       | Permit Type and Permit Sub-Type Name | the permit type and subtype applied for e.g. Oversize: Term |
       | Application Number                   | the unique generated application #                          |
       | Item Description                     | the description fo teh item(s) in the fee summary           |
       | item fee amount                      | the fee for a single items(s) in the fee summary            |
       | Total of All Items Fees              | the sum of all item fees in the fee summary                 |
       | "Have Questions" Information Content | help text                                                   |

@orv2-553-4
Scenario: Fee calculation summary
    Given staff is at the "Pay for Permit" page
    When they choose to review the "Fee Summary"
    Then they see individual item <amount> and a <total>
    And <total> is the sum of all items

    Example:
      | amount | total |
      | 30     | 30    |