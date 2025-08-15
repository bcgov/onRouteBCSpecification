Feature: Refund to multiple payment methods credit accounts

Staff = SA

Note: See common refund to multiple payment methods features that apply to this feature. Where users are directed to refund to multiple payment methods from the void workflow refer to void permit feature for related rules and behaviour.

@orv2-2004-1
Rule: Refund tran id is unavailable for credit account historical transactions

@orv2-2004-2
Rule: credit account void and amend ($0 or refund) generated permit pdf and receipt are always sent to the credit account holder

  Scenario: credit account holder $0 amend
    Given permit A is being amended
      And it has a $0 fee  
     When staff finish refund to multiple payment methods for permit A
     Then the amend permit pdf and receipt pdf are sent to the credit account holder as follows:
      | email address                                      | pdfs sent to email address    |
      | credit account holder - company email              | amend permit pdf, receipt pdf |
      | credit account holder - additional email (if used) | amend permit pdf, receipt pdf |

  Scenario: credit account holder closed
    Given permit A is being amended
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

@orv2-2004-3
Rule: completed refunds reduce credit account current balance immediately

@orv2-2004-4
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

@orv2-4912-2
Rule: a refund can only be made to the credit account used in the original purchase 

  Scenario: user changes credit account
    Given 
     When 
     Then 




# Notes:
# we send copies of permit and receipt pdf to the credit account holder for:
# new purchase
# void
# amend with refund
# $0 amend