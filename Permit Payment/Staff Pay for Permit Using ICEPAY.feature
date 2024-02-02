Feature Staff Pay for Permit Using ICEPAY
   As a PPC SA or PC I can pay for a permit application on behalf of a CV Client so that I can complete the issuance of a valid permit.

@orv2-1583-1
Rule: Staff can pay for a permit using ICEPAY

  Scenario: finish payment
    Given Staff have inputted all mandatory fields
     When they finish
     Then they are directed to the "Success" page
      And they see options to:
        | apply for a new permit     |
        | view the generated permit  |
        | view the generated receipt |
      And the permit is issued
      # see Issue Permit

@orv2-1583-2
Rule: Staff can input a credit card type

  Scenario: available card types
    Given Staff have chosen to input a card type
     When they choose on of the available options:
      | Amex               |
      | Mastercard         |
      | Mastercard (Debit) |
      | Visa               |
      | Visa (Debit)
     Then their choosen option is shown

  Scenario: card type is mandatory
    Given Staff have not inputted a card type
     When they attempt to finish
     Then they see "This is a required field"
      And "Card Type" is indicated
      And they cannot finish

@orv2-1583-3
Rule: Staff can input a transaction ID (Provider Transaction ID) manually

  Scenario: transaction ID is mandatory
    Given Staff have not inputted a transaction ID
     When they attempt to finish
     Then they see "This is a required field"
      And "Transaction ID" is indicated
      And they cannot finish

@orv2-1583-4
Rule: Staff can see the permit application payment details

 Scenario: Permit application purchase summary
     Given staff has completed all mandatory permit application fields 
     When they choose to continue to payment
     Then they see the following:
        | information                          | description                                                 |
        | Permit Type and Permit Sub-Type Name | the permit type and subtype applied for e.g. Oversize: Term |
        | Application Number                   | the unique generated application #                          |
        | Item Description                     | the description fo teh item(s) in the fee summary           |
        | item fee amount                      | the fee for a single items(s) in the fee summary            |
        | Total of All Items Fees              | the sum of all item fees in the fee summary                 |

 Scenario: Fee calculation summary
     Given staff is at the "Pay for Permit" page
     When they choose to review the "Fee Summary"
     Then they see individual item <amount> and a <total>
     And <total> is the sum of all items

     Example:
       | amount | total |
       | 30     | 30    |