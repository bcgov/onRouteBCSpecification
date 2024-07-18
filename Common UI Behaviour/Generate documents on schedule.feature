Feature: Generate documents on schedule

@orv2-2416-1
Rule: If there is no PDF available, display an error page.

  Scenario: no pdf
     When a user chooses to view the pdf 
     Then they see "Your document is on the way Your document is being created. Please check again later."