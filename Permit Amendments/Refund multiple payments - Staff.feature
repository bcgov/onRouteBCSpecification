Feature: Refund to Multiple Payment Methods

Staff = SA

NOTE: Only Single Trip OS/OW and Motive Fuel User Permits can be amended such that it increases the permit value and therefore are the only type of permits that would be amended to reduce a portion of the permit value and potentially require splitting the refund amounts across multiple payment methods. We would still be able to void other types of permits BUT if a user wishes to extend a term permit they would be asked to get a new one.

#We have no leave or cancel
#no fee amendments that reduce permit value OR are void are recorded as a $0 transaction refunds

@orv2-2816
Rule: Show total refund due

  Scenario: no fee permit reduce 
    Given permit A has a current permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a current permit value of $100
     When staff reduce permit A value by $50
     Then they see $50

  Scenario: fee permit plate change
    Given permit A has a current permit value of $100
     When staff complete a plate change
     Then they see $0

  Scenario: void
    Given permit A has a current permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show current permit value

  Scenario: no fee permit reduce 
    Given permit A has a current permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a current permit value of $100
     When staff reduce permit A value by $50
     Then they see $100

  Scenario: fee permit plate change
    Given permit A has a current permit value of $100
     When staff complete a plate change
     Then they see $100

  Scenario: void
    Given permit A has a current permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show new permit value

  Scenario: no fee permit reduce 
    Given permit A has a current permit value of $0
     When staff reduce permit A value
     Then they see $0

  Scenario: fee permit
    Given permit A has a current permit value of $100
     When staff reduce permit A value by $50
     Then they see $50
     
  Scenario: fee permit plate change
    Given permit A has a current permit value of $100
     When staff complete a plate change
     Then they see $100

  Scenario: void
    Given permit A has a current permit value of $100
     When staff complete a void
     Then they see $100

@orv2-2816
Rule: Show historical financial transaction information for the amending/void permit application

 Scenario: Previous financial transactions exist
      When staff choose to finish
      Then they see the following details of all previous transactions for the permit:
        | information      | description                                                  |
        | Permit #         | permit number generated for the listed transaction           |
        | Payment Method   | payment method used for the listed transaction               |
        | Provider Tran ID | provider transaction id for the listed transaction           |
        | Amount (CAD)     | permit fee (positive or negative) for the listed transaction |

@orv2-2816
Rule: Staff can choose one or more credit (positive) historical transactions to refund 

  Scenario: arrive
     When staff arrive at finish
     Then historical transactions are shown
      And the following is true for historical transaction refund inputs:
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
      And the following is true for historical transaction A refund inputs:
        | information         | description      |
        | Refund Amount (CAD) | is available     |
        | Refund Tran ID      | is not available |
        | Cheque Refund       | is not available |
        
  Scenario: historical refunds (debit) 
    Given permit A has a historical refund of -$30.00
     When staff arrive at finish
     Then they do not see the following input fields for the historical refund of -$30.00:
       | historical transaction line selection |
       | Refund Amount (CAD)                   |
       | Refund Tran ID                        |
       | Cheque Refund                         |

  Scenario: historical no-fee (credit) 
    Given permit A has a historical no-fee of $0.00
     When staff arrive at finish
     Then they do not see the following input fields for the historical no-fee of $0.00:
       | historical transaction line selection |
       | Refund Amount (CAD)                   |
       | Refund Tran ID                        |
       | Cheque Refund                         |

@orv2-2816
Rule: Refund amount(s) inputted by Staff must equal the total refund due

  Scenario: equal on 1 chosen historical transaction
    Given total refund due is $100
     When staff input the following:
       | Line | refund amount | Refund Tran ID | cheque |
       | 2    | $100          | 12345678       | No     |
      And choose to finish
      And they are directed to Active Permits
      And they see "Permit Amended" notification

  Scenario: not equal 1 or more chosen historical transactions
    Given total refund due is $100
      And line 1 and line 2 are chosen
     When staff input the following:
       | Line | refund amount | Refund Tran ID | cheque |
       | 1    | $0            |                | No     |
       | 2    | $110          | 12345678       | No     |
     Then they see "Refund Error Total refund amount does not match total refund due."

  Scenario: equal on 1 2 chosen historcial transactions only 1 complete
    Given total refund due is $100
      And line 1 and line 2 are chosen
     When staff input the following:
       | Line | refund amount | Refund Tran ID | cheque |
       | 1    | $0            |                | No     |
       | 2    | $100          | 12345678       | No     |
      And choose to finish
     Then line 1 is ignored
      And they are directed to Active Permits
      And they see "Permit Amended" notification

@orv2-2816
Rule: Refund amount must have a value >$0 for Refund Tran ID and cheque refund to be available

  Scenario: refund is $50
     When staff choose to input a Refund Tran ID
     Then Refund Tran ID and cheque refund is availble

  Scenario: refund is =<$0
     When staff choose to input a refund tran id
     Then refund tran id is unavailble

  Scenario: refund tran id has a value
    Given refund amount has a value of $10
      And refund tran id as a value of 12345678
     When refund amount is reduced to $0
     Then refund tran id is cleared 
      And refund tran id is unavailable

@orv2-2816
Rule: Staff must input a refund tran id for a chosen transaction and inputted refund amount

  Scenario: refund is $50 no tran id
    Given the total refund due is $50
      And the chosen transaction A has a refund amount of $50
      And there is no refund tran id
     When staff choose to finish
     Then they see "This is a required field"
      And refund tran id is indicated

@orv2-2816
Rule: Refund tran id is unavailable when cheque is the refund payment method

@orv2-2816
Rule: Refund tran id is cleared when cheque refund is chosen

@orv2-2816
Rule: Cheque refund is disabled when refund tran id has a value

@orv2-2816
Rule: Calculated fee values are rounded to the nearest dollar

@orv2-2816
Rule: Only whole numbers can be inputted in refund amount





Draft:

@orv2-2816
Rule: Refund transactions are saved for each completed transaction 

No-fee refunds are refunds

No charge amends are payments

 ISSUED ON PROVIDER TRAN ID ORBC TRAN ID PAYMENT METHOD RECEIPT A PERMIT PERMIT TYPE USER AMOUNT
 Jul. 18. 2023. 08:00 PM. PDT OR-678904512857 No Payment 98465778747 P1-96153480-957 TROS SELF ISSUED $0
 Jul. 18, 2023, 08:32 PM, PDT OR-678904512857 No Payment 98465778747 P1-96153480-957 TROS ANPETRIC $0