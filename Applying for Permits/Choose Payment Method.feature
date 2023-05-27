Feature: Choose permit payment method
   As a CV Client I want to be able to choose my preferred payment method, so that I can use the one most appropriate to my current needs.

@orv2-553
Scenario: Proceed to pay
    Given a CV Client is at the "Review abd Confirm Details" page
    When they choose to pay for the permit
    Then they are directed to the "Pay for Permit" page

@orv2-553  
  Scenario: Choose payment method
    Given A CV Client is at the "Pay for Permit" page
     When they want to choose a payment method
     Then they see the following options:
        | Use PayBC |
      And it is choosen by default

@orv2-553
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

@orv2-553
Scenario: Fee calculation summary
    Given A CV Client is at the "Pay for Permit" page
    When they choose to review the "Fee Summary"
    Then they see <item1> total and a <total>
    And <total> is the sum of all items

    Example:
      | item1 | total |
      | 30    | 30    |

@orv2-553  
  Scenario: Pay
    Given A CV Client is at the "Pay for Permit" page
     When they want to pay
     Then they...
  