Feature: Shopping cart
  As a User I need to be able to purchase more than one permit at once, so that I can save time.

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-3176-1
Rule: Show persistent cart info box

  Scenario: arrive at cart
     When users arrive at the cart
     Then they see the following info:
       "Know your shopping cart.
       The shopping cart is shared between all users authorized in the company profile for this onRouteBC client account. These
       users can modify (edit, remove and purchase) any item in the cart.
       Have any questions? 

       Please contact the Provincial Permit Centre. Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca"

@orv2-1486-9, @orv2-2048-5
Rule: Navigate to shopping cart from anywhere in onRouteBC

@orv2-1486-10, @orv2-2048-6
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
       | applicant          | the first name and last name of the logged in user that started the permit application or the Provincial Permit Center if started by staff |
       #Or the idir username if viewed by staff
       
  Scenario: default cart item sort order
    Given a user chooses to view the cart
     When they arrive at the cart
     Then they see the most recently added items at the top of the cart list and previously added items listed newest to oldest in descending order

@orv2-3071-8
Rule: Applicant is the user that creates the permit application

  Scenario: staff created permit application
     When staff view shopping cart
     Then applicant is IDIR username

  Scenario: staff created permit application
     When cv client view shopping cart
     Then applicant is Provincial Permit Center

  Scenario: cv client created permit application
     When staff view shopping cart
     Then applicant is logged in user first name last name

@orv2-1486-11, @orv2-2048-7
Rule: Add permit application to shopping cart

  Scenario: continue shopping
    Given the User has completed a permit application
     When they choose to add the application to the cart
     Then the application is added to the cart
      And they are directed to the applications in progress page
      And they see notification of the application added to the cart
      And the shopping cart count increases by 1

  # Scenario: checkout
    Given the User has completed a permit application
     When they choose to checkout
     Then the application is added to the cart
      And they are directed to the shopping cart
      And the shopping cart count increases by 1
   
@orv2-1486-12, @orv2-2048-8
Rule: Show indication in the shopping cart when nothing is in the cart

  Scenario: User has no items in cart
    Given the User chooses to view cart
    When they arrive at the cart
     Then they see "Cart is empty."

  Scenario: other Users have items in cart
    Given the User chooses to view cart
    When they arrive at the cart
     And they are at "my applications"
     Then they see "Cart is empty."

@orv2-1486-13, @orv2-2048-9
Rule: Shopping cart shows number of items in the cart

  Scenario: all applications all selected
    Given there are 2 my application items in the cart
      And 3 other all application items in the cart
     When a user chooses to view all applications
     Then they see 5 of 5

  Scenario: all applications some selected
    Given there are 2 my application items in the cart
      And 3 other all application items in the cart
     When a user chooses to view all applications
      And deselects 1 item
     Then they see 4 of 5

  Scenario: my applications all selected
    Given there are 2 my application items in the cart
      And 3 other all application items in the cart
     When a user chooses to view my applications
     Then they see 2 of 2

@orv2-1486-14, @orv2-2048-10
Rule: Edit application in the cart

  Scenario: initiate edit from cart warning
    Given the user is at the shopping cart
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  # Scenario: initiate edit from applications in progress
    Given the user chooses to edit an application that is in the cart
      And they are at the applications in progress page
     When they choose to edit an application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: item is being edited by someone else warning
    Given a user chooses to edit an application that is in the cart
     When a different user chooses to edit the same application
     Then the see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
      ## And they see the <list of applications> removed from the cart

  ## Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-876    |
     | • A2-00408617-878    |

  Scenario: continue edit action
    Given the user is at edit warning 
     When they choose to continue the edit action
     Then they are directed to the first page of the application workflow
      And the permit application attestations are removed
      And the item is removed from the shopping cart

@orv2-1486-15, @orv2-2048-11, @orv2-3176-2
Rule: Optionally remove applications in the cart

  Scenario: no items in cart
    Given user has no items in the shopping cart
     When they choose to view the cart
     Then remove from cart is disabled

  Scenario: remove an item
    Given the user has app A in the cart
     When they select app A
      And they choose to remove app A
     Then they see:
       "Remove Application
       You are removing 1 items from your cart. Are you sure you want to continue?"

  Scenario: continue on remove application warning
    Given app A was selected to remove 
     When they choose to remove
     Then they are directed to the cart
      And app A is not in the cart
      And remaining items are all selected in the current filter view

  Scenario: item already removed update warning
    Given app A has been removed from the cart
     When user attempts to remove app A from the cart 
     Then they see:
       "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: continue on remove update warning
    Given app A has been removed from the cart
      And user is at update warning
     When they choose to continue
     Then they are directed to the cart all applications
      And app A is not in the cart
      And all applications in the cart are selected

