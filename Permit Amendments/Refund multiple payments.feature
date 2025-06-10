Feature: Refund to Multiple Payment Methods

Staff = SA

NOTE: Only some permits (e.g., MFP, STOW, NR License) can be amended such that it increases the permit value and therefore are the only type of permits that could incur multiple payment methods (e.g., transaction 1 uses VISA, transaction 2 uses MC) and potentially require splitting the refund amounts across multiple payment methods. Users are directed to refund to multiple payment methods in the following scenarios:
 - $0 amends
 - void
 - amend with refund

@orv2-2816-1 @orv2-2004
Rule: Show total refund due (TRD)

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

@orv2-2816-2 @orv2-2004
Rule: Show current permit value (CPV)

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

@orv2-2816-3 @orv2-2004
Rule: Show new permit value (NPV)

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

@orv2-2816-4 @orv2-2004
Rule: Show historical financial transaction information for the amending/void permit application

 Scenario: Previous financial transactions exist
      When staff choose to finish
      Then they see the following details of all previous transactions for the permit:
        | information      | description                                                  |
        | Permit #         | permit number generated for the listed transaction           |
        | Payment Method   | payment method used for the listed transaction               |
        | Provider Tran ID | provider transaction id for the listed transaction if exists |
        | Amount (CAD)     | permit fee (positive or negative) for the listed transaction |

@orv2-2816-5 @orv2-2004
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

  Scenario: choose one or more finish
     When staff choose to finish
     Then they see "Refund Error Total refund amount does not match total refund due."
  
  Scenario: choose one or more
     When staff choose historical transaction A
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

@orv2-2816-15 @orv2-2004
Rule: Deselecting a historical transaction(s) to refund clears any user input

  Scenario: input in amount and refund tran ID
    Given historical transaction A is chosen
      And 90 is in Refund Amount
      And 12345 is in Refund Tran ID 
     When a user chooses not to use the histrorical transaction A
     Then 12345 is deleted from Refund Tran ID 
      And 90 is deleted from Refund Amount

  Scenario: cheque chosen
    Given historical transaction A is chosen
      And 90 is in Refund Amount
      And Cheque Refund is chosen
     When a user chooses not to use the histrorical transaction A
     Then 90 is deleted from Refund Amount
      And Cheque Refund is deselected

  Scenario: refund tran ID
    Given historical transaction A is chosen
      And 12345 is in Refund Tran ID
     When a user chooses not to use the historical transaction A
     Then 12345 is deleted from Refund Tran ID

@orv2-2816-6 @orv2-2004
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

@orv2-2816-7 
Rule: Refund amount must have a value >$0 for Refund Tran ID (if required) and cheque refund to be available

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

@orv2-2816-8
Rule: Staff must input a refund tran id (if required) for a chosen transaction and inputted refund amount

  Scenario: refund is $50 no tran id
    Given the total refund due is $50
      And the chosen transaction A has a refund amount of $50
      And there is no refund tran id
     When staff choose to finish
     Then they see "This is a required field"
      And refund tran id is indicated

@orv2-2816-9 
Rule: Refund tran id is unavailable when cheque is the refund payment method

@orv2-2004
Rule: Refund tran id is unavailable for credit account historical transactions

@orv2-2816-10
Rule: Refund tran id is cleared when cheque refund is chosen

@orv2-2816-11
Rule: Cheque refund is disabled when refund tran id has a value

@orv2-2816-12
Rule: Calculated fee values are rounded to the nearest dollar

@orv2-2816-13
Rule: Only whole numbers can be inputted in refund amount

