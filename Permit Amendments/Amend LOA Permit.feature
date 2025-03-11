Feature: Amend LOA Permit
As staff I need to be able to amend an issued or active permit that uses an LOA(s), so that I can assist CV Clients with these types of permits.

Staff = SA, PC, CTPO, Trainee

@orv2-2860-1
Rule: Vehicle details are removed from an LOA amending permit when the LOA is unchosen, deleted or expired and the vehicle type and sub-type is not allowed for the permit type

  Scenario: LOA unchosen
    Given a user has chosen an LOA A
      And there are vehicle details
     When they choose LOA B
     Then vehicle details are removed
      And the vehicle type and sub-type designated in the LOA B are chosen

  Scenario: LOA deleted
      Given permit 1 has LOA A designated
       When a user chooses to amend permit 1
       Then all vehicle details are removed

  Scenario: LOA expired
      Given permit 1 has LOA A designated
       When a user chooses to amend permit 1
       Then all vehicle details are removed
|
@orv2-2860-2
Rule: Vehicle details are removed from an LOA amending permit when the vehicle type and sub-type are changed on the designated LOA and the vehicle type and sub-type is not allowed for the permit type
|
@orv2-2860-3
Rule: Expired LOA(s) are shown but unavailable in LOA amending permits
  
  Scenario: available LOA(s)
    Given permit A uses LOA 1
     When LOA 1 expires
      And staff amend permit A
     Then they see:
       | LOA 1 number      |
       | LOA 1 expiry date |
      And LOA 1 is unavailable

 # we will need to figure out how to handle this over time do we keep showing expired LOAs forever or...
|
@orv2-2860-4
Rule: LOA amending permits using expired LOA(s) have allowable permit duration available for their permit type

  Scenario: term permit
    Given LOA permit A is a term permit
      And it uses expired LOA 1
     When staff amend LOA permit A
     Then they see the following permit duration options:
       | term |
       | 30   |
       | 60   |
       | 90   |
       | 120  |
       | 150  |
       | 180  |
       | 210  |
       | 240  |
       | 270  |
       | 300  |
       | 330  |
       | 1y   |
|
@orv2-2860-5
Rule: LOA amending permits are limited by LOA term when the LOA is active

  Scenario: LOA term shortened/expires before permit
    Given LOA A is used on permit 1
      And LOA A expiry date is 03/01/2025
      And permit 1 expiry is 02/28/2025
      And staff change LOA A expiry to 01/30/2025
     When staff amend permit 1
     Then permit 1 vehicle details are removed
      And LOA A is not available

   Scenario: LOA term lengthened
    Given LOA A is used on permit 1
      And LOA A expiry date is 03/01/2025
      And permit 1 expiry is 03/01/2025
      And staff change LOA A expiry to 04/30/2025
     When staff amend permit 1
     Then permit 1 expiry is 03/01/2025
      And LOA A remains chosen

  Scenario: LOA start date in future
    Given LOA A is used on permit 1
      And LOA A start date is 02/01/2025
      And LOA A is not expired
      And permit 1 start date is 02/28/2025
      And staff change LOA A start to 04/30/2025
     When staff amend permit 1
     Then permit 1 vehicle details are removed
      And LOA A is not available

  Scenario: LOA start date in past
    Given LOA A is used on permit 1
      And LOA A start date is 03/01/2025
      And LOA A is not expired
      And permit 1 start date is 03/01/2025
      And staff change LOA A start to 02/01/2025
     When staff amend permit 1
     Then permit 1 start date is 03/01/2025
      And LOA A remains chosen