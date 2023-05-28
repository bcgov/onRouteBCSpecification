Feature: View generated permit
   As a CV Client I want to be able to view the legal permit pdf that is generated based on my permit application submission after successful purchase.

@orv2-766-1
  Scenario: View generated permit
    Given the CV Client has successuly purchased a permit
      And they are at the "Success" page
     When they choose to view the permit 
     Then then the generated permit pdf is displayed

@orv2-766-2
  Scenario: View generated permit unsuccessful payment
    Given the CV Client has not completed a successful payment
     When they choose to view the permit 
     Then then the generated permit pdf is displayed

Feature: View generated permit payment receipt
   As a CV Client I want to be able to view the permit payment receipt pdf that is generated based on my permit application submission after successful purchase.

@orv2-935-1
  Scenario: View generated permit payment receipt
    Given the CV Client has successuly purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then then the generated permit payment receipt pdf is displayed

