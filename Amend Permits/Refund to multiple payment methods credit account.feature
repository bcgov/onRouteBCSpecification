Feature: Refund to multiple payment methods credit accounts
As an authorized staff member, I want to be able to refund to multiple payment methods including credit accounts, so that I can process refunds for permit applications that were purchased using multiple payment methods.

Staff = SA

Note: See common refund to multiple payment methods features that apply to this feature. Where users are directed to refund to multiple payment methods from the void workflow refer to void permit feature for related rules and behaviour.

@orv2-5679-1
Rule: Refund tran id is unavailable for credit account historical transactions 

@orv2-5679-2
Rule: completed refunds reduce credit account current balance immediately

@orv2-5679-3
Rule: show credit account status label on historical transactions if applicable

  Scenario: closed
    Given permit A has a credit account historical transaction
      And the credit account is closed
     When staff view permit A historical transactions
     Then the credit account status label is shown as "Closed" for permit A

  Scenario: on hold
    Given permit A has an on hold credit account historical transaction
      And the credit account is on hold
     When staff view permit A historical transactions
     Then the credit account status label is shown as "On Hold" for permit A

  Scenario: active
    Given permit A has an active credit account historical transaction
      And the credit account is active
     When staff view permit A historical transactions
     Then the credit account status label is not shown for permit A

  Scenario: credit account user old account closed
    Given permit A has credit account historical transaction using credit account X
      And credit account X is closed
      And the credit account user has changed to credit account Y
     When staff view permit A historical transactions
     Then the credit account status label is shown as "Closed" for permit A

  Scenario: credit account user old account on hold
    Given permit A has credit account historical transaction using credit account X
      And credit account X is on hold
      And the credit account user has changed to credit account Y
     When staff view permit A historical transactions
     Then the credit account status label is shown as "On Hold" for permit A 

@orv2-5679-4
Rule: credit account void and amend ($0 or refund) generated permit pdf and receipt are always sent to the credit account holder when the account is active or on hold, even if the cv client is no longer a user of the credit account

  Scenario: credit account holder $0 amend
    Given permit A is being amended
      And it has a $0 fee  
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account holder as follows:
      | email address                                      | pdfs sent to email address    |
      | credit account holder - company email              | amend permit pdf, receipt pdf |
      | credit account holder - additional email (if used) | amend permit pdf, receipt pdf |

  Scenario: credit account holder refund amend
    Given permit A is being amended
      And it has a refund 
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account holder as follows:
      | email address                                      | pdfs sent to email address    |
      | credit account holder - company email              | amend permit pdf, receipt pdf |
      | credit account holder - additional email (if used) | amend permit pdf, receipt pdf |

  Scenario: credit account user $0 amend
    Given permit A has a $0 fee
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account user and credit account holder as follows:
      | email address                                    | pdfs sent to email address    |
      | credit account user - company email              | amend permit pdf, receipt pdf |
      | credit account user - additional email (if used) | amend permit pdf, receipt pdf |
      | credit account holder - company email            | amend permit pdf, receipt pdf |

  Scenario: credit account user refund amend
    Given permit A has a refund
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account user and credit account holder as follows:
      | email address                                    | pdfs sent to email address    |
      | credit account user - company email              | amend permit pdf, receipt pdf |
      | credit account user - additional email (if used) | amend permit pdf, receipt pdf |
      | credit account holder - company email            | amend permit pdf, receipt pdf |     

  Scenario: no longer user account active or on hold
    Given cv client A is no longer a user of credit account 1
      And permit A was purchased using credit account 1
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account holder as follows:
      | email address                                      | pdfs sent to email address    |
      | credit account holder - company email              | amend permit pdf, receipt pdf |
      | credit account holder - additional email (if used) | amend permit pdf, receipt pdf |

@orv2-5679-5
Rule: when an eGARMS ecode is returned it is shown for each credit account transaction history record

  Scenario: eGARMS ecode returned
    Given staff are refunding permit A to multiple payment methods
      And eGARMS returns an error code for the credit account transaction
     When staff view the credit account transaction history for permit A
     Then the eGARMS error code is shown for each credit account transaction history record related to the refund to multiple payment methods for permit A

  Scenario: E0003 eGARMS ecode returned
    Given staff are refunding permit A to multiple payment methods
      And eGARMS returns E0003 (Credit account on hold) for the credit account transaction
     When staff view the credit account transaction history for permit A
     Then the eGARMS error code E0003 is shown for each credit account transaction history record related to the refund to multiple payment methods for permit A as "eGARMS return code E0003"

