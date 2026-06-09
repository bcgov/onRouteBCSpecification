Feature: Staff create credit accounts
  As a FIN staff member I need to be able to create credit accounts for CV Clients so that CV Clients can purchase permits using credit provided by MOTT.

staff = FIN

@orv2-1868-1
Rule: staff can optionally create a credit account for a CV Client that does not have a credit account

  Scenario: no credit account
     When staff choose to create a credit account for a cv client
     Then they are directed to a modal to enter the WS number of the CV Client
      And they see the credit account details from onRouteBC (Client Name, DBA, onRouteBC Client No.)
      And they see the verify client details warning "Verify the details below to make this client a Credit Account Holder."
      And they have the option to cancel creating the credit account or continue with creating the credit account by entering a WS number and clicking next

@orv2-1868-2 staff can cancel creating a credit account during the add credit account process

  Scenario: cancel create credit account
     When staff choose to create a credit account for a cv client
      And they choose to cancel creating the credit account
     Then they are directed back to the cv client credit accounts page
      And the credit account is not created

@orv2-1868-3
Rule: staff must enter a valid WS number to create a credit account

  Scenario: no WS number inputted
     Given staff have not entered a WS number
      When they add the credit account
      Then they see "This is a required field"
       And the Enter WS No. field is indicated with a red box
       And they stay on the create credit account modal

  Scenario: WS number not found in eGARMS
     Given staff have entered an invalid WS number
      When they choose to continue
      Then they see "WS not found."
       And the Enter WS No. field is indicated with a red box
       And they stay on the create credit account modal

  Scenario: ws number already assigned
    Given staff have entered a ws number that is already assigned to am onRouteBC cv client
     When they choose to continue
     Then they see "WS already assigned."
      And the Enter WS No. field is indicated with a red box
      And they stay on the create credit account modal

  Scenario: valid WS number
     Given staff have entered a valid WS number
      When they choose to continue
      Then they see the inputted WS number read only
       And they see the eGARMS returned credit limit, current balance, and available credit
       And they can confirm the details are correct

@orv2-1868-4
Rule: staff can continue to add a credit account for a CV Client with the following eGARMS return codes, E0004, E1739

  Scenario Outline: eGARMS error
     Given staff have entered a WS number that causes an eGARMS error
      When they choose to continue
      Then they see the eGARMS <error message> returned
       And the Enter WS No. field is indicated with a red box
       And they stay on the create credit account modal

    Examples:
      | error message                                               |
      | eGARMS return code E0001(colon) Credit Account not found.   |
      | eGARMS return code E0002(colon) Credit Account is Inactive. |
      | eGARMS return code E9999(colon) Serious Error.              |

@orv2-1868-5
Rule: staff can continue to add a credit account for a CV Client with a valid WS number when they confirm the eGARMS returned credit account details are correct or they can go back to change the WS number if the details are not correct

  Scenario: create credit account with valid WS number
     Given staff have entered a valid WS number
      When they choose to continue
      Then they see the eGARMS returned credit account details including credit limit, current balance, and available credit
       And they can confirm the details are correct and add the credit account
       And they can choose to go back and change the WS number if the details are not correct or cancel adding the credit account

  Scenario: confirmed eGARMS details
     Given staff have entered a valid WS number
      When they have confirmed the eGARMS returned details are correct
      Then they can add the credit account
       And they can choose to go back and change the WS number if the details are not correct or cancel adding the credit account

@orv2-1868-6
Rule: an error is shown if staff attempt to add a credit account for a CV Client with a valid WS number but there is an issue with eGARMS such as eGARMS being down or unreachable

  Scenario: eGARMS unavailable
     Given staff have entered a valid WS number
      When they choose to continue and there is an issue with eGARMS such as eGARMS being down or unreachable
      Then they see "eGARMS Error: Credit Account is unavailable."
       And the Enter WS No. field is indicated with a red box
       And they stay on the create credit account modal

@orv2-1868-7
Rule: show credit account add notification after credit account is successfully created

  Scenario: credit account created
     When staff add a credit account with a valid WS number and confirmed details
     Then they are directed back to the cv client credit accounts page
      And they see the newly created credit account with the correct details including credit limit, current balance, and available credit
       And they see the history table is updated with a new entry for the credit account creation showing the date and time of creation, staff idir and name, and "Account Added"
      And they see the notification "Credit Account Added"

@orv2-1868-8
Rule: a credit account created is always the holder credit account and shows the designation "Account Holder" on the credit account details page and in the credit account users list

  Scenario: account holder
    Given a cv client has a credit account
     When staff are at credit account
     Then they see the designation "Account Holder"

@orv2-1868-9
Rule: show the inputted WS number on the credit account details page

  Scenario: view credit account details
     Given a cv client has a credit account with a WS number
      When staff are at the credit account details page
      Then they see the inputted WS number on the credit account details page

@orv2-1868-10
Rule: show the eGARMS returned credit limit on credit account details page with 2 decimal places

@orv2-1868-11
Rule: show the eGARMS returned current balance on credit account details page with 2 decimal places

@orv2-1868-12
Rule: show the onRouteBC calculated available credit with 2 decimal places

@orv2-1868-13
Rule: show the credit account users list on the credit account details page which includes the credit account holder and any additional users added to the credit account

  Scenario: new credit account
     When staff add the credit account
     Then they see the credit account holder in the credit account users list as follows:
       | data                       | description                                           |
       | Client Name                | the legal Client name of the credit account holder    |
       | Doing Business As (DBA)    | the DBA of the credit account holder                  |
       | onRouteBC Client No.       | the onRouteBC Client No. of the credit account holder |
       | credit account designation | Account Holder or Account User                                        |

@orv2-1868-14
Rule: show the action menu options for the credit account details page

  Scenario: credit account details action menu options
     When staff are at the credit account details page
     Then they see the following action menu options:
      | Put on Hold    |
      | Close Credit Account |

@orv2-1868-15
Rule: staff can find and add users to the credit account 

 #see: Staff Manage Credit Account Users feature


# Deprecated:
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


 Rule: Show onRouteBC generated unique credit account number

  Scenario: new credit account
    Given the cv client did not have a credit account 
     When staff create the credit account
     Then they see the onRouteBC generate unique credit account number as follows:
       | data | description                                 |
       | WS   | prefix                                      |
       | 0000 | four digit numerical ranging from 0000-9999 |