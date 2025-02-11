Feature Staff shopping cart
  As Staff I need to be able to purchase more than one permit at once, so that I can save time.

Staff = SA, PC, CTPO, Trainee

@orv2-2048-1
Rule: Staff can see all CA, PA and Staff items in the cart

@orv2-2048-2
Rule: Staff see total of number of all CA, PA and Staff items in the cart

@orv2-2048-3
Rule: Staff can see of total of all CA, PA and Staff item count in the cart in the header

  Scenario: Staff have not items in cart
    Given the CV Client has 10 items in the cart
    When they log into onRouteBC         
     Then the shopping cart count is 10

@orv2-2048-4
Rule: Staff can filter cart items by their items or all CA, PA and Staff items

  Scenario: filter by my applications
    Given the logged in staff has items in the cart
     When they choose to view my applications
     Then they see only applications started by the logged in staff user

  Scenario: filter by all applications
    Given the CV Client has items in the cart
     When the logged staff user chooses to view all applications
     Then they see all applications started by the logged in staff user 
      And those started by other CA, PA and Staff users added to the cart

@orv2-3176-6
Rule: Staff can pay for a permit application with a start date in the past
 
  Scenario: date in past pay 
    Given staff see "Your shopping cart cannot be completed. The shopping cart contains Application(s) with one or more errors. Those applications must be deselected or removed from the cart to proceed with payment. Common errors include, but are not limited to, start date is in the past or an invalid vehicle."
      And they see "Invalid Application" at the invalid application(s)
     When they choose to pay
     Then they can pay