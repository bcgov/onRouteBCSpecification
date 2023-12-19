Feature: No challenge confirm existing onRouteBC profile
   As a CV Client with an existing onRouteBC profile I want to be able to log into onRouteBC and complete my onRouteBC profile.

@orv2-1637-1
Rule: A user can join their matching onRouteBC company profile as an admin

  Scenario: credentials match, not the first user
     Given the users credentials matches a company in onRouteBC
       And the company has existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the company profile that matches their user credentials
       And they see the option to finish creating their profile

  Scenario: user credentials do not match an existing onRouteBC profile
     Given the users credentials do not match a company in onRouteBC
       And they have not been invited
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the following:
         | item                                                                        | description                                       |
         | BCeID Company Name                                                          | that matches their BCeID user credentials         |
         | Has this company purchased a commercial vehicle permit in the last 7 years? | call to actions to claim or not claim the profile |
       And they have the option to try to claim the profile or not claim it
        
@orv2-1637-2
Rule: A user can claim an existing onRouteBC profile if they are the first user

  Scenario: first user,credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does not have any existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the company profile that matches their credentials
       And they see the option to finish creating their profile

  Scenario: not the first user, credentials match existing onRouteBC profile
     Given the users credentials matches a company in onRouteBC
       And the company does not have any existing users
      When they successfully log in using their BCeID credentials
      Then they are directed to the "Welcome to onRouteBC" page
       And they see the company name for the company profile that matches their credentials
       And they see the option to finish creating their profile

       

