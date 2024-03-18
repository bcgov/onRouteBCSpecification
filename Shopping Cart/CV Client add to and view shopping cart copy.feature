Feature: CV Client shopping cart
  As a CV Client CA or PA I need to be able to purchase more than one permit at once, so that I can save time.

CV Client = CA, PA
@orv2-1486
Rule: Cart contains relevant information about each item

  Scenario: shopping cart items details
    Given the CV Client chooses to view the cart
     When they arrive at the cart
     Then they see the following information about each item:
       | field              | description                                              |
       | application number | the onRouteBC generated application number               |
       | permit type        | the chosen permit type name                              |
       | plate              | the inputted plate number of the application vehicle     |
       | start date         | the inputted started date date of the permit application |
       | expiry date        | the calculated expiry date of the permit application     |
       | item fee           | the fee of the permit application                        |
       | applicant          | the requested by of the permit application               |

  Scenario: default cart item sort order
    Given the CV Client chooses to view the cart
     When they arrive at the cart
     Then they see the most recently added items at the top of the cart list and previously added items listed newest to oldest in descending order

@orv2-1486
Rule: Add permit application to shopping cart

  Scenario: continue shopping
    Given the CV Client has completed a permit application
     When they choose to add the application to the cart
     Then the application is added to the cart
      And they are directed to the applications in progress page
      And they see notification of the application added to the cart
      And the shopping cart count increases by 1

  Scenario: checkout
    Given the CV Client has completed a permit application
     When they choose to checkout
     Then the application is added to the cart
      And they are directed to the shopping cart
      And the shopping cart count increases by 1
   
@orv2-1486
Rule: Show indication when nothing is in the cart

  Scenario: CV Client has no items in cart
    Given the CV Client chooses to view cart
    When they arrive at the cart
     Then they see "nothing found"

  Scenario: other CA or PA have items in cart
    Given the CV Client chooses to view cart
    When they arrive at the cart
     And they are at "my applications"
     Then they see "nothing found"

@orv2-1486
Rule: CV Client can't see staff items in the shopping cart

  Scenario: Staff have items in cart
    Given the CV Client does not have items in the cart
    When they arrive at the cart          
     Then they see "nothing found"

@orv2-1486
Rule: Shopping cart shows number of items in the cart

  Scenario: Staff have items in cart
    Given the CV Client does not have items in the cart
    When they arrive at the cart          
     Then the number of items is 0 of 0

  Scenario: CV Client has items in the cart
    Given the CV Client has choosen to view the shopping cart
     When they arrive at the shopping cart 
     Then they see the <number> or items selected of the <total> number of items in the cart

    Examples:
      | number | total |
      | 5      | 5     |

@orv2-1486
Rule: CA can see total company shopping cart item count

   Scenario: Staff have items in cart
    Given the CV Client does not have items in the cart
    When they log into onRouteBC         
     Then the shopping cart count is 0

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have items in the cart
     When the CA logs into onRouteBC
     Then they see the shopping cart count reflects all company items in the cart including theirs

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have items in the cart
     When the CA logs into onRouteBC
     Then the shopping cart count reflects all company items in the cart

@orv2-1486
Rule: PA can see only their cart item count

@orv2-1486
Rule: CA can see all company CA and PA items in the cart

@orv2-1486
Rule: Edit application in the cart

@orv2-1486
Rule: Remove applications in the cart

      And remove from cart is disabled

@orv2-1486
Rule: CV Client can't see staff items in the cart

@orv2-1486
Rule: Check cart for policy compliance

@orv2-1486
Rule: Check cart for removed items

@orv2-1486
Rule: Show items removed from cart 

@orv2-1486
Rule: Cart can have an unlimited number of items

@orv2-1486
Rule: One or more items in cart may be purchased or removed

  Scenario: default selection 
    Given CV Client choose to view the cart
     When they arrive at the cart
     Then all items in filter are selected

      And select all is unavailable

@orv2-1486
Rule: Fee summary total reflects cart item selection 

@orv2-1486
Rule: CA can filter cart by their items or all company CA and PA items

@orv2-1486
Rule: Changing cart item filter initiates selecting all items in the cart

@orv2-1486
Rule: CA cart defaults to My Applications filter when first loading cart

@orv2-1486
Rule: Fee summary total reflects the filtered list

@orv2-1486
Rule: Show success page when financial transaction has completed successfully

@orv2-1486
Rule: Send one email per issued permit

@orv2-1486
Rule: Send one receipt per cart in each permit email