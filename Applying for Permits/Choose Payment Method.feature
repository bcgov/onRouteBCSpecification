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
       | Permit Type and Permit Sub-Type Name |
       | Application Number                   |
       | Item Description                     |
       | Item Fee                             |
       | Total of All Items Fees              |
       | "Have Questions" Information Content |

@orv2-553-4
Scenario: Fee calculation summary
    Given A CV Client is at the "Pay for Permit" page
    When they choose to review the "Fee Summary"
    Then they see <item1> total and a <total>
    And <total> is the sum of all items

    Example:
      | item1 | total |
      | 30    | 30    |  