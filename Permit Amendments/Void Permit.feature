Feature: Void a permit
   As PPC staff I need to be able to revoke an issued permit so that I can assist CV Clients.

Rule: Cannot void a voided, revoked, superseded or expired permit
Rule: Cannot void an active term permit
Rule: PPC SA and PC can view void permit pdf and void permit receipt pdf  
Rule: PPC and SA or PC can resend void permit documents

Rule: PPC SA can void a permit

  Scenario: Valid permit
    Given the PPC SA has found a valid permit to void
     When they choose to void the permit
     Then they are directed to the void permit page
Rule: A void permit application is only saved when finished

  Scenario: Close browser tab
    Given a PPC SA has started a void permit application 
     When they close the browser tab or window
     Then the void permit application is not saved

  Scenario: Go back
    Given a PPC SA or PC has started a void permit application 
     When they use the browser to navigate back
     Then the void permit application is not saved

Rule: PPC SA can void a permit

 @orv2-1057-0
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

Rule: Choose contact details to send void permit documents too

 @orv2-1057-1
   Scenario: Update contact details
     Given the PPC SA is voiding a permit
      When they are at the void permit page
      Then they see the contact details populated with the same information submitted from the voiding permit
       And they can update these details

Rule: Reason for void is mandatory

 @orv2-1057-2
   Scenario: Do not input void reason
     Given the PPC SA is voiding a permit
      When they do not input a void reason
       And they attempt to continue
      Then they see "This is a required field"
       And they cannot proceed to void the permit

Rule: Input refund details of the total amount paid for the voiding permit

 @orv2-1057-3
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

Rule: Can change void permit details

 @orv2-1057-4
   Scenario: Change void details
     Given the PPC SA is at the finish voiding page
      When they choose to change void details
      Then they are directed back to the void permit page
       And they can update the contact details and reason for voiding

Rule: View previous financial transaction information for permit being voided

 @orv2-1057-5
   Scenario: Display previous voiding permit transactions
     Given the PPC SA is at the finish voiding page
      When they view transaction history
      Then they see the following details of all previous transactions for the voiding permit:
        | description                                    | information    |
        | permit number for listed transaction           | Permit #       |
        | payment method used for the listed transaction | Payment Method |
        | transaction id for the listed transaction      | Transaction ID |
        | total fee for the listed transaction           | Amount (CAD)   |

Rule: Void is always a full refund of all purchases made for a permit

 @orv2-1057-6
   Scenario: 
     Given the PPC SA is at the finish voiding page
      When they view the fee summary
      Then they see the total amount of all previous transactions for the voiding permit
       And refunds amounts are displayed as a negative number with a "-" preceding the "$"

Rule: Default to previous payment method card type

 @orv2-1057-7
   Scenario: Choose a refund method
     Given the PPC SA has inputted a reason for voiding
      When they choose to continue
      Then they are directed to finish voiding
       And the previous payment method <card type> is chosen with the <PPC prefix>

       Examples:
         | card type                | PPC prefix               |
         | Icepay - VISA            | PPC - VISA               |
         | Icepay - Mastercard      | PPC - Mastercard         |
         | Web - VISA               | PPC - VISA               |
         | Web - Mastercard (Debit) | PPC - Mastercard (Debit) |

Rule: Choose cheque payment method

 @orv2-1057-8
   Scenario: Refund by cheque
     Given the PPC SA is at the finish voiding page
      When they choose to refund by cheque
      Then only refund by cheque is indicated as a refund method
   
Rule: Input mandatory transaction id

 @orv2-1057-9
   Scenario: Do not input transaction ID
     Given the PPC SA has chosen to refund to previous payment method
      When they do not input a transaction ID
       And they attempt to finish
      Then they see "This is a required field"
       And they cannot finish

Rule: Finish void permit

 @orv2-1057-10
   Scenario: Return to previous search results
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then they are directed to the search results page 
       And they see indication of successful void
       And the active toggle is off

 @orv2-1057-11
   Scenario: Previous search string
     Given the PPC SA has finished a void permit
      When they are directed to the <search results> page
      Then they see the <previous search string> results
       And they see "Permit Voided" notification

      Examples:
      | previous search string | search results                                            |
      | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

Rule: Generate void permit

 @orv2-1057-12
   Scenario Outline: Generate void permit
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the void permit is generated
       And the <permit number> is suffixed with a <revision number> preceded by a "-"
       And the void permit is labeled as void
       And the void permit end date is updated to the date the void permit is generated

       Examples:
         | permit number   | revision number |
         | P2-00408617-873 | -R2             |

Rule: Supersede voided permit

 @orv2-1057-13
   Scenario: Supersede voided permit
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the voided permit is labeled as superseded
       And the permit end date is updated to the date the void permit is generated

Rule: Generate void permit pdf

 @orv2-1057-14
   Scenario: Generate void permit pdf
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they choose to finish voiding the permit
      Then the void permit pdf is generated
       And the following information is updated on the generated void permit pdf:
         | description      | information                                                         |
         | revision history | reflects the date/time and free text comment inputted at void permit |
         | revised on       | date/time updated to reflect the date the void pdf is generated     |
         | expiry date      | date/time updated to reflect the date the void pdf is generated     |
         | watermark        | a void watermark is displayed                                       |
  
Rule: Generate void permit pdf receipt

 @orv2-1064-1
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

Rule: Send void permit documents to contact details from void permit page

 @orv2-1057-16
   Scenario: Send void permit and void receipt to email
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they finish voiding a permit
      Then the generated void permit PDF and void receipt PDF are emailed as attachments to:
        | company contact email address         |
        | email address inputted at void permit |
        | fax number inputted at void permit    |
       And the CV Client cannot reply to the email

 # Scenario: Indicate mandatory fields    
     Given the PPC SA is voiding a permit
     When they do not enter valid data into a <mandatory field>  
     And they choose to continue  
     Then they see <mandatory field error message>     
     And they cannot save their changes

     Examples:  
       | mandatory field | mandatory field error message | 
       | Email           | This is a required field      | 

 @orv2-1057-17
   Scenario: Send permit and receipt to fax number
     Given the PPC SA has inputted all mandatory information at finish voiding
      When they successfully completed payment
      Then their generated permit PDF and receipt PDF are faxed to the contact fax number

