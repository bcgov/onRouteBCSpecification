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
    Given 
     When 
     Then 

  Scenario: on hold
    Given 
     When 
     Then 

@orv2-2004-5
Rule: cheque refund is the only option available for refunding to a credit account historical transaction when the credit account is closed

@orv2-2004-6
Rule: upon choosing a credit account historical transaction for a closed credit account, cheque refund is selected by default and cannot be deselected


# Notes:
# we send copies of permit and receipt pdf to the credit account holder for:
# new purchase
# void
# amend with refund
# $0 amend