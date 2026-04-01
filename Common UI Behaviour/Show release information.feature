Feature: Show release information

Users = CA, PA, SA, PC, CTPO, Trainee, EO, HQA

@orv2-2328-1
Rule: the onRouteBC version number is always visible to all users

  Scenario: At home page
     When user is at Welcome to onRouteBC!
     Then they see the current release version number

@orv2-2328-2
Rule: Always in the same relative screen position

  Scenario: Scrolling the page
    Given users are on any page
      And the page requires scrolling to view all information desired
     When they scroll the page down or up
     Then the current release version number remains visible in the same position