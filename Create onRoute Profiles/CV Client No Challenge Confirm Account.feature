Feature: CV Client no challenge confirm TPS Account
   As a CV Client with an existing TPS account and users I want to be able to log into onRouteBC and complete my onRouteBC profile.

@orv2-1637-1
Rule: When a user GUID matches a company BCeID GUID in onRouteBC and they are not the first user, they can join an existing company profile.

  Scenario: not the first user
     Given the users GUID matches a company BCeID GUID in onRouteBC
       And the company has existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the company profile that matches their user GUID
       And they see the option to finish creating their profile
        
@orv2-1637-2
Rule: If a user GUID matches a company BCeID GUID in onRouteBC a first user can try to claim an existing profile

  Scenario: first user matches
     Given the users GUID matches a company BCeID GUID in onRouteBC
       And the company does not have any existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the company profile that matches their user GUID
       And they see the option to finish creating their profile

