Feature: Send permit and receipt documents
    As a CV Client I want to receive copies of my purchased permit(s) and receipts(s) to the email and fax(s) recorded in the permit application as well as the associated company email.

  Scenario: Send permit and receipt to email
    Given the CV Client has completed payment
     When they have successfully completed payment 
     Then their generated permit PDF and receipt PDF are emailed to:
       | company email address |
       | contact email address |


  Scenario: Send permit and receipt to fax number
    Given the CV Client has entered a fax number
     When they successfully completed payment
     Then their generated permit PDF and receipt PDF are faxed to the contact fax number


