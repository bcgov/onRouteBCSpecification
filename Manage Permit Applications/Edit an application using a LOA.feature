@tagPlaceholder1 @tagPlaceholder2
Feature: Edit an application using an LOA

Rule: Vehicle details are removed from an LOA permit application when the LOA vehicle type and sub-type used in the LOA Permit is removed and the vehicle is not allowed for the permit type

  Scenario: 
    Given 
     When 
     Then 

Rule: Expired LOA(s) are shown but unavailable in LOA permit application

  Scenario: 
    Given 
     When 
     Then 

Rule: LOA permit applications using expired LOA have allowable permit duration available for their permit type

  Scenario: term permit
    Given LOA permit application A is a term permit
      And it uses expired LOA 1
     When staff amend LOA permit application A
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