@orv2-1486-16, @orv2-2048-12, @orv2-3176-3
Rule: Remove purchased or optionally removed applications from the cart

  Scenario 2 users 1 removes 1 pays
    Given user 1 and 2 are at the cart
      And app A and app B are in the cart
      And app B has been removed by user 1
     When user 2 pays for the cart
     Then user 2 sees "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
      And user 1 sees app A

  Scenario: continue update cart warning from pay
    Given app B was invalid
     When a user chooses continue
     Then they are directed to to the cart all applications
      And app B is not in the cart
      And all applications in the cart are selected

  Scenario: 2 users 1 pays for the entire cart
    Given user 1 and 2 are at the cart
      And user 1 pays for the entire cart
     When user 2 pays for the cart
     Then user 2 sees "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: 2 users 1 pays for the entire cart continue
    Given user 1 pays for the entire cart
      And there are no applications in the cart
     When a user 2 chooses continue
     Then they are directed to to the cart all applications
      And they see "Cart is empty"

@orv2-3176-4
Rule: Applications that fail policy validation will prevent a user from paying for the cart
      
  Scenario: start date in the past pay
    Given permit application(s) have a <start date> before the <current date>
     When a user chooses to pay
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: reduce LOA(s) term
    Given user has permit A in cart
     And permit A uses LOA(s) B
     And permit A exceeds the LOA(s) B end date
     When they choose to pay
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: LOA(s) edited to remove permit type vehicles and date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses vehicle 1
      And vehicle 1 is removed from LOA(s) B
     When they pay now
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: LOA(s) edited to remove permit type date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses permit type 1
      And permit type 1 is removed from LOA(s) B
     When they pay now
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."

  Scenario: update cart continue on warning
     When a user chooses to update cart
     Then they are directed to the cart all applications
      And they see:
       "Your shopping cart cannot be completed.
       The shopping cart contains Application(s) with one or more errors. Those applications must be deselected or removed from
       the cart to proceed with payment. Common errors include, but are not limited to, start date is in the past or an invalid
       vehicle."
      And they see "Invalid Application" at the invalid application in 

  Scenario: pay again without removing invalid application(s)
    Given invalid applications remain in the cart
     When a user chooses to pay
     Then they see:
       "Application Errors 
       Applications in your shopping cart has errors. Please deselect or remove them to continue."
 
   Scenario: pay again close
      When a user chooses to close the application errors warning
      Then they are directed to the cart
       And they see:
       "Your shopping cart cannot be completed.
       The shopping cart contains Application(s) with one or more errors. Those applications must be deselected or removed from
       the cart to proceed with payment. Common errors include, but are not limited to, start date is in the past or an invalid
       vehicle."
      And they see "Invalid Application" at the invalid application in 

# deprecated
# @orv2-1486-17, @orv2-2048-13
# Rule: Show items removed from cart 

  Scenario: no items removed
    Given no items have been removed from the company cart
     When a user chooses to view the shopping cart
     Then they do not see an alert box

@orv2-1486-18, @orv2-2048-14
Rule: Cart can have an unlimited number of items

@orv2-1486-19, @orv2-2048-15
Rule: One or more items in cart may be selected for purchase or removal

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

@orv2-1486-20, @orv2-2048-16
Rule: Fee summary total reflects cart item selection 

  Scenario: no items selected
    Given a user has items in the cart
     When no items are selected
     Then the fee summary shows $0

  Scenario: one or more items selected
    Given a user has items in the cart
     When one or more items selected
     Then the fee summary reflects the total of sum of all selected item fees

@orv2-1486-21, @orv2-2048-17
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

@orv2-1486-22, @orv2-2048-18
Rule: User cart defaults to All Applications filter when first loading cart

  Scenario: view cart
    Given a user is not in the shopping cart
     When they choose to view the cart
     Then they are directed to the shopping cart
      And they see all applications

