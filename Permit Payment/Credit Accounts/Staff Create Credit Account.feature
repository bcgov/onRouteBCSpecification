Feature: Staff create credit accounts
  As a FIN staff member I need to be able to create credit accounts for CV Clients so that CV Clients can purchase permits using credit provided by MOTI.

Staff = FIN

@orv2-1868-1
Rule: Staff can create a credit account for a CV Client

  Scenario: no credit account
     When staff choose to create a credit account for a cv client
     Then the see the option to add a credit account

@orv2-1868-2
Rule: Staff must choose from a list of credit account limits

  Scenario: limit not chosen
    Given a limit is not chosen
     When staff add the credit account
     Then they see "This is a required field"
      And they cannot add the credit account

  Scenario: choose 500
    Given staff has chosen a $500.00 credit limit
     When they add the credit account
     Then they are directed to credit account

@orv2-1868-3
Rule: Show credit account add notification

  Scenario: credit account created
     When create the credit account
     Then they are directed to credit account
      And they see "Credit Account Added" notification

@orv2-1868-4
Rule: Show onRouteBC generated unique credit account number

  Scenario: new credit account
    Given the cv client did not have a credit account 
     When staff create the credit account
     Then they see the onRouteBC generate unique credit account number as follows:
       | data | description                                 |
       | WS   | prefix                                      |
       | 0000 | four digit numerical ranging from 0000-9999 |

@orv2-1868-5
Rule: Show credit account designation

  Scenario: account holder
    Given a cv client has a credit account
     When staff are at credit account
     Then they see the designation "Account Holder"

@orv2-1868-6
Rule: Show credit limit

  Scenario: choose 500
    Given staff has chosen a $500.00 credit limit
     When they add the credit account
     Then they see the credit limit $500.00

  Scenario: prepaid
    Given staff has chosen prepaid
     When they add the credit account
     Then they see the credit limit "Prepaid"

@orv2-1868-7
Rule: Show credit balance

  Scenario: $0 balance
    Given this is a new credit account
     When staff add the credit account
     Then they see the credit balance $0

@orv2-1868-8
Rule: Show available credit

  Scenario: choose 500
    Given staff has chosen a $500.00 credit limit
     When they add the credit account
     Then they see the credit limit $500.00

  Scenario: prepaid
    Given staff has chosen prepaid
     When they add the credit account
     Then they see the available credit as $0

@orv2-1868-9
Rule: Show credit account users

  Scenario: new credit account
     When staff ass the credit account
     Then they see the credit account holder in the credit account users list as follows:
       | data                       | description                                           |
       | Company Name               | the legal company name of the credit account holder   |
       | onRouteBC Client No.       | the onRouteBC Client No. of the credit account holder |
       | credit account designation | Account Holder                                        |



