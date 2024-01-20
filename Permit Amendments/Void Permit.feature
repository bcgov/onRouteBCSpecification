Feature: Void a permit
   As PPC SA I need to be able to void an issued permit so that I can assist CV Clients.

@orv2-1057-1
Rule: Can only void an issued or active permit

  Scenario: Permit is issued
    Given the PPC SA has found a issued permit
     When they choose to void it
     Then they are directed to void permit 

  Scenario: Permit is active
    Given the PPC SA has found a active permit
     When they choose to void it
     Then they can void it

  Scenario: Permit is voided
    Given the PPC SA has found a void permit
     When they choose to void it
     Then they cannot void it

  Scenario: Permit is expired
    Given the PPC SA has found an expired permit
     When they choose to void it
     Then they cannot void it

   Scenario: Found permit to void
     Given the PPC SA has found a valid permit to void
      When they choose to void it
      Then they are directed to the void permit page
       And they see:
          | description           | information                              |
          | page header           | Void Permit                              |
          | cookie crumb location | Void Permit                              |
          | permit type name      | of voiding permit                        |
          | permit number         | of voiding permit                        |
          | permit start date     | of voiding permit                        |
          | permit end date       | of voiding permit                        |
          | vehicle plate         | of voiding permit                        |
          | banner                | company name of voiding permit           |
          | banner                | company client number  of voiding permit |
          | fee summary           | voiding permit description               |
          | fee summary           | total refund amount                      |
          | revoke permit option  | mechanism to revoke permit               |


@orv2-1057-3
Rule: A void permit application is only saved when finished

  Scenario: Close browser tab
    Given a PPC SA has started a void permit application 
     When they close the browser tab or window
     Then the void permit application is not saved

  Scenario: Go back
    Given a PPC SA or PC has started a void permit application 
     When they use the browser to navigate back
     Then the void permit application is not saved

@orv2-1057-5
Rule: Choose contact details to send void permit documents too

   Scenario: Update contact details
     Given the PPC SA is voiding a permit
      When they are at the void permit page
      Then they see:
        | contact method   | description                         |
        | company email    | source is the company email address |
        | additional email | empty editable field                |
        | fax              | empty editable field                |

@orv2-1057-6
Rule: Reason for void is mandatory

   Scenario: Do not input void reason
     Given the PPC SA is voiding a permit
      When they do not input a void reason
       And they attempt to continue
      Then they see "This is a required field"
       And they cannot proceed to void the permit

@orv2-1057-7
Rule: Input refund transaction details of the total amount paid for the voiding permit

   Scenario: Input refund details
     Given the PPC SA has inputted a reason for voiding
      When they choose to continue
      Then they are directed to the finish voiding page
       And they see:
          | description           | information                          |
          | page header           | Finish Voiding                       |
          | cookie crumb location | Finish Voiding                       |
          | transaction history   | list of previous permit transactions |
          | contact details       | from the void permit page            |
          | reason for voiding    | from the void permit page            |
          | permit number         | of voiding permit                    |
          | fee summary           | voiding permit description           |
          | fee summary           | total refund amount                  |

@orv2-1057-8
Rule: Can change void permit details

   Scenario: Change void details
     Given the PPC SA is at the finish voiding page
      When they choose to change void details
      Then they are directed back to the void permit page
       And they can update the contact details and reason for voiding

@orv2-1057-9
Rule: View previous financial transaction information for permit being voided

   Scenario: Display previous voiding permit transactions
     Given the PPC SA is at the finish voiding page
      When they view transaction history
      Then they see the following details of all previous transactions for the voiding permit:
        | description                                    | information    |
        | permit number for listed transaction           | Permit #       |
        | payment method used for the listed transaction | Payment Method |
        | transaction id for the listed transaction      | Transaction ID |
        | total fee for the listed transaction           | Amount (CAD)   |

@orv2-1057-10
Rule: View void permit application submission details

  Scenario: All contact details inputted
    Given the PPC SA inputted all contact details at void permit
     When they continue to finish voiding
     Then all inputted contact details are shown
      And inputted reason for void is shown

@orv2-1057-11
Rule: A void results in a full refund of current permit dollar value

  Scenario: view fee Summary
    Given the PPC SA is at the finish voiding page
     When they view the fee summary
     Then they see the total amount of all previous transactions for the voiding permit
      And refund amounts are displayed as a negative number with a "-" preceding the "$"

  Scenario: permit is active
    Given the permit being voided is active
     When staff attempt to complete a refund
     Then the <original purchase price> of the permit is <refundable>

     Examples:
       | original purchase price | refundable |
       | $60                     | $60        |
       | $90                     | $90        |

  Scenario: permit has no amendments
    Given the permit being voided has no amendments
     When staff attempt to complete a refund
     Then the <original purchase price> of the permit is <refundable>

     Examples:
       | original purchase price | refundable |
       | $60                     | $60        |
       | $90                     | $90        |

  # Scenario: refund increments 
    Given a permit has 30 days or greater <term remaining>
     When the <refund fee total> amount is calculated 
     Then the refund fee total amount is an <increments> of 30 days

     Examples:
       | term remaining | refund fee total | increments |
       | 30             | $30              | 1          |
       | 60             | $60              | 2          |

  Scenario: permit has amendments that incurred a debit(s)
    Given the permit being voided has amendments that have debit(s)
     When staff attempt to complete a refund
     Then the <original purchase price> of the permit less all previous <debit(s)> is <refundable>

     Examples:
       | original purchase price | debit(s) | refundable | description        |
       | $60                     | $30      | $30        | term was shortened |
       | $90                     | $0       | $90        | plate change       |

  Scenario: permit has amendments that incurred a credit(s)
    Given the permit being voided has amendments that have credit(s)
     When staff attempt to complete a refund
     Then the <original purchase price> of the permit less all previous <credit(s)> is <refundable>

     Examples:
       | original purchase price | credit(s) | refundable | description         |
       | $90                     | $0        | $90        | plate change        |
       | $120                    | $90       | $30        | duration shortened  |

