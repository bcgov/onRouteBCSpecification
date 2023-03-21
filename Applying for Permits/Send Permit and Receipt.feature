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

  Scenario:Permit receipt is generated
    Given the CV client has completed payment
    When they have successfuly completed payment
    Then a PDF receipt is generated with the following information:
          | Issued by: |Either "Provincal Permit Centre" (IDIR was use to create the permit) or "onRouteBC" (all other log in types outside of IDIR was used to create permit)
          | Transaction ID | provided by paybc
          | Recieved on behlad of | Business account name          
          | Payment Method | provided by paybc
          | Transaction Date| provided by paybc
          | Permit Decription | Full name of the permit
          | Permit Number | unique permit number
          | Amount Paid | CND dollar amount
