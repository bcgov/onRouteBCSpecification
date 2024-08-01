Feature: SA, HQA view credit account

Staff = SA, HQA

@orv2-2035-1
Rule: Show credit account information

  Scenario: credit account exists
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account does not exist
     When staff chooses to view credit account
     Then they see the option to view credit account
      And they see "For Credit Accounts, please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" info box

  Scenario: credit account closed
     When staff chooses to view credit account
     Then they see the option to view credit account

 Scenario: credit account closed view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account on hold view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account closed view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account on hold view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account suspended view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account suspended view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account active view user
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                               |
       | Credit Account Users   | table listing users of the credit account |
       | Credit Account details | financial details of the credit account   |

  Scenario: credit account active view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                               |
       | Credit Account Users   | table listing users of the credit account |
       | Credit Account details | financial details of the credit account   |

  Scenario: credit account on hold view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | On Hold                       | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Credit Account details        | financial details of the credit account            |
 
   Scenario: credit account on hold view user
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                                |
       | On Hold                | label describing the credit account status |
       | Credit Account details | financial details of the credit account    |
       | Credit Account Users   | table listing users of the credit account  |

  Scenario: credit account closed view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | Closed                        | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Credit Account details        | financial details of the credit account            |
 
   Scenario: credit account closed view user
     When staff chooses to view credit account
     Then they see "For Credit Accounts, please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" info box

  Scenario: credit account suspended view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                                |
       | On Hold                | label describing the credit account status |
       | Credit Account details | financial details of the credit account    |
       | Credit Account Users   | table listing users of the credit account  |
 
   Scenario: credit account suspended view user
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | On Hold                       | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Credit Account details        | financial details of the credit account            |

@orv2-2035-2
Rule: Show onRouteBC generated unique credit account number

@orv2-2035-3
Rule: Show the credit account designation

  Scenario: user
     When staff are viewing a user of a credit account
     Then they see "Account User"

  Scenario: holder
     When staff are viewing a holder of a credit account
     Then they see "Account Holder"

@orv2-2035-4
Rule: Show credit limit

  Scenario: $500
    Given staff has assigned a $500.00 credit limit
     When staff views credit account
     Then they see a credit limit $500.00

  Scenario: prepaid
    Given staff has assigned a prepaid limit
     When staff views credit account
     Then they see the credit limit "Prepaid"

@orv2-2035-5
Rule: Show credit balance

  Scenario: $0 balance
     When staff views credit account
     Then they see the credit balance $0

@orv2-2035-6
Rule: Show available credit

  Scenario: $0 balance
     Wstaff views credit account
     Then they see the credit balance $0

# need to confirm this behaviour
  Scenario: prepaid
    Given staff has assigned a prepaid limit
     When staff views credit account
     Then they see the available credit $XXX

  Scenario: $500 balance
    Given staff has a $1,000 credit limit
      And a $500 balance
     When the view credit account
     Then they see the available credit of $500 

@orv2-2035-7
 Rule: Show credit account users

  Scenario: credit account users exist
     When  staff chooses to view credit account
     Then they see the <company name> and <onRouteBC Client No.> in the credit account user list

    Examples:
    | company name                         | onRouteBC Client No. |
    | Bandstra Transportation Systems Ltd. | 81.874592-765        |
      Doing Business As (DBA)
      Julie's Trucking Company

  Scenario: no credit account users
     When  staff chooses to view credit account
     Then they see the credit account users in the credit account users list as follows:
       | data                       | description                                           |
       | Company Name               | the legal company name of the credit account holder   |
       | Doing Business As (DBA)    | the DBA of the credit account holder                  |
       | onRouteBC Client No.       | the onRouteBC Client No. of the credit account holder |
       | credit account designation | Account Holder                                        |