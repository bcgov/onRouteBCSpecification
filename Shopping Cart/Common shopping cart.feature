Feature: Shopping cart
  As a User I need to be able to purchase more than one permit at once, so that I can save time.

User = CA, PA, SA, PC, CTPO, Trainee

@ovr2-1486-9, @orv2-2048-5
Rule: Navigate to shopping cart from anywhere in onRouteBC

@ovr2-1486-10, @orv2-2048-6
Rule: Cart contains relevant information about each item

  Scenario: shopping cart items details
    Given a user chooses to view the cart
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
    Given a user chooses to view the cart
     When they arrive at the cart
     Then they see the most recently added items at the top of the cart list and previously added items listed newest to oldest in descending order

@ovr2-1486-11, @orv2-2048-7
Rule: Add permit application to shopping cart

  Scenario: continue shopping
    Given the User has completed a permit application
     When they choose to add the application to the cart
     Then the application is added to the cart
      And they are directed to the applications in progress page
      And they see notification of the application added to the cart
      And the shopping cart count increases by 1

  Scenario: checkout
    Given the User has completed a permit application
     When they choose to checkout
     Then the application is added to the cart
      And they are directed to the shopping cart
      And the shopping cart count increases by 1
   
@ovr2-1486-12, @orv2-2048-8
Rule: Show indication in the shopping cart when nothing is in the cart

  Scenario: User has no items in cart
    Given the User chooses to view cart
    When they arrive at the cart
     Then they see "nothing found"

  Scenario: other Users have items in cart
    Given the User chooses to view cart
    When they arrive at the cart
     And they are at "my applications"
     Then they see "nothing found"

@ovr2-1486-13, @orv2-2048-9
Rule: Shopping cart shows number of items in the cart

  Scenario: all applications all selected
    Given there are 2 my application items in the cart
      And 3 all application items in the cart
     When a user chooses to view all applications
     Then they see 5 of 5

  Scenario: all applications some selected
    Given there are 2 my application items in the cart
      And 3 all application items in the cart
     When a user chooses to view all applications
      And deselects 1 item
     Then they see 4 of 5

  Scenario: my applications all selected
    Given there are 2 my application items in the cart
      And 3 all application items in the cart
     When a user chooses to view my applications
     Then they see 2 of 2

@ovr2-1486-14, @orv2-2048-10
Rule: Edit application in the cart

  Scenario: initiate edit from cart warning
    Given the user is at the shopping cart
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: initiate edit from applications in progress
    Given the user chooses to edit an application that is in the cart
      And they are at the applications in progress page
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: item already in editing warning
    Given the user chooses to edit an application that is in the cart
     When they choose to edit an application
     Then the see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

   Scenario: item already in editing continue
    Given the user chooses to continue to edit an application that is in the cart
     When they choose to continue
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

  Scenario: continue edit action
    Given the user is at edit warning 
     When they choose to continue the edit action
     Then they are directed to the first page of the application workflow
      And the permit application attestations are removed
      And the item is removed from the shopping cart

@ovr2-1486-15, @orv2-2048-11
Rule: Remove applications in the cart

  Scenario: no items in cart
    Given user has no items in the shopping cart
     When they choose to view the cart
     Then remove from cart is disabled

  Scenario: remove an item
    Given the user has items in the cart
     When they select one of many items
      And they choose to remove the selected item
     Then the item is removed from the cart
      And items remaining in the cart are unaffected 

  Scenario: item already removed warning
    Given user attempts to remove and item from the cart 
     When they choose to remove an item
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: item already removed continue
    Given user is at update warning
     When they choose to continue
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

@ovr2-1486-16, @orv2-2048-12
Rule: Remove items in cart that are not in compliance with policy

  Scenario: start date in the past
    Given permit(s) have a <start date> before the <current date>
     When a user views the shopping cart
     Then these permit(s) are removed from the cart

  Examples:
    | start date | current date |
    | 03/01/2023 | 03/02/2023   |
   
@ovr2-1486-17, @orv2-2048-13
Rule: Show items removed from cart 

  Scenario: no items removed
    Given a user has not had any items removed from the cart
     When they choose to view the shopping cart
     Then they do not see an alert box

  Scenario: items removed from cart
    Given the user has had items removed from the cart
     When they choose to view the shopping cart
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

@ovr2-1486-18, @orv2-2048-14
Rule: Cart can have an unlimited number of items

@ovr2-1486-19, @orv2-2048-15
Rule: One or more items in cart may selected for purchase or removal

  Scenario: no items in cart
    Given a user chooses to view the cart
     When there are no items in the cart
     Then select all is disabled

  Scenario: default selection 
    Given a user chooses to view the cart
     When they arrive at the cart
     Then all items are selected

  Scenario: select one or more items
    Given a user has items in the cart
      And all or some items are deselected
     When they choose to select an item
     Then one or more items are selected

  Scenario: select all items
    Given a user has items in the cart
      And none are selected
     When they choose to select all items
     Then all items are selected

  Scenario: deselect all items
    Given a user has items in the cart
      And all are selected
     When they choose to deselect all items
     Then all items are deselected

