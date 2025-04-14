Feature: CV Client CA view their credit account

CV Client = CA

@orv2-1999-1 @orv2-4049-1
Rule: Show credit account information

  Scenario: credit account exists
     When a cv client chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account does not exist
     When a cv client chooses to view credit account
     Then they do not see the option to view credit account

   Scenario: credit account closed
     When a cv client chooses to view credit account
     Then they see the following information:
       | information                   | description                                |
       | Closed                        | label describing the credit account status |
       | Credit Account Users          | table listing users of the credit account  |
       | Contact CVSE Revenue info box | instructions                               |

  Scenario: credit account on hold
     When a cv client chooses to view credit account
     Then they see the following information:
       | information                   | description                                |
       | On Hold                       | label describing the credit account status |
       | Credit Account Users          | table listing users of the credit account  |
       | Contact CVSE Revenue info box | instructions                               |

@orv2-1999-2
Rule: Show onRouteBC generated unique credit account number

@orv2-1999-3
Rule: Show the credit account holder designation

  Scenario: holder
     When cv client are viewing a holder of a credit account
     Then they see "Account Holder"

@orv2-1999-4
Rule: Show credit limit

  Scenario: $500
    Given staff has assigned a $500.00 credit limit
     When the cv client views credit account
     Then they see a credit limit $500.00

  Scenario: prepaid
    Given staff has assigned a prepaid limit
     When the cv client views credit account
     Then they see the credit limit "Prepaid"

@orv2-1999-5
Rule: Show credit balance

  Scenario: $0 balance
     When the cv client views credit account
     Then they see the credit balance $0

@orv2-1999-6
Rule: Show available credit

  Scenario: $0 balance
     When cv client views credit account
     Then they see the credit balance $0

 # need to confirm this behaviour
  Scenario: prepaid
    Given staff has assigned a prepaid limit
     When the cv client views credit account
     Then they see the available credit $XXX

  Scenario: $500 balance
    Given the cv client has a $1,000 credit limit
      And a $500 balance
     When the view credit account
     Then they see the available credit of $500 

@orv2-1999-7
Rule: Show credit account users

  Scenario: credit account users exist
     When  the cv client chooses to view credit account
     Then they see the <company name> and <onRouteBC Client No.> in the credit account user list

    Examples:
    | company name                         | onRouteBC Client No. |
    | Bandstra Transportation Systems Ltd. | 81.874592-765        |
      Doing Business As (DBA)
      Julie's Trucking Company

  Scenario: no credit account users
     When  the cv client chooses to view credit account
     Then they see the credit account users in the credit account users list as follows:
       | data                       | description                                           |
       | Company Name               | the legal company name of the credit account holder   |
       | Doing Business As (DBA)    | the DBA of the credit account holder                  |
       | onRouteBC Client No.       | the onRouteBC Client No. of the credit account holder |
       | credit account designation | Account Holder                                        |
       
@orv2-1999-8
Rule: CV Client Holder PA cannot see the credit account tab


  Scenario: company A closed becomes user of company B
    Given company A has a closed credit account
      And company A closes their credit account
     When company A becomes a user of company B credit account
     Then company A CA see company B's credit account user page

  Scenario: company A removed as user of company B
    Given company A is a user of company B credit account
     When company A is removed from company B credit account
     Then company A CA sees company A's credit account holder page
      And it is closed