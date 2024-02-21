Feature: PPC staff can generate a Permit Payment and Refund Detail Report that lists all payment and refund transactions completed in onRouteBC individually.

# See Roles, Services and Permissions Matrix for details on user permissions

Rule: PPC staff can filter report results to include desired transactions

 @orv2-556-1
  Scenario: Filter report results
    Given PPC staff chooses to include transactions that match specific <parameter>:
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
        | issued by      | self issued and ppc   | completed by both ppc and self issued by CV Clients |
        | permit type    | TROS                  | only TROS permits                                   |
        | permit type    | TROS and TROW         | both TROS and TROW permit types                     |
        | permit type    | all permit types      | all permit types                                    |
        | payment method | web - visa and cash   | only paid using Web - Visa and Cash                 |
        | payment method | cash                  | only paid using Cash                                |
        | user           | all users             | all ppc and self issued users                       |
        | user           | JWILLSIE              | only completed by JWILLSIE                          |
        | user           | JWILLSIE and KOPARKIN | completed by both JWILLSIE and KOPARKIN             |
        | from           | 2023/02/09 09:00 PM   | completed on or after 2023/02/09 09:00 PM           |
        | to             | 2023/02/10 09:00 PM   | completed on or before 2023/02/10 08:59.99 PM       |

Rule: When only self issued is chosen PPC staff are unable to choose users

  Scenario: Disable user selection
    Given PPC staff is at Permit Payment and Refund Detail Report parameters page
     When they choose to include only self issued
     Then they are unable to choose users

Rule: When issued by is not chosen PPC staff are unable to view report and choose other parameters

  Scenario: Issued by not choosen
    Given PPC staff have not choosen and issued by
     When they attempt to viw the report
      And choose other parameters
     Then they cannot view the report
      And choose other parameters

Rule: Payment and refund detail parameters have limited options

 @orv2-556-2
   Scenario: PPC staff chooses to filter report results
   Given PPC staff chooses to filter report results 
    When they choose a <parameter> 
    Then they see <options>

    Examples:
       | parameter      | options                                | description                                                                                                               |
       | issued by      | self issued, PPC                       | payment and refund transactions made by either CV Clients (self issued) or staff (PPC), one or many selection is possible |
       | permit type    | all permit types, TROS etc.            | list of all permit types supported by onRouteBC, one or many selections possible                                          |
       | payment method | all payment methods, Cash, Cheque etc. | list of all payment methods supported by onRouteBC, one or many selections possible                                       |
       | user           | all users, JWILLSIE etc.               | list all users authorized to use reports, one or many selections possible                                                 |
       
Rule: Payment and refund detail has default parameters

 @orv2-556-3
  Scenario: Default parameters
    Given PPC staff chooses to view a payment and refund report
     When they choose to view the payment and refund detail report
     Then they see the <parameters> with <default options>

     Examples:
        | parameters     | default options            |
        | issued by      | self issued and PPC        |
        | permit type    | all permit types           |
        | payment method | all payment methods        |
        | user           | all users                  |
        | from           | previous day at 09:00 pm   |
        | to             | current day at 08:59.99 pm |

Rule: Generate report with permit financial transaction data

 @orv2-556-4
  Scenario: Display payment and refund transaction data
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

 @orv2-556-5
 Scenario: User is not PPC staff
   Given a transaction was completed by a CV Client
    When the transaction is listed in the report
    Then the user is "SELF_ISSUED"

Rule: Display header information

 @orv2-556-6
  Scenario: Display payment and refund detail header information
    Given PPC staff have choosen their desired parameter options 
     When they view the report
     Then they see the following header information:
        | report title   | the title of the report                   |
        | run date       | the date and time the report is generated |
        | issued by      | choosen parameter options                 |
        | payment method | choosen parameter options                 |
        | permit type    | choosen parameter options                 |
        | time period    | choosen parameter options                 |
      And multiple parameter options are separated by a comma

 @orv2-556-7
Rule: Group by payments and refunds

 @orv2-556-8
Rule: Sort by payments and refunds groups 

 @orv2-556-9
Rule: Group by payment method

 @orv2-556-10
Rule: Sort by payment method then issued on in ascending order

 @orv2-556-11
Rule: Sub total payment method

 @orv2-556-12
Rule: Sub total payments and refunds

 @orv2-556-13
Rule: List sub totals of all payments, refunds and deposits by payment method in tabular format

 @orv2-556-14
Rule: Sub total deposit by payment method (payments less refunds)

 @orv2-556-15
Rule: Sub total all deposits by payment method

 @orv2-556-16
Rule: Total all deposits

 @orv2-556-17
Rule: List sub total of new permits sold by permit type 

 @orv2-556-18
Rule: Total all new permits sold

 @orv2-556-19
Rule: Format pdf output to 8.5x11 letter size landscape layout

 @orv2-556-20
Rule: Number pages consecutively in footer