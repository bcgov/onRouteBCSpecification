Feature: CV Client shopping cart
  As a CV Client CA or PA I need to be able to purchase more than one permit at once, so that I can save time.

CV Client = CA, PA

@orv2-1486-1
Rule: CV Client can't see staff items in the shopping cart

  Scenario: Staff have items in cart
    Given the CV Client does not have items in the cart
    When they arrive at the cart          
     Then they see "nothing found"

@orv2-1486-2
Rule: CA see total of number of all company CA, PA items in the cart

@orv2-1486-3
Rule: PA see only their application number of items in the cart

@orv2-1486-4
Rule: CA can see total of all CA and PA shopping cart item count in the header

   Scenario: Staff have 10 items in cart
    Given the CV Client has 0 items in the cart
    When they log into onRouteBC         
     Then the shopping cart count is 0

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have a total of 10 items in the cart
     When the CA logs into onRouteBC
     Then the shopping cart count is 10

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have 10 items in the cart
     When the CA logs into onRouteBC
     Then the shopping cart count is 10

@orv2-1486-5
Rule: PA can see only their cart item count in the header

@orv2-1486-6
Rule: CA can see all company CA and PA items in the cart

  Scenario: CA and PA has items in the cart
    Given the CA and other company CA and PA have items in the cart
     When they view the shopping cart
     Then they see all company items in the cart including theirs

  Scenario: Logged in CA has no items in the cart
    Given other company CA and PA have items in the cart
     When the CA logs into onRouteBC
     Then they see all company items in the cart

@orv2-1486-7
Rule: PA can only see their items in the cart

  Scenario: 
    Given 
     When 
     Then 


@orv2-1486-8
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