@orv2-5679-6
Rule: staff can optinally view a tooltip with eGARMS return code definitions when an eGARMS return code is shown for a credit account transaction history record

  Scenario: view tooltip for eGARMS return code
    Given staff are refunding permit A to multiple payment methods
      And eGARMS returns an error code for the credit account transaction
     When staff view the credit account transaction history for permit A
      And they choose to view the tooltip for the eGARMS error code shown for each credit account transaction history record related to the refund to multiple payment methods for permit A
     Then they see the eGARMS return code definitions in the tooltip
      | eGARMS return code | definition                                               |
      | E0001              | Credit account not found.                                |
      | E0002              | Credit account is inactive.                              |
      | E0003              | Credit account on hold.                                  |
      | E0004              | Credit account has exceeded the negative allowed amount. |
      | E1739              | Credit account has exceeded the negative allowed amount. |
      | E9999              | Serious error.                                           |

@orv2-5679-7
Rule: staff can complete a refund even if an eGARMS returns as ecode  

  Scenario: eGARMS returns error code
    Given staff are refunding permit A to multiple payment methods
      And eGARMS returns an error code
     When are at the final step of the refund to multiple payment methods workflow
     Then staff can complete the refund to multiple payment methods for permit A

@orv2-5679-8
Rule: staff cannot complete a refund if the credit account is closed in onRouteBC

  Scenario: only credit account closed finish
    Given staff are refunding permit A to multiple payment methods
      And the credit account used for the refund is closed in onRouteBC
      And it is the only historical transaction
     When they attempt to finish the refund to multiple payment methods workflow for permit A
     Then staff cannot complete the refund to multiple payment methods for permit A
      And they see "Refund can't be processed Refunds can't be processed for closed Credit Accounts."
      And they have the option to "Close" the message

  Scenario: only credit account open
    Given staff are refunding permit A to multiple payment methods
      And the credit account used for the refund is open in onRouteBC
      And it is the only historical transaction
      And they have not chosen a historical transaction to refund to
     When they attempt to finish the refund to multiple payment methods workflow for permit A
     Then they see "Refund Error Total refund amount does not match total refund due."
      And they have the option to "Close" the message

  Scenario: multiple transactions credit account closed
    Given there are multiple transactions
      And one of the transactions is a credit account transaction for a closed credit account
      And staff have not chosen a historical transaction to refund to
     When staff attempt to finish the refund to multiple payment methods workflow for permit A
     Then staff cannot complete the refund to multiple payment methods for permit A
      And they see "Refund Error Total refund amount does not match total refund due."
      And they have the option to "Close" the message

  Scenario: closing the warning
     When they choose to close the "Refund can't be processed" message
     Then the message is closed
      And staff remain on the refund to multiple payment methods workflow for permit A

@orv2-5679-9
Rule: staff can complete a refund if the credit account is on hold in onRouteBC

  Scenario: credit account on hold finish
    Given staff are refunding permit A to multiple payment methods
      And the credit account used for the refund is on hold in onRouteBC
     When they attempt to finish the refund to multiple payment methods workflow for permit A
     Then staff can complete the refund to multiple payment methods for permit A

@orv2-5679-10
Rule: staff can complete a refund to a credit account transaction history record even if the cv client is no longer a user of the credit account as long as the credit account is active or on hold in onRouteBC

  Scenario: no longer user account active or on hold finish
    Given cv client A is no longer a user of credit account 1
      And permit A was purchased using credit account 1
      And credit account 1 is active or on hold in onRouteBC
     When staff attempt to finish the refund to multiple payment methods workflow for permit A
     Then staff can complete the refund to multiple payment methods for permit A

