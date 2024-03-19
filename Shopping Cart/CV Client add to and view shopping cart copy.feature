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
Rule: Show indication in the shopping cart when nothing is in the cart

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
     Then they see the <number> of items selected of the <total> number of items in the cart

    Examples:
      | number | total |
      | 5      | 5     |

  Scenario: some items are selected
    Given the CV client has 5 items in the cart
     When they deselect all items
      And select 1 or more items
     Then they see the <number> of items selected of the <total> number of items in the cart

    Examples:
      | number | total |
      | 1      | 5     |
      | 2      | 5     |

@orv2-1486
Rule: CA can see total company shopping cart item count in the header

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
Rule: PA can see only their cart item count in the header

@orv2-1486
Rule: CA can see all company CA and PA items in the cart

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have items in the cart
     When they view the shopping cart
     Then they see all company items in the cart including theirs

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have items in the cart
     When the CA logs into onRouteBC
     Then they see all company items in the cart

@orv2-1486
Rule: Edit application in the cart

  Scenario: initiate edit from cart warning
    Given the CV Client is at the shopping cart
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: initiate edit from applications in progress
    Given the CV Client chooses to edit an application that is in the cart
      And they are at the applications in progress page
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: item already in editing warning
    Given 
     When 
     Then 

   Scenario: item already in editing continue
    Given 
     When 
     Then 

  Scenario: continue edit action
    Given the CV Client is at edit warning 
     When they choose to continue the edit action
     Then they are directed to the first page of the application workflow
      And the permit application attestations are removed
      And the item is removed from the shopping cart

@orv2-1486
Rule: Remove applications in the cart

  Scenario: no items in cart
    Given CV Client has no items in the shopping cart
     When they choose to view the cart
     Then remove from cart is disabled

  Scenario: item already removed warning
    Given CV Client attempts to remove and item from the cart 
     When they choose to remove an item
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: remove an item
    Given the CV Client has items in the cart
     When they select one of many items
      And they choose to remove the selected item
     Then the item is removed from the cart
      And items remaining in the cart are unaffected 

  Scenario: item already removed continue
    Given CV Client is at update warning
     When they choose to continue
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

@orv2-1486
Rule: Remove items in cart that are not in compliance with policy

  Scenario: start date in the past
    Given 
     When 
     Then 

@orv2-1486
Rule: Show items removed from cart 

  Scenario: no items removed
    Given the CV Client has not had any items removed from the cart
     When they choose to view the shopping cart
     Then they do not see an alert box

  Scenario: items removed from cart
    Given the CV Client has had items removed from the cart
     When they choose to view the shopping cart
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

@orv2-1486
Rule: Cart can have an unlimited number of items

@orv2-1486
Rule: One or more items in cart may selected for purchase or removal

  Scenario: no items in cart
    Given the CV Client chooses to view the cart
     When there are no items in the cart
     Then select all is disabled

  Scenario: default selection 
    Given CV Client choose to view the cart
     When they arrive at the cart
     Then all items are selected

  Scenario: select one or more items
    Given the CV Client has items in the cart
      And all or some items are deselected
     When they choose to select an item
     Then one or more items are selected

  Scenario: select all items
    Given the CV Client has items in the cart
      And none are selected
     When they choose to select all items
     Then all items are selected

  Scenario: deselect all items
    Given the CV Client has items in the cart
      And all are selected
     When they choose to deselect all items
     Then all items are deselected

@orv2-1486
Rule: Fee summary total reflects cart item selection 

  Scenario: no items selected
    Given the CV Client has items in the cart
     When no items are selected
     Then the fee summary shows $0

  Scenario: one or more items selected
    Given the CV Client has items in the cart
     When one or more items selected
     Then the fee summary reflects the total of sum of all selected item fees

@orv2-1486
Rule: CA can filter cart by their items or all company CA and PA items

  Scenario: filter by my applications
    Given the logged in CA has items in the cart
     When they choose to view my applications
     Then they see only applications started by the logged in CA user

  Scenario: filter by all applications
    Given the CV Client has items in the cart
     When the logged in CA user chooses to view all applications
     Then they see all applications started by the logged in CA user 
      And those started by other CA and PA users added to the cart

@orv2-1486
Rule: Changing cart item filter initiates selecting all items in the cart

  Scenario: in my apps 3 of 4 selected
    Given the CA is at my applications
     When they choose to view all applications
     Then they see all items in the cart
      And they are all selected

  Scenario: in all apps 0 of 10 selected
    Given the CA is at all applications
     When they choose to view my applications
     Then they see only my applications in the cart
      And they are all selected


@orv2-1486
Rule: CA cart defaults to My Applications filter when first loading cart

  Scenario: view cart
    Given the CV Client is not in the shopping cart
     When they choose to view the cart
     Then they are directed to the shopping cart
      And they see my applications


@orv2-1486
Rule: Fee summary total reflects the filtered list

  Scenario: items in my applications
    Given the CA has items in the cart
     When the CA chooses to view my applications
     Then the fee summary reflects the total of sum of all selected item fees in my applications

  Scenario: items in all applications
    Given the CV Client has items in the cart
     When the CA chooses to view all applications 
     Then the fee summary reflects the total of sum of all selected item fees in all applications

@orv2-1486
Rule: At least one items must be selected to purchase

  Scenario: no items selected
    Given the CV Client has items in the cart
      And none are selected
     When they choose pay
     Then they see "Select at least one item to pay"

@orv2-1486
Rule: Show success page when the financial transaction has completed successfully

  Scenario: successful payment 
    Given the CV Client is at PayBC
     When they successfully pay for the cart
     Then they are directed to the success page 
      And they see "The permit(s) and receipt have been sent to the email/fax provided."
      And they can optionally apply for another permit

  Scenario: successful payment issuance fails
    Given 
     When 
     Then 

@orv2-1486
Rule: Send one email per issued permit

  Scenario: 
    Given 
     When 
     Then 


@orv2-1486
Rule: Send one receipt per cart in each permit email

  Scenario: 
    Given 
     When 
     Then 

