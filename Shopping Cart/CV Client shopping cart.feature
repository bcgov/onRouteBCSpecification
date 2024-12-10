Feature: CV Client shopping cart
  As a CV Client CA or PA I need to be able to purchase more than one permit at once, so that I can save time.

CV Client = CA, PA
Staff = SA, PC, CTPO, Trainee

@orv2-1486-1
Rule: CA can see all company CA, PA and Staff items in the cart
 
  Scenario: Staff created items in cart
    Given the CA does not have items in the cart
     When they arrive at the cart          
     Then they see staff created items

  Scenario: Staff edited items in cart
    Given staff edited CV Client started permit application
     When CA arrive at the cart          
     Then they see staff edited items

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have items in the cart
     When they view the shopping cart
     Then they see all company items in the cart including theirs

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have items in the cart
     When the CA logs into onRouteBC
     Then they see all company items in the cart

@orv2-1486-2
Rule: CA can't edit staff created items in the shopping cart

  Scenario: staff edited permit applications
    Given staff have edited a CV Client staretd permit application
     When CA chooses to edit the permit application
     Then they see "View/Edit Application Viewing or editing a permit application that's in the cart will remove it from your cart. You will have to re-add it to your cart."

  Scenario: Staff created items in cart
     When CA choose to edit a staff created permit application     
     Then they do not have the option to edit it

@orv2-1486-3
Rule: CA can pay for staff created items in the shopping cart

  Scenario: 
    Given 
     When 
     Then 

@orv2-1486-4
Rule: CA can pay for staff edited CA or PA items in the shopping cart

@orv2-1486-5
Rule: CA can see the total of number of all company CA, PA and Staff items in the cart

@orv2-1486-6
Rule: CA can see total of all CA, PA and Staff shopping cart item count in the header

   Scenario: Staff have 10 items in cart
    Given the CV Client has 0 items in the cart
    When they log into onRouteBC         
     Then the shopping cart count is 10

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have a total of 10 items in the cart
     When the CA logs into onRouteBC
     Then the shopping cart count is 10

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have 10 items in the cart
     When the CA logs into onRouteBC
     Then the shopping cart count is 10

@orv2-1486-7
Rule: CA can filter cart by their items or all company CA, PA and Staff items

  Scenario: filter by my applications
    Given the logged in CA has items in the cart
     When they choose to view my applications
     Then they see only applications started by the logged in CA user

  Scenario: filter by all applications
    Given the CV Client has items in the cart
     When the logged in CA user chooses to view all applications
     Then they see all applications started by the logged in CA user 
      And those started by other CA, PA and Staff added to the cart

@orv2-1486-8
Rule: PA can see only their application number of items in the cart

@orv2-1486-9
Rule: PA can pay for staff edited PA items in the shopping cart

@orv2-1486-10
Rule: PA can see only see their cart item count in the header

@orv2-1486-11
Rule: PA can only see their items in the cart




