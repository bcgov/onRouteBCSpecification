Feature: Amend LOA Permit

Staff = SA, PC, CTPO, Trainee

Rule: Vehicle details are removed from an amending LOA permit when the LOA vehicle used in the LOA Permit is removed

# is this possible? Is this possible for dates as well?
  Scenario: 2 LOA(s) 1 VIN
    Given permit A uses LOA B and LOA C
      And permit A uses vehicle D from LOA B
      And vehicle D has been removed from LOA B
     When staff amend permit A
     Then vehicle D is removed

Rule: Expired LOA(s) are shown but unavailable in LOA amending permits
  
  Scenario: available LOA(s)
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then they see:
       | LOA B number      |
       | LOA B expiry date |
      And LOA B is unavailable

Rule: LOA permits using expired LOA(s) have allowable permit duration availble for their permit type

  Scenario: term permit
    Given LOA permit A is a term permit
      And it uses expired LOA B
     When staff amend LOA permit a
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



