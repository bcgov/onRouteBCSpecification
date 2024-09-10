Feature: Refund to Multiple Payment Methods

Staff = SA

Rule: ...

  Scenario: valid payment methods
    Given tros has the following amendment transactions
      | amendment  transaction | charge amount | description              |
      | 6 month                | 180           | original term            |
      | 6 months added         | 180           | amended to 12 month term |
     When staff choose to shorten the tros by 9 months
     Then the refund amounts per amendment transaction are
       | amendment transaction | refund amount |
       | 6 month               | 90            | 
       | 6 months added        | 180           | 

Rule: An invalid payment method must be refunded by cheque

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

Rule: A transaction ID must be recorded for each refund transaction