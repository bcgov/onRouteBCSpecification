Feature: Refund to Multiple Payment Methods

Staff = SA

@orv2-2816
Rule: Total refund due is shown

@orv2-2816
Rule: Permit current value is shown

@orv2-2816
Rule: New permit value is shown

@orv2-2816
Rule: Staff can choose one or more historical transactions to refund 

@orv2-2816
Rule: Refund amounts inpputed by Staff must equal the total refund due

@orv2-2816
Rule: Staff must input a refund amount for a chosen transaction

@orv2-2816
Rule: Staff must input a refund transaction id for a chosen transaction 

@orv2-2816
Rule: Refund transaction id is unavailable when cheque is the refund payment method

@orv2-2816
Rule: Staff may choose cheque as a refund method

@orv2-2816
Rule: Fee values are rounded to the nearest dollar

@orv2-2816
Rule: Only whole numbers can be inputted in refund amount










#  Scenario: valid payment methods
    Given tros has the following amendment transactions
      | amendment  transaction | charge amount | description              |
      | 6 month                | 180           | original term            |
      | 6 months added         | 180           | amended to 12 month term |
     When staff choose to shorten the tros by 9 months
     Then the refund amounts per amendment transaction are
       | amendment transaction | refund amount |
       | 6 month               | 90            | 
       | 6 months added        | 180           | 

#Rule: An invalid payment method must be refunded by cheque

  Scenario: 1 or more invalid payment methods
    Given tros has the following amendment transactions
      | amendment  transaction | payment method | description              |
      | 6 month                | Web - VISA     | original term            |
      | 6 months added         | Web - MC       | amended to 12 month term |
      And the original term transaction payment method is invalid
     When staff choose to shorten the tros by 9 months
     Then the refund payment methods per amendment transaction are
       | amendment transaction | refund payment method |
       | 6 month               | cheque                |
       | 6 months added        | Web - MC              |

#Rule: A transaction ID must be recorded for each refund transaction

Same payment method multiple positive transaction

If the refund amount were higher than the original transaction amount then it would have to be 
