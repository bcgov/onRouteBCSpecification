Feature: PPC Admin revoke permit
   As PPC staff I need to be able to revoke a permit so that I can ensure invalid permits are no longer active.

Rule: Cannot revoke a revoked, voided, superseded or expired permit
Rule: PPC SA and PC can view revoke permit pdf and revoke permit receipt pdf  
Rule: PPC SA or PC can resend revoke permit documents

Rule: PPC SA can revoke a permit

 @orv2-1054-0
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
Rule: A revoke permit application is only saved when finished

  Scenario: Close browser tab
    Given a PPC SA or PC has started an amending permit application 
     When they close the browser tab or window
     Then the amending permit application is not saved

  Scenario: Go back
    Given a PPC SA or PC has started an amending permit application 
     When they use the browser to navigate back
     Then the amending permit application is not saved


Rule: Choose contact details to send revoke permit documents too

 @orv2-1054-1
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


Rule: Reason for revoke is mandatory

 @orv2-1054-2
   Scenario: Do not input revoke reason
     Given the PPC SA chosen to revoke a permit
      When they do not input a revoke reason
       And they attempt to revoke the permit
      Then they see "This is a required field"
       And they cannot proceed to revoke the permit

Rule: Finish revoke permit

 @orv2-1054-3
   Scenario: Return to previous search results
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then they are directed to the search results page 
       And they see indication of successful revoke
       And the active toggle is off

 @orv2-1054-4
   Scenario: Previous search string
     Given the PPC SA has finished revoking permit
      When they are directed to the <search results> page
      Then they see the <previous search string> results
       And they see "Permit Revoked" notification

      Examples:
      | previous search string | search results                                            |
      | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

Rule: Generate revoke permit

 @orv2-1054-5
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

Rule: Supersede revoked permit

 @orv2-1054-6
   Scenario: Supersede revoked permit
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoked permit is labeled as superseded
       And the permit end date is updated to the date the revoke permit is generated

Rule: Generate revoke permit pdf

 @orv2-1054-7
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
   
Rule: A revoked permit is never refunded

 @orv2-1054-8
   Scenario: Generate revoke permit pdf receipt
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they choose to revoke the permit
      Then the revoke permit pdf receipt is generated with:
         | description    | information                      |
         | transaction id | onRoute transaction order number |
       And the total amount is $0

Rule: Send revoke permit documents to contact details from void permit page

 @orv2-1054-10
   Scenario: Send revoke permit and revoke receipt to email
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they revoke the permit
      Then the generated revoke permit PDF and revoke receipt PDF are emailed as attachments to:
        | company contact email address         |
        | email address inputted at void permit |
        | fax number inputted at void permit    |
       And the CV Client cannot reply to the email

 @orv2-1054-11
   Scenario: Send revoke permit and revoke receipt to fax number
     Given the PPC SA has inputted all mandatory information at revoke permit
      When they revoke the permit
      Then the generated revoke permit PDF and revoke receipt PDF are faxed to the fax number inputted at void permit