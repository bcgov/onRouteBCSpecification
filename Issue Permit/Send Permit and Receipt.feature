Feature: Send issued permit and receipt documents
    As a CV Client I want to receive copies of my permit(s) and receipts(s) to the email entered in the permit application as well as the associated onRouteBC profile company email when a permit is purchased amended, voided and revoked.

@orv2-936-1 @orv2-4015-23
Rule: Email issued permit pdf and permit receipt

  Scenario: Email permit pdf successful
    Given the CV Client has initiated payment
     When they have successfully completed payment 
     Then their  permit PDF ia emailed as an attachment to:
       | company contact email address |
       | entered contact email address |
      And the CV Client cannot reply to the email

  Scenario: Email permit payment receipt successful
    Given the CV Client has initiated payment
     When they have successfully completed payment 
     Then their  permit payment receipt PDF is emailed as an attachment to:
       | company contact email address |
       | entered contact email address |
      And the CV Client cannot reply to the email 

@orv2-936-3
  Scenario: Send email from...
    Given the CV Client has successfully completed payment
     When 
     Then 



