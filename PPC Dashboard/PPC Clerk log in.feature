Feature: PPC Clerk log into onRouteBC
    As a PPC Clerk I need to log into onRouteBC using my IDIR credentials, so that I can complete tasks in the system I am authorized to do.

@orv2-945-1
  Scenario: Log in using IDIR
    Given a PPC Clerk has valid IDIR credentials
     When they log into onRouteBC using their IDIR credentials
     Then they are directed to the global search page
