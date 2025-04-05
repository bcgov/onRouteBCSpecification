Feature:  Amend an active permit 
   As PPC staff I need to be able to amend an active permit by changing the vehicle plate, vehicle and dates, so that I can assist CV Clients.

Staff = SA, PC, CTPO, Trainee

@orv2-938-8   
Rule: Can only amend an issued or active permit

  Scenario: Permit is voided
    Given the PPC SA has found a void permit
     When they choose to amend it
     Then they cannot amend it

  Scenario: Permit is issued
    Given the PPC SA has found an issued permit
     When they choose to amend it
     Then they are directed to the amend permit 
|
@orv2-938-30
Rule: Staff can view superseded permit and superseded permit receipt pdf  
|
@orv2-937-7
|
@orv2-937-11
|
@orv2-938-9
Rule: Staff can resend superseded permit documents
|
@orv2-937-10
|
@orv2-937-12
|
@orv2-938-31 
Rule: Staff can amend a permit

  Scenario: Valid permit
    Given the Staff have found a valid permit to amend
     When they choose to amend the permit
     Then they are directed to the amend permit page
|
## @orv2-938-10
## Rule: A saved amending permit application is in application in progress

  Scenario: Close browser tab
    Given a Staff has started an amending permit application 
      And it is not saved
     When they close the browser tab or window
     Then the amending permit application is not saved

  Scenario: Go back
    Given a Staff has started an amending permit application 
      And it is not saved
     When they use the browser to navigate back
     Then the amending permit application is not saved
|
## @orv2-938-32
## Rule: Staff can see saved amending permit applications in applications in progress
|
@orv2-938-11
Rule: Staff can amend an issued or active permit

  Scenario: Found permit to amend
    Given the PPC SA has found a valid permit to amend
     When they choose to amend it
     Then they are directed to the amend permit page
      And they see:
         | description           | information                                     |
         | page header           | Amend Permit                                    |
         | cookie crumb location | Amend Permit                                    |
         | permit type name      | of amending permit                              |
         | permit number         | of amending permit                              |
         | date created          | date the amending permit application is created |
         | last updated          | date the amending permit application is created |
         | banner                | company name of amending permit                 |
         | banner                | company client number of amending permit        |
         | company information   | company mailing address of amending permit      |
|
@orv2-938-12
Rule: Staff can view all permit details of the amending permit

 Scenario: Staff choose to amend a valid permit
     Given the Staff has chosen to amend a valid permit
      When they are at the amend permit page
      Then they see all permit application details of the amending permit:
          | description          | information                                     |
          | contact information  | of the amending permit                          |
          | permit details       | of the amending permit                          |
          | vehicle information  | of amending permit                              |
          | revision history     | past reason for amendment free text             |
          | reason for amendment | free text field to capture reason for amendment |
|
@orv2-938-13
Rule: Staff can add free text amendment Reason 

  Scenario: Save amendment reason
    Given the PPC Staff has inputted an amendment reason
     When they choose continue to review and confirm details
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC Staff username> is saved

   Examples:
     | <PPC Staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8:23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |

  Scenario: Attempt to continue without updating amendment reason
    Given a Staff has not inputted a reason for amendment 
     When they chose to continue to review and confirm details
     Then they see "This is a required field"
      And they cannot continue

  Scenario: Reason for amendment mandatory
    Given a PPC Staff is at the "Amend Permit" page 
     When they attempt to continue
      And they have not entered a reason for amendment
     Then they see "This is a required field"
|
@orv2-938-14
Rule: Staff can view the permit revision history

  Scenario: Previous permit revisions
    Given an amending permit has previous revisions
     When a Staff is amending a permit
     Then they see previous <amendment reason>
      And the <PPC Staff username> of the logged in user that saved the amendment
      And the <timestamp> of when the amendment reason was saved

   Examples:
     | <PPC Staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8:23 am PDT | Swapped a Droid Gunship for the Millennium Falcon | 

  Scenario: No previous permit revisions
    Given an amending permit does not have previous revisions
     When a Staff is amending a permit
     Then there is no revision history displayed 
|
@orv2-938-15
Rule: Staff can cancel a permit amendment application

  Scenario: Cancel permit amendment application
    Given the Staff has chosen to cancel a permit amendment application
     When they cancel 
     Then they are directed to the <search results> page
      And they see the <previous search string> results
      And active toggle is off

     Examples:
     | previous search string | search results                                            |
     | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

  Scenario Outline: Generate revoke permit
    Given the PPC SA has inputted all mandatory information at revoke permit
     When they choose to revoke the permit
     Then the revoke permit is generated
      And the <permit number> is suffixed with a <revision number> preceded by a "-"
      And the revoke permit is labeled as revoked
      And the revoke permit end date is updated to the date the revoke permit is generated

      Examples:
        | permit number   | revision number |
        | P2-00408617-873 | -R2             |
