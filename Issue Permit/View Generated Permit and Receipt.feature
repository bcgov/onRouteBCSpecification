Feature: View generated permit
   As a CV Client I want to be able to view the legal permit pdf that is generated based on my permit application submission after successful purchase, so that I can travel.

@orv2-766-1
  Scenario: View generated permit
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit
     Then the generated permit pdf is displayed
      And the CVSE Forms chosen in the permit application are attached
      
Rule: Save permit pdf using the generated permit payment receipt number as the filename

@orv2-1065-1
  Scenario: View permit pdf
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

Feature: View generated permit payment receipt
   As a CV Client I want to be able to view the permit payment receipt pdf that is generated based on my permit application submission after successful purchase, so that I can manage my onRouteBC accounting.

@orv2-935-1
  Scenario: View generated permit payment receipt
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated permit payment receipt pdf is displayed