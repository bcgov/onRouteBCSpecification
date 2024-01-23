Feature: Fixed (static) Main Header
  As a user I want to be able to see the onRouteBC web app main header at all times.

@orv2-1025-0
Rule: Main header is visible when page is scrolled

  Scenario: Scroll page
    Given a user is on any page in the onRouteBC web app
     When they scroll the page
     Then the main header remains at the top of the page

