Feature: Log in or out of onRouteBC

User = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA
CV Client = CA, PA
Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA

@orv2-698 @orv2-3135-1
Rule: Users are directed to the log in screen when they choose to log out of the onRouteBC webapp

  Scenario: user logs out
    Given a user chooses to logout of onRouteBC
     When they initiate the logout
     Then they are logged out of onRouteBC
      And they are directed to the onRouteBC log in page

@orv2-369-8 @orv-672-3 @orv2-944 @orv2-3135-2
Rule: Users are directed to their unique onRouteBC webapp home page after logging in

  Scenario: cv client no profile
    Given they have valid BCeID credentials
      And the CV Client onRouteBC Profile does not exist
     When they log in successfully using their BCeID credentials 
     Then they are directed to the Welcome to onRouteBC page
      And they see their BCeID Company Legal Name

  Scenario: cv client profile exists
    Given the CV Client onRouteBC Profile exists
     When they log in successfully using their BCeID credentials 
     Then they are directed to the Permits page Applications in Progress tab

  Scenario: staff valid credentials
    Given staff has valid IDIR credentials
      And an onRouteBC profile
     When they log into onRouteBC using their IDIR credentials
     Then their IDIR information is stored in onRoute:
        | idir_user_guid |
        | idir_username  |
        | name           |
        | email          |
      And they are directed to the staff home screen
      And they see the global navigation bar (sticky side bar)


  Scenario: PC, SA, TRAIN, CTPO profile and valid IDIR
    Given PC, SA, TRAIN, CTPO have valid IDIR credentials
      And an onRouteBC profile 
     When they log into onRouteBC using their IDIR credentials
     Then they are directed to the staff home screen applications in progress tab

  Scenario: staff has onRouteBC profile invalid IDIR
    Given staff has an onRouteBC profile
      But staff has invalid IDIR credentials
     When they log into onRouteBC using their IDIR credentials
     Then they see "The username or password you entered is incorrect"

  Scenario: staff no onRouteBC profile
    Given staff does not have an onRouteBC profile
     When they log into onRouteBC using their IDIR credentials
     Then they see "Universal Unauthorized Error" Page