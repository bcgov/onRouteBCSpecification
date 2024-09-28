Feature: Amend LOA Permit

Staff = SA, PC, CTPO, Trainee

Rule: Vehicle details are removed from an amending LOA permit when the LOA vehicle is removed from the LOA used in the LOA permit

  Scenario: 
    Given 
     When 
     Then

Rule: Expired LOA(s) are shown but unavailable in LOA amending permits
  
  Scenario: available LOA(s)
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then they see:
       | LOA B number      |
       | LOA B expiry date |
      And it is unavailable

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










  Scenario: available LOA(s)
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then they see LOA B and it is unavailable

  Scenario: vehicle information
    Given permit A uses LOA B
     When LOA B expires
      And staff amend permit A
     Then there are no vehicle details