@orv2-1486-23, @orv2-2048-19
Rule: Fee summary total reflects the filtered list

  Scenario: items in my applications
    Given user has items in the cart
     When they choose to view my applications
     Then the fee summary reflects the total of sum of all selected item fees in my applications

  Scenario: items in all applications
    Given user has items in the cart
     When they chooses to view all applications 
     Then the fee summary reflects the total of sum of all selected item fees in all applications

@orv2-1486-24, @orv2-2048-20
Rule: At least one item must be selected to purchase

  Scenario: no items selected
    Given user has items in the cart
      And none are selected
     When they choose pay
     Then they see "Select at least one item to pay"

  Scenario: one or more item selected
    Given items are valid
      And a user has one or more items selected
     When they choose to pay
     Then they are directed to PayBC
      And the cart fee summary is pending payment  

@orv2-1486-25, @orv2-2048-21
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

@orv2-1486-26, @orv2-2048-22
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

@orv2-1486-27, @orv2-2048-23
Rule: Show the number of pending permits

  Scenario: viewing pending permits list
    Given the user has pending permits
     When they choose to view the pending permits list
     Then they see the total number of pending permits

@orv2-1486-28, @orv2-2048-24
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

  Scenario: issuance fails for one or more but not all
   Given permit payment is successful for all ten items in the cart
     But permit issuance fails for two items
    When the CV Client receives the permit emails
    Then they see eight emails with one permit attached to each

  Scenario: issuance succeeds document generation fails
   Given all ten items in the cart are issued
     But permit issuance fails for two items
    When the CV Client receives the permit emails
    Then they see eight emails with one permit attached to each

  Scenario: multiple permits issued
    Given ten permits were issued
     When the CV Client receives the permit emails
     Then they see ten emails with one permit attached

@orv2-1486-31, @orv2-2048-27
Rule: Send one email per receipt

 Scenario: multiple permits issued
    Given ten permits were issued
     When the CV Client receives the permit receipt email
     Then they see one email with the receipt attached
      And the receipt contains purchase details for all ten permits purchased

  Scenario: one of many permits purchased in cart does not issue
    Given payment was successful for all permits in cart
     When one or more permits of many in cart do not issue
     Then they do not receive the receipt email

@orv2-1486-32, @orv2-2048-28
Rule: Only authorized users (CA, PA, SA, PC, CTPO, Trainee) can see the shopping cart icon

@orv2-1486-33, @orv2-2048-29
Rule: Shopping cart item count is refreshed when choosing to view the shopping cart or the browser is reloaded

# Rule: A permit, void permit or revoked permit is issued when permit number is generated

# Rule: A permit, void permit or revoked permit that fails issuance are pending permits

# Rule: A permit, void permit or revoked permit that is issued but fails permit document generation are active permits

  Scenario: email not sent docs available on onRouteBC
    Given 
     When 
     Then 

  Scenario: email sent docs not available on onRouteBC
    Given 
     When 
     Then 

  Scenario: email not sent docs not available on onRouteBC
    Given 
     When 
     Then 

# A permit or receipt pdf doesn't exist > generate > generate fails > unexpected error

# Rule: Permits is issued but fails permit receipt document generation are active permits

  Scenario: pdfs not generated
    Given permit financial transaction successful
     When user chooses to view permit
     Then they are directed to error page

# Rule: Staff see the cart icon only when acting as a company

  Scenario: CA and Staff at my applications
    Given CA and Staff at my applications
      And another user application in the cart has error
     When they pay now
     Then they see the error info box
      But the they do not see "Application error. Please remove it from the cart."




 # NOTE: This has not been implmented yet

      ## And they see the <list of applications> removed from the cart

  Scenario: edit item already removed from cart
    Given a user chooses to edit an application that is in the cart
     When a different user chooses to edit the same application
     Then the see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
      And they see the <list of applications> removed from the cart

  ## Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-876    |
     | • A2-00408617-878    |

  # Scenario: view cart
    Given items have been removed from the company cart
     When a user chooses to view the shopping cart
     Then they see "Your shopping cart has changed. Application(s) with errors or updates have been removed from your cart."
      And they see the <list of applications> removed from the cart

   # Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |

   # Scenario: pay
    Given items have been removed from the company cart
     When a user chooses to pay
     Then they see "Update Shopping Cart Some items in your shopping cart have changed. Click Update Cart to continue."
      And they see the <list of applications> removed from the cart

   # Examples:
     | list of applications |
     | • A2-00408617-873    |
     | • A2-00408617-873    |
     | • A2-00408617-873    |