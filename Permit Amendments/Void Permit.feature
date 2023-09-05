Feature: Void a permit

Rule: Only PPC Admin can void a permit

Rule: Cannot void or revoke a void permit

Rule: Cannot void a term permit once it has reached its effective date

Rule: Void a permit

@orv2-1057
  Scenario: Found permit to void
    Given the PPC Admin has found a valid permit to void
     When they choose to void it
     Then they are directed to the void permit page
      And they see:
         | description           | information                              |
         | page header           | Void Permit                              |
         | cookie crumb location | Void Permit                              |
         | permit type name      | of voiding permit                        |
         | permit number         | of voiding permit                        |
         | pemrit start date     | of voiding permit                        |
         | permit end date       | of voiding permit                        |
         | vehicle plate         | of voiding permit                        |
         | banner                | company name of voiding permit           |
         | banner                | company client number  of voiding permit |
         | fee summary           | voiding permit description               |
         | fee summary           | total refund amount                      |

Rule: Choose contact details to send void permit documents too

@orv2-1057
  Scenario: Update contact details
    Given the PPC Admin is voiding a permit
     When they are at the void permit page
     Then they see the contact details populated with the same information submitted from the voiding permit
      And they can update these details

Rule: Reason for void is mandatory

@orv2-1057
  Scenario: Do not input void reason
    Given the PPC Admin is voiding a permit
     When they do not input a void reason
      And they attempt to continue
     Then they see "This is a required field"
      And they cannot proceed to void the permit

Rule: Input refund details of the total amount paid for the voiding permit

@orv2-1057
  Scenario: Input refund details
    Given the PPC Admin has inputted a reson for voiding
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

Rule: Can go back from payment screen and change reason

@orv2-1057
  Scenario: Change void details
    Given the PPC Admin is at the finish voiding page
     When they choose to chnage void details
     Then they are directed back to the void permit page
      And they can update the contact details and reason for voiding

Rule: View previous financial transaction information for permit being voided

@orv2-1057
  Scenario: Display previous voiding permit transactions
    Given the PPC Admin is at the finsh voiding page
     When they view transaction history
     Then they see the following details of all previous transactions for the voiding permit:
       | description                                    | information    |
       | permit number for listed transaction           | Permit #       |
       | payment method used for the listed transaction | Payment Method |
       | transaction id for the listed transaction      | Transaction ID |
       | total fee for the listed transaction           | Amount (CAD)   |

Rule: Void is always a full refund of all purchases made for a permit

@orv2-1057
  Scenario: 
    Given the PPC Admin is at the finish voiding page
     When they view the fee summary
     Then they see the total amount of all previous transactions for the voiding permit
      And refunds amounts are displayed as a negative number

Rule: Default to previous payment method

@orv2-1057
  Scenario: Choose a refund method
    Given the PPC Admin is at the finish voiding page
     When they decided to choose a refund method
     Then the previous payment method is chosen
      And the previous payment method is indicated as chosen
      And the previous payment method is displayed

Rule: Choose cheque payment method

@orv2-1057
  Scenario: Refund by cheque
    Given the PPC Admin is at the finish voiding page
     When they choose to refund by cheque
     Then only refund by cheque is indicated as a refund method
   
Rule: Input mandatory transaction id

@orv2-1057
  Scenario: Do not input transaction ID
    Given the PPC Admin has chosen to refund to previous payment method
     When they do not input a trabsaction ID
      And they attempt to finish
     Then they see "This is a required field"
      And they cannot finish



Rule: Indicate void success

@orv2-1057
  Scenario: 
    Given 
     When 
     Then 

Rule: Finish void permit

@orv2-1057
  Scenario: Retrun to previous search results
    Given the PPC Admin has inputted all mandatory information at finish voiding
     When they choose to finish voiding the permit
     Then they are directed to the search results page 
      And they see indication of successful void
      And they see search results of the previous search string 
      And the active toggle is off

@orv2-1057
  Scenario: Permit label changes
    Given 
     When 
     Then       

@orv2-1057
  Scenario: Associate payment method
    Given 
     When 
     Then 
