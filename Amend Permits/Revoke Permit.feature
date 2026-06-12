Feature: PPC Admin revoke permit
   As PPC staff I need to be able to revoke a permit so that I can ensure invalid permits are no longer active.

@orv2-1054-0
Rule: Can only revoke an issued or active permit

  Scenario: Permit is voided
    Given the PPC SA has found a void permit
     When they choose to revoke it
     Then they cannot revoke it

  Scenario: Permit is expired
    Given the PPC SA has found a expired permit
     When they choose to revoke it
     Then they cannot revoke it

@orv2-1054-1
Rule: PPC SA and PC can view revoke permit pdf and revoke permit receipt pdf  

 @orv2-937-2
 @orv2-937-3

@orv2-1054-4
Rule: PPC SA or PC can resend revoke permit documents

 @orv2-937-5
 @orv2-937-6

@orv2-1054-7
Rule: PPC SA can revoke a permit

   Scenario: Found permit to revoke
     Given the PPC SA has found a valid permit to revoke
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

@orv2-1054-8
Rule: A revoke permit application is only saved when finished

  Scenario: Close browser tab
    Given a PPC SA or PC has started an amending permit application 
     When they close the browser tab or window
     Then the amending permit application is not saved

  Scenario: Go back
    Given a PPC SA or PC has started an amending permit application 
     When they use the browser to navigate back
     Then the amending permit application is not saved

@orv2-1054-9
Rule: Choose contact details to send revoke permit documents too

   Scenario: Update contact details
     Given the PPC SA is revoking a permit
      When they are at the void permit page
      Then they see the contact details populated with the same information submitted from the revoking permit
       And they can update these details

 # Scenario: Indicate mandatory fields    
     Given the PPC SA is revoking a permit
     When they do not enter valid data into a <mandatory field>  
     And they choose to continue  
     Then they see <mandatory field error message>     
     And they cannot save their changes

     Examples:  
       | mandatory field | mandatory field error message | 
       | Email           | This is a required field      | 

@orv2-1054-10
Rule: Reason for revoke is mandatory
 
   Scenario: Do not input revoke reason
     Given the PPC SA chosen to revoke a permit
      When they do not input a revoke reason
       And they attempt to revoke the permit
      Then they see "This is a required field"
       And they cannot proceed to revoke the permit

@orv2-1054-11
Rule: Finish revoke permit

   Scenario: Return to previous search results
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then they are directed to the search results page 
       And they see indication of successful revoke
       And the active toggle is off


   Scenario: Previous search string
     Given the PPC SA has finished revoking permit
      When they are directed to the <search results> page
      Then they see the <previous search string> results
       And they see "Permit Revoked" notification

      Examples:
      | previous search string | search results                                            |
      | P2-004012
      17            | all permits with matching first 11 characters P2-004013
      17 |

@orv2-1054-14
Rule: Generate revoke permit
 
   Scenario: Generate revoke permit
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoke permit is generated
       And the <permit number> is suffixed with a <revision number> preceded by a "-"
       And the revoke permit is labeled as revoked
       And the revoke permit end date is updated to the date the revoke permit is generated

       Examples:
         | permit number | revision number |
         | P2-00401617-873 17 R2             |

@orv2-1054-18
Rule: Revoked permit is superseded by the revoke permit

   Scenario: Supersede revoked permit
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoked permit is labeled as superseded
       And the permit end date is updated to the date the revoke permit is generated

@orv2-1054-19
Rule: Generate revoke permit pdf

   Scenario: Generate revoke permit pdf
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoke permit pdf is generated
       And the following information is updated on the generated revoke permit pdf:
         | description      | information                                                            |
         | revision history | reflects the date/time and free text comment inputted at revoke permit |
         | revised on       | date/time updated to reflect the date the revoke pdf is generated      |
         | expiry date      | date/time updated to reflect the date the revoke pdf is generated      |
         | watermark        | a revoked watermark is displayed                                       |
   
@orv2-1054-20
Rule: A revoked permit is never refunded

   Scenario: Generate revoke permit pdf receipt
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoke permit pdf receipt is generated with:
         | description    | information                      |
         | transaction id | onRoute transaction order number |
       And the total amount is $0

@orv2-1054-21
Rule: Send revoke permit documents to contact details from void permit page

   Scenario: Send revoke permit and revoke receipt to email
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they revoke the permit
      Then the generated revoke permit PDF and revoke receipt PDF are emailed as attachments to:
        | company contact email address         |
        | email address inputted at void permit |
        | fax number inputted at void permit    |
       And the CV Client cannot reply to the email

   Scenario: Send revoke permit and revoke receipt to fax number
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they revoke the permit
      Then the generated revoke permit PDF and revoke receipt PDF are faxed to the fax number inputted at void permit


  Scenario: Generate revoke permit
    Given the PPC SA has inputted all mandatory information at revoke permit
     When they choose to revoke the permit
     Then the revoke permit is generated
      And the <permit number> is suffixed with a <revision number> preceded by a "-"
      And the revoke permit is labeled as revoked
      And the revoke permit end date is updated to the date the revoke permit is generated

      Examples:
        | permit number   | revision number |
        | P2-00408617-873 | -R2             |


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