|
#@orv2-938-16
#Rule: Staff can view previous financial transaction information for amending permit

 Scenario: Previous financial transactions exist
     Given the PPC SA is at the finish amendment page
      When they view transaction history
      Then they see the following details of all previous transactions for the amending permit:
        | description                                    | information    |
        | permit number for listed transaction           | Permit #       |
        | payment method used for the listed transaction | Payment Method |
        | transaction id for the listed transaction      | Transaction ID |
        | total fee for the listed transaction           | Amount         |
|
#@orv2-938-17
#Rule: Amemndment with refurn default to previous payment method card type

   Scenario: Choose a refund method
     Given the PPC SA has completed mandatory field at review and confirm details
      When they choose to continue
      Then they are directed to finish amendment
       And the previous payment method <consolidated payment method> is used

       Examples:
         | card type                | PPC prefix               |
         | ICEPAY - Visa            | ICEPAY - Visa            |
         | ICEPAY - Mastercard      | ICEPAY - Mastercard      |
         | Web - Visa               | Web - Visa               |
         | Web - Mastercard (Debit) | Web - Mastercard (Debit) |
|
#@orv2-938-18
#Rule: Choose cheque payment method

   Scenario: Refund by cheque
     Given the PPC SA is at the finish amendment page
      When they choose to refund by cheque
      Then only refund by cheque is indicated as a refund method
|
@orv2-938-19
Rule: Input mandatory transaction id

   Scenario: Do not input transaction ID
     Given the PPC SA has chosen to refund to the previous payment method
      When they do not input a transaction ID
       And they attempt to finish
      Then they see "This is a required field"
       And they cannot finish
|
@orv2-938-20
Rule: If amend permit action is initiated at search results then return to previous search results when finished amending permit application

  Scenario: Previous search string
    Given the Staff has finished the amending permit application
     When they are directed to the <search results> page
     Then they see the <previous search string> results
      And they see "Permit Amended" notification
      And active toggle is off

     Examples:
     | previous search string | search results                                            |
     | P2-00408617            | all permits with matching first 11 characters P2-00408617 |
|
@orv2-938-21
Rule: Amending permit is superseded by amended permit

  Scenario: Supersede amending permit
     When they finish the amending permit application
     Then the amending permit is labeled as superseded
|
@orv2-938-22
Rule: Generate amended permit pdf

   Scenario: Generate amended permit pdf
     Given the PPC SA has inputted all mandatory information at finish amendment
      When they choose to finish amending the permit
      Then the amended permit pdf is generated
       And the following information is updated on the generated amended permit pdf:
         | description      | information                                                                |
         | permit details   | reflects amendments made                                                   |
         | revision history | reflects the date/time and free text comment(s) inputted at amended permit |
         | revised on       | date/time updated to reflect the date the amended pdf is generated         |
         | permit number    | permit number reflects the revised number                                  |

@orv2-938-23
Rule: Generate amended permit pdf receipt

  Scenario: Refund is calculated
    Given the PPC SA has inputted all mandatory information at finish amendment
     When they choose to finish amending the permit
     Then the amended permit pdf receipt is generated 
      And the total amount is represented as a negative number with a "-" preceding the "$"

  Scenario: Refund by cheque
    Given the PPC SA has chosen to refund by cheque
     When the amended permit receipt pdf is generated
     Then the transaction id is the onRouteBC transaction number

  Scenario: Refund to previous payment method
    Given the PPC SA has chosen to refund to the previous payment method
      And they input a transaction id
     When the amended permit receipt pdf is generated
     Then the transaction id is the transaction id inputted at finish amendment

@orv2-938-24
Rule: Send revoke permit documents to contact details from void permit page

  Scenario: Send permit and receipt to email
    Given the PPC SA has inputted all mandatory information at finish amendment
     When they choose to finish amending the permit
     Then the generated permit PDF and receipt PDF are emailed as attachments to:
       | company contact email address |
       | entered contact email address |
      And the CV Client cannot reply to the email


  Scenario: Send permit and receipt to fax number
    Given the PPC SA has inputted all mandatory information at finish amendment
     When they choose to finish amending the permit
     Then the generated permit PDF and receipt PDF are faxed to the contact fax number

@orv2-1491-3
Rule: An issued or active permit issued under a no fee designation maintains a $0 fee when amended

  Scenario: cv client issues under no fee flag changes to fee cv client
    Given ABC Co. is a no fee cv client
     And they issue permit A
     And permit A is not expired
     When staff remove ABC Co. no fee designation
     Then permit A has a $0 fee