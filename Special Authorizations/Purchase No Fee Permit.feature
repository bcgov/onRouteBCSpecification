Feature: As user I need to purchase permits without being charged any fees.

CV Client = CA, PA
Staff = SA, PC, CTPO, Trainee

@orv2-1491-1
Rule: No fee permit cv clients are exempt from any charges when purchasing a permit.

  Scenario: permit application fee summary
     When the user has completed the permit application
     Then they see $0 in the fee summary

  Scenario: shopping cart
     When the user has chosen to pay for the permit
     Then they see $0 in the fee summary

  Scenario: receipt pdf
     When the user receives the permit payment reciept
     Then they see $0 in the fee summary

  Scenario: permit pdf
     When the user receives the permit pdf
     Then they see $0 in the fee summary