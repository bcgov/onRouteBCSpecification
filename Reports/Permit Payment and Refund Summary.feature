Feature: PPC staff can generate a Permit Payment and Refund Summary Report that lists all payment and refund transactions completed in onRouteBC summarized by user.

Rule: Choose filter parameters to include only desired transaction information

 @orv2-1166-1
  Scenario: Filter report results
      Given PPC staff chooses to include transactions that match specific <parameter>:
       | issued by      |
       | from           |
       | to             |
       When they choose a <parameter> <options>
       Then they see payment and refund transaction <results> that include the <parameter> <options> choosen

  Examples:
          | parameter      | options               | results                                             |
          | issued by      | self issued           | only completed by CV Clients                        |
          | issued by      | PPC                   | only completed by PPC                               |
          | issued by      | self issued and ppc   | completed by both ppc and self issued by CV Clients |
          | from           | 2023/02/09 09:00 PM   | completed on or after 2023/02/09 09:00 PM           |
          | to             | 2023/02/10 09:00 PM   | completed on or before 2023/02/10 08:59.99 PM          |

Rule: when only self issued is chosen PPC staff are unable to choose users

  Scenario: Disable user selection
    Given PPC staff is at Permit Payment and Refund Detail Report parameters page
     When they choose to include only self issued
     Then they are unable to choose users

Rule: when issued by is not chosen PPC staff are unable to view report and choose other parameters

  Scenario: Issued by not choosen
    Given PPC staff have not choosen and issued by
     When they attempt to viw the report
      And choose other parameters
     Then they cannot view the report
      And choose other parameters

Rule: Payment and refund summary parameters have limited options

 @orv2-556-2
  Scenario: PPC staff chooses to filter report results
  Given PPC staff chooses to filter report results 
   When they choose a <parameter> 
   Then they see <options>

   Examples:
      | parameter | options          | description                                                                                                               |
      | issued by | self issued, PPC | payment and refund transactions made by either CV Clients (self issued) or staff (PPC), one or many selection is possible |
       
Rule: Payment and refund detail have default parameters

 @orv2-1166-2
  Scenario: Default parameters
    Given PPC staff chooses to view a payment and refund report
     When they choose to view the payment and refund detail report
     Then they see the <parameters> with <default options>

     Examples:
        | parameters | default options            |
        | issued by  | self issued and PPC        |
        | from       | previous day at 09:00 pm   |
        | to         | current day at 08:59.99 pm |

Rule: Generate report with permit financial transaction data

 @orv2-1166-3
  Scenario: Display payment and refund transaction data
    Given PPC staff have choosen their desired parameter options 
     When they view the report
     Then they see the following information about each payment and refund transaction:
        | payment method |
        | user           |
        | amount         |

 @orv2-1166-4
 Scenario: User is not PPC staff
   Given a transaction was completed by a CV Client
    When the transaction is listed in the report
    Then the user is "SELF_ISSUED"

Rule: Display header information

 @orv2-1166-5
  Scenario: Display payment and refund summary header information
    Given PPC staff have choosen their desired parameter options 
     When they view the report
     Then they see the following header information:
        | report title   | the title of the report                   |
        | run date       | the date and time the report is generated |
        | issued by      | choosen parameter options                 |
        | time period    | choosen parameter options                 |
      And multiple parameter options are separated by a comma
 
 @orv2-1166-6
Rule: Group by payments and refunds

 @orv2-1166-7
Rule: Sort by payments and refunds groups

 @orv2-1166-8
Rule: Group by payment method

 @orv2-1166-9
Rule: Sort by payment method in ascending order

 @orv2-1166-10
Rule: Sub total (amount) payment method and user

 @orv2-1166-11
Rule: Sub total payment method

 @orv2-1166-12
Rule: Sub total payments and refunds

 @orv2-1166-13
Rule: List sub totals of all payments, refunds and deposits by payment method in tabular format

 @orv2-1166-14
Rule: Sub total deposit by payment method (payments less refunds)

 @orv2-1166-15
Rule: Sub total all deposits

 @orv2-1166-16
Rule: Total all deposits

 @orv2-1166-17
Rule: List sub total of new permits sold by permit type 

 @orv2-1166-18
Rule Total all new permits sold

 @orv2-1166-19
Rule: Format pdf output to 8.5x11 letter size landscape layout

 @orv2-1166-20
Rule: Number pages consecutively in footer
