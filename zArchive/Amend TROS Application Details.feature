Feature: Amend TROS permit details
    As PPC staff I need to be able to amend an active TROS permit by changing the dates, so that I can assist clients. 

@orv2-938-6
Rule: PPC SA and PC can change a TROS permit's duration in 30 day increments 

  # (Deprecated for version 1 of this feature)
   #  Scenario: Extend term duration
   #    Given a PPC SA or PC has chosen to extend the permit duration
   #     When they extend <permit duration>
   #     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>

   #     Examples:
   #       | permit expiry date | permit duration | amended permit expiry date |
   #       | March 30, 2023     | 30              | April 29, 2023             |
   #       | April 13, 2023     | 30              | May 13, 2023               |
  
  Scenario: Shorten term duration
    Given a PPC SA has chosen to shorten the permit duration
      And the remaining permit duration is =>60 
     When they shorten <permit duration>
     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>
     
     Examples:
       | permit expiry date | permit duration | amended permit expiry date |
       | April 29, 2023     | 30              | March 30, 2023             |
       | May 13, 2023       | 30              | April 13, 2023             |

  Scenario: Permit duration
    Given the PPC SA or PC is at amend permit
     When they select "Permit Duration"
     Then they see increments of 30 day as follows:
        | 30  |
        | 60  |
        | 90  |
        | 120 |
        | 150 |
        | 180 |
        | 210 |
        | 240 |
        | 270 |
        | 300 |
        | 330 |
        | 1y  |
      And 1y is equal to 1y 



@orv2-938-7
Rule: Show commodity information 

  Scenario: Show information box
    Given the PPC SA or PC is at amend permit
    When they are about to select a commodities decription
    Then they see an an information box above commodities decriptions with text {See UX Hifi Design for text and format}

  Scenario: Select the Commodities and relevant CVSE forms
    Given the PPC SA or PC is at amend permit
     When they select a commodities decription 
     Then the selected CVSE form will be attached to their permit after payment
     And they are able to select multiple commodities descriptions
     And by default Gerneral Permit Conditions and Permit Scope and limitation are already selected for the user and cannot be unselected.

# Deprecated:

# @orv2-938-5
# Rule: PPC SA or PC cannot change the permit start date once the permit is active

  # Scenario: Attempt to change active permit start date
    Given A permit is active 
     When a PPC SA or PC chooses to change the start date
     Then they are unable to change the start date