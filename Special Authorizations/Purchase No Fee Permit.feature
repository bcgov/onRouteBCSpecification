Feature: As user I need to purchase permits without being charged any fees.

User = CA, PA, SA, PC, CTPO, Trainee
CV Client = CA, PA
Staff = SA, PC, CTPO, Trainee

@orv2-1491-1 @orv2-4601-1
Rule: No fee permit cv clients are exempt from any charges when purchasing a permit except ICBC Insurance FR permits.

  Scenario: permit application fee summary
     When a user has completed the permit application
     Then they see $0 in the fee summary

  Scenario: shopping cart
     When a user has chosen to pay for the permit
     Then they see $0 in the fee summary

  Scenario: receipt pdf
     When a user receives the permit payment reciept
     Then they see $0 in the fee summary

  Scenario: permit pdf
     When a user receives the permit pdf
     Then they see $0 in the fee summary

@orv2-1491-2 @orv2-4601-2
Rule: A no fee permit is always a no fee permit except ICBC Insurance FR permits

  Scenario: void as no fee
    Given permit A was purchased by a no fee cv client
      And the cv client is a no fee client
     When staff void permit A
     Then the refund is $0

  Scenario: amend as no fee
    Given permit A was purchased by a no fee cv client
      And the cv client is a no fee client
     When staff amend permit a
      And the amendment results in a refund
     Then the refund is $0

  Scenario: void as fee
    Given permit A was purchased by a no fee cv client
      And permit A is issued or active
      And the cv client becomes a fee client after purchasing permit A
     When staff void permit A
     Then the refund is $0

  Scenario: amend as fee
    Given permit A was purchased by a no fee cv client
      And permit A is issued or active
      And the cv client becomes a fee client after purchasing permit A
      When staff amend permit A
      And the amendment results in a refund
     Then the refund is $0

  Scenario: void as no fee ICBC
    Given permit A was purchased by a no fee cv client
      And permit A has a current permit value (CPV) of $84
     When staff void permit A
     Then the refund is $84

  Scenario: amend as no fee ICBC
    Given permit A was purchased by a no fee cv client
      And permit A has a current permit value (CPV) of $84
     When staff amend permit a 
      And the amendment results in a refund of $5
     Then the refund is $5

@orv2-1491-3
Rule: A fee permit is always a fee permit

  Scenario: void as fee
    Given permit A was purchased by a fee cv client for $60
      And permit A is issued or active
      And the cv client becomes a no fee client after purchasing permit A
     When staff void permit A
     Then the refund is $60

  Scenario: amend as fee
    Given permit A was purchased by a fee cv client
      And permit A is issued or active
      And the cv client becomes a no fee client after purchasing permit A
      When staff amend permit A
      And the amendment results in a $30 refund
     Then the refund is $30

@orv2-4601-3
Rule: a no fee CV Client must pay for ICBC Insurance FR permits (single trip and quarterly)

# see the following:
# Applying for Permits/Non-Resident Quarterly ICBC Basic Insurance
# Applying for Permits/Non-Resident Single Trip ICBC Basic Insurance

