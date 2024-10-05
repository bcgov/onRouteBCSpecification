Feature: Refund to Multiple Payment Methods

Staff = SA

NOTE: Only Single Trip OS/OW and Motive Fuel User Permits can be amended such that it increases the permit value and therefore are the only type of permits that would be amended to reduce a portion of the permit value and potentially require splitting the refund amounts across multiple payment methods. We would still be able to void other types of permits BUT if a user wishes to extend a term permit they would be asked to get a new one.

#We have no leave or cancel

@orv2-2816
Rule: Show total refund due

  Scenario: no fee permit reduce 
    Given permit A has a permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a permit value of $100
     When staff reduce permit A value by $50
     Then they see $50

  Scenario: fee permit plate change
    Given permit A has a permit value of $100
     When staff complete a plate change
     Then they see $0

  Scenario: void
    Given permit A has a permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show permit current value

  Scenario: no fee permit reduce 
    Given permit A has a permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a permit value of $100
     When staff reduce permit A value by $50
     Then they see $100

  Scenario: fee permit plate change
    Given permit A has a permit value of $100
     When staff complete a plate change
     Then they see $100

  Scenario: void
    Given permit A has a permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show new permit value

  Scenario: no fee permit reduce 
    Given permit A has a permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a permit value of $100
     When staff reduce permit A value by $50
     Then they see $50
     
  Scenario: fee permit plate change
    Given permit A has a permit value of $100
     When staff complete a plate change
     Then they see $100
     #this gets recorded as a $0 transaction

  Scenario: void
    Given permit A has a permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show historical financial transaction information for permit

 Scenario: Previous financial transactions exist
      When staff choose to finish
      Then they see the following details of all previous transactions for the permit:
        | information      | description                                                  |
        | Permit #         | permit number generated for the listed transaction           |
        | Payment Method   | payment method used for the listed transaction               |
        | Provider Tran ID | provider transaction id for the listed transaction           |
        | Amount (CAD)     | permit fee (positive or negative) for the listed transaction |

@orv2-2816
Rule: Staff can choose one or more positive historical transactions to refund 

  Scenario: arrive
     When staff arrive at finish
     Then historical transactions are shown
      And the following is true for historical transactions:
        | information         | description      |
        | Refund Amount (CAD) | is not available |
        | Refund Tran ID      | is not available |
        | Cheque Refund       | is not available |

  Scenario: choose none finish
     When staff choose to finish
     Then they see "Refund Error Total refund amount does not match total refund due."
  
  Scenario: choose one or more
     When staff choose historcial transaction A
     Then historical transaction A is indicated
      And the following is true for historical transaction A:
        | information         | description      |
        | Refund Amount (CAD) | is available     |
        | Refund Tran ID      | is not available |
        | Cheque Refund       | is available     |
        
@orv2-2816
Rule: Refund amount(s) inputted by Staff must equal the total refund due

  Scenario: equal on 1 chosen historical transaction
    Given total refund due is $100
     When staff input the following:
       | Line | refund amount | refund tran id | cheque |
       | 2    | $100          | 12345678       | No     |
      And choose to finish
      And they are directed to Active Permits
      And they see "Permit Amended" notification

  Scenario: not equal 1 or more chosen historical transactions
    Given total refund due is $100
      And line 1 and line 2 are chosen
     When staff input the following:
       | Line | refund amount | refund tran id | cheque |
       | 1    | $0            |                | No     |
       | 2    | $110          | 12345678       | No     |
     Then they see "Refund Error Total refund amount does not match total refund due."

  Scenario: equal on 1 2 chosen historcial transactions only 1 complete
    Given total refund due is $100
      And line 1 and line 2 are chosen
     When staff input the following:
       | Line | refund amount | refund tran id | cheque |
       | 1    | $0            |                | No     |
       | 2    | $100          | 12345678       | No     |
      And choose to finish
     Then line 1 is ignored
      And they are directed to Active Permits
      And they see "Permit Amended" notification

@orv2-2816
Rule: Refund amount must have a value >$0 for refund tran id and cheque refund to be available

  Scenario: refund is $50
     When staff choose to input a transaction id
     Then transaction id is availble

  Scenario: refund is =<$0
     When staff choose to input a transaction id
     Then transaction id is unavailble

@orv2-2816
Rule: Staff must input a refund transaction id for a chosen transaction and inputted Refund Amount (CAD)

  Scenario: refund is $50 no tran id
    Given the Total Refund Due is $50
      And the chosen transaction A has a refund amount of $50
      And there is no Refund Tran ID
     When staff choose to finish
     Then they see "This is a required field"
      And Refund Tran ID is indicated

@orv2-2816
Rule: Refund Tran ID is unavailable when cheque is the refund payment method

@orv2-2816
Rule: Calculated fee values are rounded to the nearest dollar

@orv2-2816
Rule: Only whole numbers can be inputted in refund amount


@orv2-2816
Rule: Refund transactions are saved for each completed transaction 

 ISSUED ON PROVIDER TRAN ID ORBC TRAN ID PAYMENT METHOD RECEIPT A PERMIT PERMIT TYPE USER AMOUNT
 Jul. 18. 2023. 08:00 PM. PDT OR-678904512857 No Payment 98465778747 P1-96153480-957 TROS SELF ISSUED $0
 Jul. 18, 2023, 08:32 PM, PDT OR-678904512857 No Payment 98465778747 P1-96153480-957 TROS ANPETRIC $0

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
