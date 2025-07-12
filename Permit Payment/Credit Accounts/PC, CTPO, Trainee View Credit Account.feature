Feature: PC, CTPO, Trainee view credit account

Staff = PC, CTPO, Trainee

@orv2-2005-2 @orv2-3495-12
Rule: staff can view credit account information for holders and users

  Scenario: exists view holder or user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: does not exist
     When staff chooses to view credit account
     Then they see the option to view credit account
      And they see "For Credit Accounts, please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" info box

  Scenario: holder closed view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: holder on hold view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: holder closed view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: holder on hold view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: holder active view user
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |

  Scenario: holder active view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |

  Scenario: holder on hold view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |
 
   Scenario: holder on hold view user
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |

  Scenario: closed view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |
 
   Scenario: holder closed view user
     When staff chooses to view credit account
     Then they see they see "For Credit Accounts, please contact CVSE Revenue. Phone: (250) 952-0422 or Email: isfinance@gov.bc.ca" info box

  Scenario: holder suspended view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                               |
       | Available Credit     | credit account limit                      |
       | Credit Account Users | table listing users of the credit account |

   Scenario: holder suspended view user
     When staff chooses to view credit account
     Then they see the following information:
       | information          | description                                |
       | On Hold              | label describing the credit account status |
       | Credit Account Users | table listing users of the credit account  |

@orv2-2005-3
Rule: Show onRouteBC generated unique credit account number

@orv2-2005-4
Rule: Show the credit account designation

  Scenario: user
     When staff are viewing a user of a credit account
     Then they see "Account User"

  Scenario: holder
     When staff are viewing a holder of a credit account
     Then they see "Account Holder"

@orv2-2005-5
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

@orv2-3495-12
Rule: PC, CTPO can see available credit on credit account holder and credit account user profiles