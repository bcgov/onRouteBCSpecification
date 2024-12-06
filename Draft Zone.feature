Rule: All chosen LOA(s) used in a permit application must be valid on pay now

  Scenario: reduce LOA(s) term
    Given user has permit A in cart
     And permit A uses LOA(s) B
     When permit A exceeds the LOA(s) B end date
     Then they see ""
      And they see "Application error. Please remove it from the cart."

  Scenario: LOA(s) edited to remove permit type vehicles and date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses vehicle 1
      And vehicle 1 is removed from LOA(s) B
     When they pay now
     Then they see ""
      And they see "Application error. Please remove it from the cart."

  Scenario: LOA(s) edited to remove permit type date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses permit type 1
      And permit type 1 is removed from LOA(s) B
     When they pay now
     Then they see ""
      And they see "Application error. Please remove it from the cart."

  Scenario: permit application(s) are invalid continue
    Given 
     When 
     Then 

