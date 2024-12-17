Rule: All chosen LOA(s) used in a permit application must be valid on pay now

  Scenario: reduce LOA(s) term
    Given user has permit A in cart
     And permit A uses LOA(s) B
     When permit A exceeds the LOA(s) B end date
     Then they see ""
      And they see "Application error. Please remove it from the cart."

  Scenario: LOA(s) edited to remove permit type vehicles and date still valid
    Given user has permit A in cart
      And permit A uses LOA(s) B
      And LOA(s) B uses vehicle 1
      And vehicle 1 is removed from LOA(s) B
     When they pay now
     Then they see ""
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

  Scenario
    Given the cart was paid by user 2
      And user 1 is at the cart
      And app A is in the cart
     When user 1 pays for the cart
     Then user 1 sees error at app A

NR Licensing 
	- Farm tractor fee trip for quarterly or single trip
		- in hindsight we could just omit farm tractor as eligible for one of these types
	
default state on vehicle weight Loaded GVW, net greyed greyed out
	
default state for conditional is all options shown but greyed out default to none
		- show options based on scenarios below
	
 Rule: vehicle sub-type controls available options for conditional license fees and vehicle weight

   Scenario: 
     Given 
      When 
      Then 
 
   Examples:
     | vehicle sub-type | CLF | VW | Fee Table |
     | scraper | Industrial (X-Plate Type) | Loaded GVW | Industrial |
     | truck tractor | Conditional License | Loaded GVW | Conditional License |
     | truck tractor | Farm Vehicle | Net Weight | Farm Vehicles |
     | logging trucks | Conditional License | Loaded GVW | Conditional License |
     | logging trucks | None | Loaded GVW | Commercial Vehicles |
     | farm tractors | Farm Vehicles | Not Available | Farm Vehicles |

 - scraper none
		- None
		- loaded gvw available
  - commericla fee table
	
 - scraper x-plate
		- x-plate
		- loaded gvw
  - x-plate fee table
	
 - truck tractor none
		- none
		- loaded gvw
	
 - truck tractor farm vehicle
		- farm vehicle
		- net weight
	
 - farm tractor
		- Farm Tractor default selected by default
		- both weight boxes greyed out
	
 - Farm Tractor will need to be added as a new vehicle sub-type
	
 - Fees
		- Farm Tractor - flat rate 33

	- NicoleH - propose allow it but make it feature flaggable or just hide the option

- Farm vehicle max weight and other vehicle expected behaviour when over max
	- charge the maximum weight charge of the table