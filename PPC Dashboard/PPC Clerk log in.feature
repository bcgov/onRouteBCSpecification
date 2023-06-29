Feature: PPC Clerk log into onRouteBC
    As a PPC Clerk I need to log into onRouteBC using my IDIR credentials, so that I can complete tasks in the system I am authorized to do.

@orv2-945-1
  Scenario: Log in using IDIR
    Given a PPC Clerk has valid IDIR credentials
     When they log into onRouteBC using their IDIR credentials
     Then their IDIR information is stored in onRoute:
        | idir_user_guid |
        | idir_username  |
        | name           |
        | email          |
     And they are directed to the "global search page"
  
@orv2-945-2
  Scenario: Log in using IDIR invalid credentials
    Given a PPC Clerk has invalid IDIR credentials
     When they log into onRouteBC using their IDIR credentials
     Then they see "The username or password you entered is incorrect"

@orv2-945-3
  Scenario: Update IDIR information in onRouteBC
      Given a PPC Clerk has valid IDIR credentials
       When they log into onRouteBC using their IDIR credentials
       Then their IDIR information is updated in onRoute:
          | idir_user_guid |
          | idir_username  |
          | name           |
          | email          |

@orv2-945-4
  Scenario: Log in using valid IDIR invalid onRouteBC credentials
    Given a PPC Clerk attempts to log into onRouteBC
     When they log into onRouteBC using their IDIR credentials
     Then they see "Universal Unauthorized Error" Page