@orv2-5679-11
Rule: the refund amount reflects in the credit account current balance and available credit immediately after the refund is completed

  Scenario: refund amount reflects in current balance
    Given staff have completed a refund to multiple payment methods for permit A with a refund amount of 100 to credit account 1
     When they view the credit account details for credit account 1
     Then they see the current balance has decreased by 100 for credit account 1 immediately after the refund is completed
      And they see the available credit has increased by 100 for credit account 1 immediately after the refund is completed

@orv2-5701
Rule: the refund transactions are sent to eGARMS at the end of the day in the Credit Extract file after the refund is completed

  Scenario: refund transactions sent to eGARMS
    Given staff have completed a refund to multiple payment methods for permit A with a refund amount of 100 to credit account 1
     When it is the end of the day
     Then they see the refund transaction for credit account 1 in the Credit Extract file sent to eGARMS for the day that the refund was completed
      And they see the refund transaction details as follows:
       | data             | description                                                             |
       | Transaction ID   | the unique identifier for the refund transaction generated by onRouteBC |
       | Credit Account   | the credit account number used for the refund transaction               |
       | Refund Amount    | the amount refunded to the credit account                               |
       | Transaction Date | the date and time that the refund transaction was completed             |

# Notes:
- do eGARMS and onRouteBC transactions get assembled into the same extracts?
 - onRouteBC transactions are sent in the end of day extract to eGARMS
 - eGARMS transactions are sent in real time to onRouteBC
Starting Balances:
- onRoute Account Balance = 1000
- GARMS Account Balance = 1000

If an onRoute refund credit of 100 is created first, then:
- onRoute Account Balance = 1100
- the 100 refund is immediately reflected in onRoute Account Balance
- onRoute does not send this transaction to eGARMS in real time
- onRoute Unposted = 100
- onRoute Unposted is sent to eGARMS at end of day in the Credit Extract file

Else if a GARMS payment credit of 100 is created first, then:
- eGARMS Account Balance = 1100
- onRoute Account Balance = 1100

Else if both postings exist in any order (onRoute refund 100 and eGARMS payment 100), and onRoute has synced with eGARMS, then:
- onRoute uses eGARMS total balance = 1100
- onRoute Account Balance = 1200 (1100 eGARMS total balance + 100 onRouteBC unposted refund)
- onRoute Unposted remains 100 during the day and is sent to eGARMS in the end-of-day Credit Extract file

- eGARMS return code?
 - disable RTMPM
 - indicate the return code on the refund summary page
 - can we refund expired permits? confirm #nextaction
we send copies of permit and receipt pdf to the credit account holder for:
new purchase
void
amend with refund
$0 amend
## eGARMS RETURN CODE DEFINITIONS
- E0001: Credit account not found.
- E0002: Credit account is inactive.
- E0003: Credit account on hold.
- E0004: Credit account has exceeded the negative allowed amount.
- E1739: Credit account has exceeded the negative allowed amount.
- E9999: Serious error.

# Deprecated rules:
 @orv2-2004-5
 Rule: upon choosing a credit account historical transaction for a closed credit account, cheque refund is selected by default and cannot be deselected

   Scenario: closed credit account historical transaction
     Given permit A has a closed credit account historical transaction
      When staff select permit A historical transactions
      Then cheque refund is selected by default and cannot be deselected

   Scenario: active credit account historical transaction
     Given permit A has an active credit account historical transaction
      When staff select permit A historical transaction
      Then cheque refund is not selected by default
       But cheque refund can be optionally selected

   Scenario: on hold credit account historical transaction
     Given permit A has an on hold credit account historical transaction
      When staff select permit A historical transaction
      Then cheque refund is not selected by default
       But cheque refund can be optionally selected

 @orv2-4912
 Rule: a refund can only be made to the credit account used in the original purchase if the cv client is still a holder

   Scenario: user changes credit account
     Given user x purchases permit A using credit account 1
       And user x changes to credit account 2
      When staff refund to multiple payment methods for permit A
      Then cheque refund is selected by default and cannot be deselected

   Scenario: cv client no longer holder 
     Given permit A is purchased by cv client 1 using credit account Y
       And cv client A is no longer a user/holder of credit account Y
      When staff attempt to refund to multiple payment methods for permit A
      Then cheque refund is selected by default and cannot be deselected