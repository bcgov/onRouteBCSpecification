Feature: Refund to Multiple Payment Methods

Staff = SA

NOTE: Only Single Trip OS, OS/OW and Motive Fuel User Permits can be amended such that it increases the permit value and therefore are the only type of permits that would be amended to reduce a portion of the permit value and potentially require splitting the refund amounts across multiple payment methods. We would still be able to void other types of permits BUT if a user wishes to extend a term permit they would be asked to get a new one.

@orv2-2816
Rule: Total refund due is shown

  Scenario: no fee permit reduce 
    Given permit A  has a value of $100
     When staff reduce 
     Then 

  Scenario: fee permit
    Given 
     When 
     Then 

  Scenario: fee permit plate change
    Given 
     When 
     Then 

  Scenario: void
    Given 
     When 
     Then 

@orv2-2816
Rule: Permit current value is shown

  Scenario: no fee permit reduce 
    Given permit A  has a value of $100
     When staff reduce 
     Then 

  Scenario: fee permit
    Given 
     When 
     Then 

  Scenario: fee permit plate change
    Given 
     When 
     Then 

  Scenario: void
    Given 
     When 
     Then 

@orv2-2816
Rule: New permit value is shown

  Scenario: no fee permit reduce 
    Given permit A  has a value of $100
     When staff reduce 
     Then 

  Scenario: fee permit
    Given 
     When 
     Then 

  Scenario: fee permit plate change
    Given 
     When 
     Then 

  Scenario: void
    Given 
     When 
     Then 

@orv2-2816
Rule: Staff can choose one or more historical transactions to refund 

  Scenario: choose none
    Given 
     When 
     Then 
  
  Scenario: choose 1
    Given 
     When 
     Then 

   Scenario: choose 2
     Given 
      When 
      Then 

@orv2-2816
Rule: Refund amount(s) inputted by Staff must equal the total refund due

  Scenario: equal
    Given 
     When 
     Then directed to Active Permits 
      And they see "Permit Amended" notification

  Scenario: not equal
    Given 
     When 
     Then they see "Refund Error Total refund amount does not match total refund due."

  Scenario: equal on 1 but 2 chosen lines
    Given 
     When 
     Then line 2 is ignored



@orv2-2816
#Rule: Staff must input a refund amount for a chosen transaction

Rule: Refund amount must have a value < 0 for refund tran id and cheque refund to be available

Rule: If total refund due matches refund amounts and other rows are checked pass

@orv2-2816
#Rule: Staff must input a refund transaction id for a chosen transaction 

@orv2-2816
Rule: Refund transaction id is unavailable when cheque is the refund payment method

@orv2-2816
Rule: Staff may choose cheque as a refund method

@orv2-2816
Rule: Fee values are rounded to the nearest dollar

@orv2-2816
Rule: Only whole numbers can be inputted in refund amount

@orv2-2816
Rule: 


@orv2-2816
Rule: 
@orv2-2816
Rule: 
@orv2-2816
Rule: 
@orv2-2816
Rule: 
@orv2-2816
Rule: 







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
