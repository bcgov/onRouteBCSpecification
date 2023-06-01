Feature: Send permit and receipt documents
    As a CV Client I want to receive copies of my purchased permit(s) and receipts(s) to the email and fax(s) entered in the permit application as well as the associated onRouteBC profile company email.

@orv2-936-1
  Scenario: Send permit and receipt to email
    Given the CV Client has completed payment
     When they have successfully completed payment 
     Then their generated permit PDF and receipt PDF are emailed as attachments to:
       | company profile email address |
       | entered contact email address |

@orv2-936-2
  Scenario: Send permit and receipt to fax number
    Given the CV Client has entered a fax number
     When they successfully completed payment
     Then their generated permit PDF and receipt PDF are faxed to the contact fax number


