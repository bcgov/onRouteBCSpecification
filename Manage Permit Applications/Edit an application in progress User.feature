Feature: Users edit an application in progress

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-2560-1, @orv2-2561-1
Rule: Information initially inputted by the applicant is shown when opening to edit an application in progress

  Scenario: aip in cart
    Given application A is added to the cart
     When a user chooses to edit application A
     Then they see an unexpected error



