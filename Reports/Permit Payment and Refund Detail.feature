Feature: Permit Payment and Refund Detail Report

Rule: PPC staff can filter report results to include desired tranasactions

  Scenario: Filter report results
    Given PPC staff chooses to include transactions with a specific <parameter>:
     | issued by      |
     | permit type    |
     | payment method |
     | user           |
     | from           |
     | to             |
     When they choose a <parameter> <options>
     Then they see payment and refund transaction <results> that include the <parameter> <options> choosen

     Examples:
        | parameter      | options               | results                                             |
        | issued by      | self issued           | only completed by CV Clients                        |
        | issued by      | PPC                   | only completed by PPC                               |
        | issued by      | self issued and ppc   | completed by both ppc and self issued by cv clients |
        | permit type    | TROS                  | only TROS permits                                   |
        | permit type    | TROS and TROW         | both TROS and TROW permits                          |
        | permit type    | all permit types      | all permit types                                    |
        | payment method | web - visa and cash   | only paid using Web - Visa and Cash                 |
        | payment method | cash                  | only paid using Cash                                |
        | user           | all users             | all ppc and self issued users                       |
        | user           | JWILLSIE              | only completed JWILLSIE                             |
        | user           | JWILLSIE and KOPARKIN | completed by both JWILLSIE and KOPARKIN             |
        | from           | 2023/02/10 09:00 PM   | completed on or after 2023/02/10 09:00 PM           |
        | to             | 2023/02/10 09:00 PM   | completed on or before 2023/02/10 09:00 PM          |

Rule: Payment and refund detail parameters have limited options

    Scenario: PPC staff chooses to filter report results
    Given PPC staff chooses to filter report results 
     When they choose a <parameter> 
     Then they see <options>

     Examples:
        | parameter   | options                     | description                                                                                                    |
        | issued by   | self issued, PPC            | payment and refund transactions made by either CV Clients (self issued) or staff (PPC)                         |
        | permit type | all permit types, TROS etc. | all permit types includes all permit type payment and refund transactions or could be one or many permit types |
        | payment method | all payment methods, Cash, Cheque
        Credit Account
        GA Payment
        Icepay - AMEX
        Icepay Debit
        Icepay - Mastercard
        Icepay - Mastercard (Debit)
        Icepay - Visa
        Icepay - Visa (Debit)
        POS - AMEX
        PoS - Debit
        PoS - Mastercard
        Po - Mastercard (Debit)
        Po - Visa
        PoS - Visa (Debit)
        Web - AMEX
        Web - Mastercard
        Web - Mastercard (Debit)
        Web - Visa
        Web - Visa (Debit) | all payment methods would include all payment and refund transactions completed using any payment method or one or many payment methods |
        | user        | all users, JWILLSIE etc.    | all users would include all payment and refund transactions completed or one or many users                     |

Rule: Payment and refund detail has default parameters

  Scenario: Default parameters
    Given PPC staff chooses to view a payment and refund report
     When they choose to view the payment and refund detail report
     Then they see the <parameters> with <default options>

     Examples:
        | parameters     | default options      |
        | issued by      | self issued and PPC  |
        | permit type    | all permit types     |
        | payment method | all payment methods  |
        | user           | all users            |
        | from           | previous day at 9 pm |
        | to             | previous day at 9 pm |

Rule: Generate report with permit financial transaction information

  Scenario: Display payment and refund transaction information
    Given PPC staff have choosen their desired parameter options 
     When they view the report
     Then they see the following information about each payment and refund transaction:
        | issued on      |
        | transaction ID |
        | payment method |
        | receipt #      |
        | permit #       |
        | permit type    |
        | user           |
        | amount         |

Rule: Display header information

  Scenario: Display payment and refund detail header information
    Given PPC staff have choosen their desired parameter options 
     When they view the report
     Then they see the following header information:
        | report title   | the title of the report                   |
        | run date       | they date and time the report is gnerated |
        | issued by      | choosen parameter options                 |
        | payment method | choosen parameter options                 |
        | permit type    | choosen parameter options                 |
        | time period    | choosen parameter options                 |

Rule: Group by payments and refunds

Rule: Group by payment method

Rule: Sort by payment method then issued on

Rule: Sub total payment method

Rule: Sub total payments and refunds

Rule: Sub total deposit by payment method (payments less refunds)

Rule: List all sub totals of payments, refunds and deposit by payment method in tabular format

Rule: Sub total all deposits by payment method

Rule: Total all deposits

Rule: List sub total of permits sold by permit type 

Rule Total all permits sold

Rule: Format pdf output to 8.5x11 letter size landscape layout

Rule: Number pages consecutively

