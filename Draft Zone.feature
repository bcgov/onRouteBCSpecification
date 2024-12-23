User = CA, PA, SA, PC, CTPO, Trainee


Rule: All chosen LOA(s) used in a permit application must be valid on pay now

  Scenario: reduce LOA(s) term
    Given user has permit A in cart
     And permit A uses LOA(s) B
     When permit A exceeds the LOA(s) B end date
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
      And they see "Application error. Please remove it from the cart."

remove from cart 

  Scenario: LOA(s) edited to remove permit type vehicles and date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses vehicle 1
      And vehicle 1 is removed from LOA(s) B
     When they pay now
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
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

  Scenario Remove from cart 1 of 10
    Given 
     Then they see "Remove Application You are removing XX items from your cart. Are you sure you want to continue?"

  Scenario: remove continue
    Given 
     When 
     Then 
      And directed to cart
      And warning info box is not visible
      And all items in the cart are selected

  Scenario: 1 or more app with error selected first validation
    Given 
     When 
     Then they see "Application error. Please remove it from the cart." on each application in error
      And they see the "Your shopping cart has application errors." warning info box

  Scenario: 1 or more app with error selected second validation
    Given 
     When 
     Then they see "Application Errors Applications in your shopping cart have errors. Please deselect or remove them to continue."

  Scenario
    Given user 1 and 2 are at the cart
      And app A and app B are in the cart
      And app B has been removed by user 1
     When user 2 pays for the cart
     Then user 2 sees error at app B
      And user 1 sees app A

Zhong Yu - re the cart #nextaction

- failed policy checked
 - direct to cart with error screen

- edit removed items
 - see edit modal

- Purchased or removed application will go away from cart. Rest of the invalid applications are at user's discretion, edit them, remove them, unselect them. do whatever please you.

- edit purchased item
 - see 

- Can we refresh to the current version of the cart to 


  Scenario
    Given the cart was paid by user 2
      And user 1 is at the cart
      And app A is in the cart
     When user 1 pays for the cart
     Then user 1 sees error at app A

Queue Issues:

- claim a claimed within 30 seconds
-  Apply the is it claimed logic to the applications in queue need a scenario for this 
