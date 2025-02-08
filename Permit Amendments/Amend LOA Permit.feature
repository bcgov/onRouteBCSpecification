Feature: Amend LOA Permit
As staff I need to be able to amend an issued or active permit that uses an LOA(s), so that I can assist CV Clients with these types of permits.

Staff = SA, PC, CTPO, Trainee

@orv2-2860-1
Rule: Vehicle details are removed from an amending LOA permit when the LOA vehicle used in the LOA Permit is removed and the vehicle is not allowed for the permit type

  Scenario: 2 LOA(s) 1 VIN
    Given permit A uses LOA B and LOA C
      And permit A uses vehicle D from LOA B
      And vehicle D has been removed from LOA B
      And vehicle D is not allowed for the permit A permit type
     When staff amend permit A
     Then vehicle D is removed

@orv2-2860-2
Rule: Expired LOA(s) are shown but unavailable in LOA amending permits
  
  Scenario: available LOA(s)
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then they see:
       | LOA B number      |
       | LOA B expiry date |
      And LOA B is unavailable

 # we will need to figure out how to handle this over time do we keep showing expired LOAs for ever or...

@orv2-2860-3
Rule: LOA permits using expired LOA(s) have allowable permit duration available for their permit type

  Scenario: term permit
    Given LOA permit A is a term permit
      And it uses expired LOA B
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
