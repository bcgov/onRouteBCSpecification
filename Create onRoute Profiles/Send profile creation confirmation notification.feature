Feature: Send onRouteBC profile creation confirmation email
  As as CV Client I want to receive a confirmation email after successfully completing the required steps and creating my onRouteBC profile so that I can have a reference of this activity.

@orv2-477-1 @orv2-1521-7
Rule: Send confirmation email to CV Client upon successful profile creation

 Scenario: Send email when onRoute profile workflow is completed
      Given the user has completed the onRouteBC profile workflow
      When they are directed to the "success" page
      Then they receive a confirmation email to their company email and primary contact email address

 Scenario: View onRouteBC profile creation confirmation email
     Given the user has received the "confirmation email"
     When they view its contents
     Then they see <confirmation details>

    Examples: 
      | confirmation details           | 
      | Company Legal Name             | 
      | onRouteBC Profile Number       | 
      | Link to onRouteBC Webapp       | 
      | PPC Support Contact Phone      | 
      | PPC Support Contact Email      | 
      | Terms and Conditions Statement |   