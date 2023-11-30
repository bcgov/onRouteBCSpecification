Feature: View generated permit payment receipt
   As a CV Client I want to be able to view the permit payment receipt pdf that is generated based on my permit application submission after successful purchase, so that I can manage my onRouteBC accounting.

@orv2-935-1
  Scenario: View generated permit payment receipt
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated permit payment receipt pdf is displayed

@over2-935-2
  Scenario: Generation fails
    Given a user payment completes successfully
     When the documents fails to generate
     Then they see the universal unexpected error page that includes this information:
       | information   | content             |
       | error message | unexpected error    |
       | link          | return to onRouteBC |
      And they can optionally navigate to the onRouteBC home page