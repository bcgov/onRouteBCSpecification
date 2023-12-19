Feature: Common features for profile creation workflows

Rule: The navigation bar is not visible to CV Clients until the profile has been successfully claimed

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following steps:
       | steps |
       | welcome to onroutebc - claim profile or not choice |
       | verify profile | 
       | company information |
       | my information |
     Then the navigation bar is not visible

Rule: a new user must complete their "My Information"

  Scenario: Mandatory fields
    Given a CV Client chooses to proceed to "My Information"
     When they do not input valid data into any of the following mandatory fields:
        | field            | type         |
        | First Name       | User Details |
        | Last name        | User Details |
        | Email            | User Details |
        | Primary Phone    | User Details |
        | Country          | User Details |
        | Province / State | User Details |
        | City             | User Details |
     Then they see "This is a required field" at each field with invalid data
      And fields with invalid data are indicated