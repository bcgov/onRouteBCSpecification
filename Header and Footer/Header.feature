Feature: Header

Rule: A user can navigate to their unique home page 

  Scenario: CV Client
    Given a CV Client is logged in
     When they choose to go home
     Then they are directed to their permits page applications in progress tab

  Scenario: Staff
    Given a staff user is logged in
     When they choose to go home
     Then they are directed the staff home page Welcome to onRouteBC!

  Scenario: Enforcement Officer
    Given an EO is logged in
     When they choose to go home
     Then they are directed the staff home page Welcome to onRouteBC!

