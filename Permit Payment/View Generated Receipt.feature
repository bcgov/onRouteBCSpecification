Feature: View generated financial transaction receipt

@orv2-935-1 @orv2-1064-1
Rule: A successful financial transaction initiates the generation of a permit receipt

  Scenario: client purchase
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated receipt pdf is displayed


  Scenario: staff refund
    Given staff have successfully completed a refund
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated receipt pdf is displayed

@over2-935-2 @orv2-1064-2
Rule: If receipt fails to generate then show the universal unexpected error page in a new tab

  Scenario: purchase transaction successful
    Given a user payment completes successfully
     When the documents fails to generate
     Then user sees the universal unexpected error page that includes this information:
       | information   | content             |
       | error message | unexpected error    |
       | link          | return to onRouteBC |
      And they can optionally navigate to the onRouteBC home page

  Scenario: refund transaction successful
    Given refund transaction completes successfully
     When the documents fails to generate
     Then user sees the universal unexpected error page that includes this information:
       | information   | content             |
       | error message | unexpected error    |
       | link          | return to onRouteBC |
      And they can optionally navigate to the onRouteBC home page

@over2-935-3 @orv2-1064-3
Rule: Receipt show variable data fields specific to the financial transaction
# see the Payment Receipt Template (Data) V1.0 template and the data discovery sheet
      
      