@ovr2-1486-20, @orv2-2048-16
Rule: Fee summary total reflects cart item selection 

  Scenario: no items selected
    Givena user has items in the cart
     When no items are selected
     Then the fee summary shows $0

  Scenario: one or more items selected
    Givena user has items in the cart
     When one or more items selected
     Then the fee summary reflects the total of sum of all selected item fees

@ovr2-1486-21, @orv2-2048-17
Rule: Changing cart item filter initiates selecting all items in the cart

  Scenario: in my apps 3 of 4 selected
    Given a user is at my applications
     When they choose to view all applications
     Then they see all items in the cart
      And they are all selected

  Scenario: in all apps 0 of 10 selected
    Given a user is at all applications
     When they choose to view my applications
     Then they see only my applications in the cart
      And they are all selected

@ovr2-1486-22, @orv2-2048-18
Rule: User cart defaults to All Applications filter when first loading cart

  Scenario: view cart
    Given a user is not in the shopping cart
     When they choose to view the cart
     Then they are directed to the shopping cart
      And they see all applications

@ovr2-1486-23, @orv2-2048-19
Rule: Fee summary total reflects the filtered list

  Scenario: items in my applications
    Given user has items in the cart
     When they choose to view my applications
     Then the fee summary reflects the total of sum of all selected item fees in my applications

  Scenario: items in all applications
    Given user has items in the cart
     When they chooses to view all applications 
     Then the fee summary reflects the total of sum of all selected item fees in all applications

@ovr2-1486-24, @orv2-2048-20
Rule: At least one items must be selected to purchase

  Scenario: no items selected
    Given user has items in the cart
      And none are selected
     When they choose pay
     Then they see "Select at least one item to pay"

 # duplicate to selection defaults
  Scenario: one or more items purchases but not the entire cart
    Given user has unselected some items in the cart
     When they pay for the cart
     Then the unselected items are selected 

@ovr2-1486-25, @orv2-2048-21
Rule: Show success page when the financial transaction has completed successfully

  Scenario: successful payment 
    Given user is at PayBC
     When they successfully pay for the cart
     Then they are directed to the success page 
      And they see "The permit(s) and receipt have been sent to the email/fax provided."
      And they can optionally apply for another permit

  Scenario: successful payment but issuance fails
    Given onRouteBC is not able to issue the permits
      And onRoute has received successful payment
     When the user completes payment at PayBC
     Then they are directed to the error page and they see:
       | Payment was successful. However, some of your applications weren't processed. Please go to applications in Progress to review your pending permits. |
      And they can optionally view application in progress

@ovr2-1486-26, @orv2-2048-22
Rule: Show pending permits with successful payment received that have not been issued yet

  Scenario: viewing pending permits list
    Given the CV Client has pending permits
     When they choose to view the pending permits list
     Then they see the list of pending permits with the following details:
       | field              | description                                                                                                                            |
       | application number | the application number generated by onRouteBC                                                                                          |
       | plate              | the plate of the permit application vehicle                                                                                            |
       | applicant          | the first name and last name of the logged in user that started the permit application or Provincial Permit Center if started by staff |
      And they see:
       | There was an unexpected error in issuing the following permits. No action from you is required. onRouteBC will keep trying to issue these permits once the error is resolved. If you need immediate assistance, please contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca. |

@ovr2-1486-27, @orv2-2048-23
Rule: Show the number of pending permits

  Scenario: viewing pending permits list
    Given the user has pending permits
     When they choose to view the pending permits list
     Then they see the total number of pending permits

@ovr2-1486-28, @orv2-2048-24
Rule: Show notification of pending permits with successful payment received that have not been issued yet

  Scenario: user has pending permits
    Given the CV Client has pending permits
     When they view the applications in progress list 
     Then they see "Some of your applications weren't processed. See your Pending Permits"
      And they can optionally view the pending permits list

  Scenario: CV Client does not have pending permits
    Given the CV Client does not have pending permits
     When they view the applications in progress list 
     Then they do not see the the pending permits notification

@orv2-1486-29, @orv2-2048-25
Rule: Issue permits with successful payment received that have not been issued

  Scenario: permit not yet issued
    Given there are pending permits
     When issuance is possible
     Then issue pending permits

@orv2-1486-30, @orv2-2048-26
Rule: Send one email per issued permit

  Scenario: multiple permits issued
    Given 10 permits were issued
     When the CV Client receives the permit emails
     Then they see 10 emails with one permit attached

@orv2-1486-31, @orv2-2048-27
Rule: Send one receipt per cart in each permit email

 Scenario: multiple permits issued
    Given 10 permits were issued
     When the CV Client receives the permit emails
     Then they see 10 emails with the same receipt attached to each

@orv2-1486-32, @orv2-2048-28
Rule: Only authorized users (CA, PA, SA, PC, CTPO, Trainee) can see the shopping cart icon