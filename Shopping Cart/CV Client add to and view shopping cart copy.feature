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


@orv2-1486
Rule: Add permit application to shopping cart

  Scenario: continue shopping
    Given the CV Client has completed a permit application
     When they choose to add the application to the cart
     Then the application is added to the cart
      And they are directed to the applications in progress page
      And they see notification of the application added to the cart

  Scenario: 
    Given 
     When 
     Then 



@orv2-1486
Rule: Show indication when nothing is in the cart

@orv2-1486
Rule: CV Client can't see staff items in the cart

@orv2-1486
Rule: CA can see total company cart item count

@orv2-1486
Rule: PA can see only their cart item count

@orv2-1486
Rule: CA can see all company CA and PA items in the cart

@orv2-1486
Rule: Edit application in the cart

@orv2-1486
Rule: Remove applications in the cart

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