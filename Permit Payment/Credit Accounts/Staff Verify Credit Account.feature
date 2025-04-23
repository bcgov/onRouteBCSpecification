Feature: Staff verify credit account

Staff = FIN
Users = CA, PA, PC, SA, TRAIN, CTPO

@ovr2-3821
Rule: a closed, on hold or suspended company credit account can be verified

Rule: an unverified credit account can be closed or on hold

  Scenario: unverified on hold 
     When credit account A is put on hold in TPS/GARMS
     Then it is unverified and on hold
      And the label "On Hold" is shown
      And the label "Unverified" is shown

  Scenario: unverified closed
     When credit account A is closed in TPS/GARMS
     Then it is unverified and closed
      And the label "Closed" is shown
      And the label "Unverified" is shown 

Rule: a verified account can be closed or on hold

  Scenario: verified on hold 
     When credit account A is put on hold in TPS/GARMS
     Then it is verified and on hold
      And the label "On Hold" is shown

  Scenario: verified closed
     When credit account A is closed in TPS/GARMS
     Then it is verified and closed
      And the label "Closed" is shown

Rule: only authorized staff can verify an onRouteBC credit account

  Scenario: authorized
     When FIN are at a cv client holder credit account
     Then they see the option to verify account

Rule: only the holder of the credit account can be verified

  Scenario: user profile
    Given credit account A has user 1
     When staff choose to verify user 1
     Then the option to verifiy credit account A is not available

Rule: credit account users are verified when an account holder is verified

  Scenario: credit account A has users
    Given credit account A has user 1
     When credit account A is verified
     And is not:
      | closed            |
      | on hold           |
      | company suspended |
     Then user 1 can user credit account A as a payment method

Rule: staff must input a reason for credit account verification

  Scenario: reason inputted
     When staff continue verifying credit account A
     Then they are directed to the holder credit account A page
      And they see "Account Verified" notification
      And credit account A is verified

  Scenario: none inputted
     When staff continue verifying the credit account
     Then they see "This is a required field."
      And they cannot verify the credit account

Rule: the account history is updated to when the account is verified

  Scenario: unverified account
    Given credit account A is not verified
     When credit account A is verified
     Then the account history for credit account A is updated with a new record as follows:
        | data   | description                              |
        | IDIR   | FIN IDIR username                        |
        | Date   | date/time the verification was initiated |
        | Reason | freetext inputted by FIN staff           |
        | Status | "Account Verified"                       |

Rule: a verified credit account can be used as a payment method by users

  Scenario: credit account unverified
    Given credit account A is unverified
     When users are at the shopping cart 
      And the cart is a holder or user of credit account A
     Then they do not see credit account as a payment method

  Scenario: credit account verified
    Given credit account A is verified
      And is not:
      | closed            |
      | on hold           |
      | company suspended |
     When users are at the shopping cart
      And the cart is a holder or user of credit account A
     Then they see credit account as a payment method

Rule: a verified credit account cannot be unverified

  Scenario: verified 
    Given credit account A is verified
     When staff attempt to verify credit account A
     Then the option to verify is not available

  Scenario: unverified
    Given credit account A is not verified
     When staff attempt to verify credit account A
     Then the option to verify is available

Rule: verifying a credit account does not change the status of a credit account (hold, closed) or modify associated credit account users
Rule CA can see the unverified credit account page

  Scenario: credit account unverified
    Given company A credit account is unverified
     When company A CA is viewing credit account
     Then they see:
       | description         | data                                                                               |
       | status label        | "Unverified"                                                                       |
       | account designation | "Account Holder"                                                                   |
       | info box            | "Please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" |

  Scenario: credit account unverified and on hold
    Given company A credit account is unverified
     When company A CA is viewing credit account
     Then they see:
       | description         | data                                                                               |
       | status label        | "Unverified"                                                                       |
       | account designation | "Account Holder"                                                                   |
       | info box            | "Please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" |

  Scenario: credit account unverified closed
    Given company A credit account is unverified
     When company A CA is viewing credit account
     Then they see:
       | description         | data                                                                               |
       | status label        | "Unverified"                                                                       |
       | account designation | "Account Holder"                                                                   |
       | info box            | "Please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" |