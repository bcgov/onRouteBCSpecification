Feature: Send permit and receipt documents
    As a CV Client I want to receive copies of my purchased permit(s) and receipts(s) to the email and fax(s) entered in the permit application as well as the associated onRouteBC profile company email.

@orv2-936-1
Rule: Email permit pdf and permit receipt

  Scenario: Email permit pdf successful
    Given the CV Client has initiated payment
     When they have successfully completed payment 
     Then their generated permit PDF ia emailed as an attachment to:
       | company contact email address |
       | entered contact email address |
      And the CV Client cannot reply to the email

  Scenario: Email permit payment receipt successful
    Given the CV Client has initiated payment
     When they have successfully completed payment 
     Then their generated permit payment receipt PDF is emailed as an attachment to:
       | company contact email address |
       | entered contact email address |
      And the CV Client cannot reply to the email 

  Scenario: 
    Given 
     When 
     Then 


@orv2-936-2
  Scenario: Send permit and receipt to fax number
    Given the CV Client has entered a fax number
     When they successfully completed payment
     Then their generated permit PDF and receipt PDF are faxed to the contact fax number

@orv2-936-3
  Scenario: Send email from...
    Given the CV Client has successfully completed payment
     When 
     Then 



