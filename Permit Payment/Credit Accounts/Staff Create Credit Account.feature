Feature: Staff create credit accounts
  As a FIN staff member I need to be able to create credit accounts for CV Clients so that CV Clients can purchase permits using credit provided by MOTI.

Staff = FIN

@orv2-1868-1
Rule: Staff can create a credit account for a CV Client

  Scenario: no credit account
     When staff choose to create a credit account for a cv client
     Then the see the option to add a credit account

@orv2-1868-3
Rule: Show credit account add notification

  Scenario: credit account created
     When create the credit account
     Then they are directed to credit account
      And they see "Credit Account Added" notification

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
Rule: Show current balance

# TBD whether we enter payments into onRouteBC which will potentially change this behaviour
  Scenario: $0 balance
    Given this is a new credit account
     When staff add the credit account
     Then they see the current balance $0

  Scenario: prepaid
    Given this is an existing account
     When there is $500 credit
     Then the current balance is -$500.00

  Scenario: owe
    Given this is an existing account
      And the credit limit is $2000.00
     When there is $500 owing
     Then the current balance is $500.00

  Scenario: overpaid
    Given this is an existing account
      And the credit limit is $2000.00
     When there is $500.00 overpaid
     Then the current balance is -$500.00

@orv2-1868-8
Rule: Show available credit

  Scenario: choose 500
    Given staff has chosen a $500.00 credit limit
     When they add the credit account
     Then they see the available credit $500.00
  
  Scenario: owe
    Given this is an existing account
      And the credit limit is $2000.00
     When there is $500 owing
     Then the available credit is $1500.00

  Scenario: overpaid
    Given this is an existing account
      And the credit limit is $2000.00
     When there is $500.00 overpaid
     Then the available credit is -$2500.00

  Scenario: prepaid
    Given staff has chosen prepaid
     When they add the credit account
     Then they see the available credit limit $0

@orv2-1868-9
Rule: Show credit account users

  Scenario: new credit account
     When staff add the credit account
     Then they see the credit account holder in the credit account users list as follows:
       | data                       | description                                           |
       | Company Name               | the legal company name of the credit account holder   |
       | Doing Business As (DBA)    | the DBA of the credit account holder                  |
       | onRouteBC Client No.       | the onRouteBC Client No. of the credit account holder |
       | credit account designation | Account Holder                                        |
#
# Notes:
- Create credit account new version:
- remove the existing design and replace with this one
- enter WS number
 - mandatory field if they don't enter a ws number then they see "This is a required field"
- shows GARMs credit account details
- confirm add
- valid WS number but not the right company
 - can go back 
- invalid WS number
 - error message "WS number not found"
 - stay on the modal where ws entry is made
- directed to the credit accounts details page
- history table is updated with account added and shows the following details:
 - date and time of account creation
 - idir, date and time of staff that created the account, "Account Added"
add credit account to return eGARMS information that is available like credit limit etc.

- Raise bug for intermittent eGARMS error bug and assign to Praveen #nextaction
- receive payment in onRouteBC?
- RBC bank payment 
 - Do they know anything about RBC bank payment?
- TPS account numbers not added to GARMS account is this OK?

No account
- show no records found
- choose Add Credit Account
- Modal opens to enter WS number
- Add Credit Account
Verify Client Details

Verify the details below to make this client a Credit Account Holder.

Client Name
Moose Mountain Freight
Doing Business As (DBA)
Moose Mountain Freight
onRouteBC Client No.
B1-874592-765
Enter WS No.
WS
Cancel Next

Enter WS Happy Path
- Staff enter valid WS number
- Staff click Next
- Staff see the credit account details returned from eGARMS which includes Credit Limit Current Balance Available Credit as well as the details of the credit account holder (Company Name, DBA, onRouteBC Client No.)
- Verify details checkbox is available for staff to confirm the details are correct
- Cancel Previous Add Credit Account
- Staff click click the verification checkbox to confirm the details are correct
- Add Credit Account button is available and staff click Add Credit Account
- Staff click Add Credit Account
- Staff see "Credit Account Added" notification
- Credit Account Details page is displayed with the credit account details and the history table shows the account creation with the date and time of creation, staff idir and name, and "Account Added"
- staff see designation "Account Holder" in the credit account users list with the company name, DBA, and onRouteBC Client No. of the credit account holder
- option to add another credit account user is available and staff can add another user to the credit account if needed
- Credit account details action menu options include Put on Hold, Close Credit Account

Uphappy Path - Invalid WS Number
- Staff enter invalid WS number
- Staff click Next
- Staff see error message "WS number not found"
- Staff stay on the modal to enter WS number

Uphappy Path - no input WS number
- Staff click Next without entering WS number
- Staff see error message "This is a required field"
- Staff stay on the modal to enter WS number

Unhappy Path - valid or invalid WS number but eGARMS returns an error
- Staff enter valid or invalid WS number
- Staff click Next
- Staff see error message eGARMS return code E0001: Credit Account not found.
- Staff stay on the modal to enter WS number

# Deprecated:
@orv2-1868-2
Rule: Staff must choose from a list of credit account limits

  Scenario: default list state
    Given there is no credit account
     When staff choose to create a credit account
     Then they see "select"

  Scenario: limit not chosen
    Given a limit is not chosen
     When staff add the credit account
     Then they see "This is a required field"
      And they cannot add the credit account

  Scenario: choose 500
    Given staff has chosen a $500.00 credit limit
     When they add the credit account
     Then they are directed to credit account

@orv2-1868-4
Rule: Show onRouteBC generated unique credit account number

  Scenario: new credit account
    Given the cv client did not have a credit account 
     When staff create the credit account
     Then they see the onRouteBC generate unique credit account number as follows:
       | data | description                                 |
       | WS   | prefix                                      |
       | 0000 | four digit numerical ranging from 0000-9999 |