# scenario: time passes between open application and choosing to pay - cannot backdate how do we handle this? 
@orv2-1057-12
Rule: Default to previous payment method card type

   Scenario: Choose a refund method
     Given the PPC SA has inputted a reason for voiding
      When they choose to continue
      Then they are directed to finish voiding
       And the previous payment method <consolidated payment method> is used

       Examples:
         | card type                | PPC prefix               |
         | ICEPAY - Visa            | ICEPAY - Visa            |
         | ICEPAY - Mastercard      | ICEPAY - Mastercard      |
         | Web - Visa               | Web - Visa               |
         | Web - Mastercard (Debit) | Web - Mastercard (Debit) |

@orv2-1057-13
Rule: Choose cheque payment method

   Scenario: Refund by cheque
     Given the PPC SA is at the finish voiding page
      When they choose to refund by cheque
      Then only refund by cheque is indicated as a refund method

@orv2-1057-14  
Rule: Input mandatory transaction id

   Scenario: Do not input transaction ID
     Given the PPC SA has chosen to refund to the previous payment method
      When they do not input a transaction ID
       And they attempt to finish
      Then they see "This is a required field"
       And "Transaction ID" is indicated
       And they cannot finish

@orv2-1057-15
Rule: Return to previous search results when finished void permit

   Scenario: Return to previous search results
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then they are directed to the search results page 
       And they see indication of successful void
       And the active toggle is off

   Scenario: Previous search string
     Given the PPC SA has finished a void permit
      When they are directed to the <search results> page
      Then they see the <previous search string> results
       And they see "Permit Voided" notification

      Examples:
      | previous search string | search results                                            |
      | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

@orv2-1057-16
Rule: Generate void permit

   Scenario Outline: Generate void permit
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the void permit is generated
       And the <permit number> is suffixed with a <revision number> preceded by a "-"
       And the void permit is labeled as void
       And the void permit end date is updated to the date the void permit is generated

       Examples:
         | permit number   | revision number |
         | P2-00408617-873 | R2             |

@orv2-1057-17
Rule: Voided permit is superseded by void permit

   Scenario: Supersede voided permit
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the voided permit is labeled as superseded
       And the permit end date is updated to the date the void permit is generated

@orv2-1057-18
Rule: Generate void permit pdf

   Scenario: Generate void permit pdf
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the void permit pdf is generated
       And the following information is updated on the generated void permit pdf:
         | description      | information                                                          |
         | revision history | reflects the date/time and free text comment inputted at void permit |
         | revised on       | date/time updated to reflect the date the void pdf is generated      |
         | expiry date      | date/time updated to reflect the date the void pdf is generated      |
         | watermark        | a void watermark is displayed                                        |

@orv2-1057-19
Rule: Generate void permit pdf receipt

   Scenario: Refund is calculated
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the void permit pdf receipt is generated 
       And the total amount is represented as a negative number with a "-" preceding the "$"

   Scenario: Refund by cheque
     Given the PPC SA has chosen to refund by cheque
      When the void permit receipt pdf is generated
      Then the transaction id is the onRouteBC transaction number

   Scenario: Refund to previous payment method
     Given the PPC SA has chosen to refund to the previous payment method
       And they input a transaction id
      When the void permit receipt pdf is generated
      Then the transaction id is the transaction id inputted at finish voiding

@orv2-1057-20
Rule: Send void permit documents to contact details from void permit page

 @orv2-1057-21
   Scenario: Send void permit and void receipt to email
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they finish voiding a permit
      Then the generated void permit PDF and void receipt PDF are emailed as attachments to:
        | company contact email address                       |
        | additional email address if inputted at void permit |
        | fax number if inputted at void permit               |
       And the CV Client cannot reply to the email

 @orv2-1057-22
   Scenario: Send permit and receipt to fax number
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they successfully completed payment
      Then their generated permit PDF and receipt PDF are faxed to the contact fax number

@orv2-1057-2
Rule: PPC and SA or PC can resend void permit documents

 @orv2-937-10
 @orv2-937-12

@orv2-1057-0
Rule: PPC SA and PC can view void permit pdf and void permit receipt pdf  

 @orv2-937-7
 @orv2-937-11
