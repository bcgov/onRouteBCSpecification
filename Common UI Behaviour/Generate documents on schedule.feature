Feature: Generate documents on schedule

@orv2-2416-1
Rule: If there is no permit or receipt PDF available, display an error page.

  Scenario: view pdf
    Given the pdf does not exist
     When a user chooses to view the pdf 
     Then they see "Your document is on the way Your document is being created. Please check again later." in a new browser tab
    
  Scenario: resend pdf
    Given the pdf does not exist
     When a user chooses to resend a pdf
     Then they see "Your document is on the way Your document is being created. Please check again later." in a new browser tab

@orv2-3072-1
Rule: The permit payment receipt is generated only when all permits in a single transaction are issued

  Scenario: 10 purchased 7 issued remaining issued
    Given 10 permits are purchased
      But 7 are issued
     When the remaining 3 are issued
     Then the permit payment receipt is generated

  Scenario: 10 purchased 7 issued
    Given 10 permits are purchased
      But 7 are issued
     When the remaining 3 are pending permits
     Then the permit payment receipt is not generated


