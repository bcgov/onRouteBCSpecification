Feature: View generated permit
   As a CV Client I want to be able to view the legal permit pdf that is generated based on my permit application submission after successful purchase, so that I can travel.

@orv2-766-1
  Scenario: View generated permit
    Given the CV Client has successuly purchased a permit
      And they are at the "Success" page
     When they choose to view the permit
     Then the generated permit pdf is displayed
      And the CVSE Forms chosen in the permit application are attached
      
Add naming rule

Feature: View generated permit payment receipt
   As a CV Client I want to be able to view the permit payment receipt pdf that is generated based on my permit application submission after successful purchase, so that I can manage my onRouteBC accounting.

@orv2-935-1
  Scenario: View generated permit payment receipt
    Given the CV Client has successuly purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated permit payment receipt pdf is displayed

Add naming rule