Feature: View generated permit
   As a CV Client I want to be able to view the legal permit pdf that is generated based on my permit application submission after successful purchase, so that I can travel.

@orv2-766-1
Rule: Generate permit pdf after successful payment
 
  Scenario: View generated permit
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit
     Then the generated permit pdf is displayed
      And the CVSE Forms chosen in the permit application are attached

 @over2-757-1
  Scenario: Generation fails
    Given a user payment completes successfully
     When the documents fails to generate pdf files
     Then they see the universal error page that includes this information:
       | information   | content             |
       | error message | unexpected error    |
       | link          | return to onRouteBC |
      And they can optionally navigate to the onRouteBC home page

@orv2-1065-1   
Rule: Save permit pdf using the generated permit payment receipt number as the filename

  Scenario: View permit pdf filename
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit  
     Then the generated permit payment pdf is displayed
      And the <file name> is the <permit number>

      Examples:
         | permit number   | file name           |
         | P1-82364275-175 | P1-82364275-175.pdf |
         | P1-82364279-203 | P1-82364279-203.pdf |
         | P2-82364280-389 | P2-82364280-389.pdf |