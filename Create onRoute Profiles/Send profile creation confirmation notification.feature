Feature: Send onRouteBC profile creation confirmation email
  As as new or first claimant user I want to receive a confirmation email after successfully completing the required steps and creating my onRouteBC profile so that I can have a reference of this activity.

User = new user, first claimant, staff

@orv2-477-1 @orv2-1521-7, @orv2-3322-21, @orv2-3228
Rule: Send confirmation email to user upon successful profile creation

 Scenario: Send email when onRoute profile workflow is completed
      Given the user has completed the onRouteBC profile workflow
      When they are directed to the "success" page
      Then a confirmation email to the company email and primary contact email address

 Scenario: View onRouteBC profile creation confirmation email
     Given the user has received the "confirmation email"
     When they view its contents
     Then they see the following:
      | confirmation details           |
      | Company Legal Name             |
      | onRouteBC Profile Number       |
      | Company Contact Address        |
      | Company Contact Details        |
      | Company Primary Contact        |
      | Link to onRouteBC Webapp       |
      | PPC Support Contact Phone      |
      | PPC Support Contact Email      |
      | Terms and Conditions Statement |