@orv2-2816-14
Rule: A refund transaction(s) is saved for each completed historical transaction 

  Scenario: no-fee amend no charge
    Given permit A has a no charge amendment
     When staff finish
     Then the transaction is reportable as:
       | information      | output                                           |
       | ISSUED ON        | date and time the permit is issued               |
       | PROVIDER TRAN ID | N/A                                              |
       | ORBC TRAN ID     | generated by onRouteBC when the permit is issued |
       | PAYMENT METHOD   | No Payment                                       |
       | RECEIPT #        | generated by onRouteBC when the permit is issued |
       | PERMIT #         | generated by onRouteBC when the permit is issued |
       | PERMIT TYPE      | the acronym for the amended permit type          |
       | USER             | PPC                                              |
       | AMOUNT           | $0                                               |

  Scenario: no-fee amend refund
    Given permit A has a refund amendment
     When staff finish
     Then the transaction is reportable as:
       | information      | output                                           |
       | ISSUED ON        | date and time the permit is issued               |
       | PROVIDER TRAN ID | N/A                                              |
       | ORBC TRAN ID     | generated by onRouteBC when the permit is issued |
       | PAYMENT METHOD   | No Payment                                       |
       | RECEIPT #        | generated by onRouteBC when the permit is issued |
       | PERMIT #         | generated by onRouteBC when the permit is issued |
       | PERMIT TYPE      | the acronym for the amended permit type          |
       | USER             | PPC                                              |
       | AMOUNT           | $0                                               |

  Scenario: no charge amend
    Given permit A has a no charge amendment
     When staff finish
     Then the transaction is reportable as:
       | information      | output                                           |
       | ISSUED ON        | date and time the permit is issued               |
       | PROVIDER TRAN ID | N/A                                              |
       | ORBC TRAN ID     | generated by onRouteBC when the permit is issued |
       | PAYMENT METHOD   | No Payment                                       |
       | RECEIPT #        | generated by onRouteBC when the permit is issued |
       | PERMIT #         | generated by onRouteBC when the permit is issued |
       | PERMIT TYPE      | the acronym for the amended permit type          |
       | USER             | PPC                                              |
       | AMOUNT           | $0                                               |

  Scenario: refund amend
    Given permit A has a refund amendment
     When staff finish
     Then the transaction is reportable as:
       | information      | output                                                    |
       | ISSUED ON        | date and time the permit is issued                        |
       | PROVIDER TRAN ID | inputted by staff                                         |
       | ORBC TRAN ID     | generated by onRouteBC when the permit is issued          |
       | PAYMENT METHOD   | the same as the chosen historical tansaction refunding to |
       | RECEIPT #        | generated by onRouteBC when the permit is issued          |
       | PERMIT #         | generated by onRouteBC when the permit is issued          |
       | PERMIT TYPE      | the acronym for the amended permit type                   |
       | USER             | PPC                                                       |
       | AMOUNT           | calculated by onRouteBC based on the amend change         |
       
  Scenario: refund void
    Given permit A is voided
     When staff finish
     Then the transaction is reportable as:
       | information      | output                                                    |
       | ISSUED ON        | date and time the permit is issued                        |
       | PROVIDER TRAN ID | inputted by staff                                         |
       | ORBC TRAN ID     | generated by onRouteBC when the permit is issued          |
       | PAYMENT METHOD   | the same as the chosen historical tansaction refunding to |
       | RECEIPT #        | generated by onRouteBC when the permit is issued          |
       | PERMIT #         | generated by onRouteBC when the permit is issued          |
       | PERMIT TYPE      | the acronym for the amended permit type                   |
       | USER             | PPC                                                       |
       | AMOUNT           | calculated by onRouteBC based on the amend change         |

   Scenario: Refund by cheque
     Given the PPC SA is at the finish amendment page
      When they choose to refund by cheque
      Then only refund by cheque is indicated as a refund method

# dupe?
@orv2-938-19 @orv2-2004
Rule: Input mandatory transaction id if required

   Scenario: Do not input transaction ID
     Given the PPC SA has chosen to refund to the previous payment method
      When they do not input a transaction ID
       And they attempt to finish
      Then they see "This is a required field"
       And they cannot finish

@orv2-2816-16
Rule: Maximum 15 characters allowed in Transaction ID

  Scenario: Enter 16 characters
    Given Transaction ID is required
     When staff enter 16 characters
      And choose to finish
     Then they see "Maximum 15 characters"

Rule: transaction history items are deselected by default when staff are directed to finish

@orv2-4535
Rule: cheque, cash and GA historical transactions have cheque chosen by default when staff are directed to finish

Rule: total refund due is shown on fee summary on PDF

Rule: credit account void and amend with refund permit pdf and receipt are always sent to the credit account holder

  Scenario: credit account holder
    Given 
     When 
     Then they only get one email

  Scenario: credit account user
    Given 
     When 
     Then 

Rule GA payment will always show a provider tran id

Rule: cancel finish refund directs staff to page they initiated the action from

free flag change scenario