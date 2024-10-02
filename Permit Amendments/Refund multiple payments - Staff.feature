Feature: Refund to Multiple Payment Methods

Staff = SA

Rule: Total refund due is shown

Rule: Permit current value is shown

Rule: New permit vlaus is calculated

Rule: Users can choose one or more historical transactions to refund to

Rule: Refund amounts inpuuted by users must equal the total refund due

Rule: Users must input a refund amount for a chosen transaction

Rule: Users must input a refund transaction id for a chosen transaction 

Rule: Refund transaction id is unavailable when cheque is the refund payment method

Rule: Users may choose cheque as a refund method

Rule: Fee values are rounded to the nearest dollar

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
