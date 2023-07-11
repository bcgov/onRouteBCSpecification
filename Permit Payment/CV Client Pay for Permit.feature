@orv2-1119
Feature: CV Client pay for permit with credit card

Rule: A CV Client can pay for a permit with VISA, Master Card or American Express

  @orv2-1119-1
  Scenario: CV Client attempts to pay with valid credit card
    Given the CV client chooses to pay for a permit
     When they are directed to the payment processor
     Then they see <payment details>
 
    Examples:
        | source  | payment details |
        | onRoute | invoice #       |
        | onRoute | amount          |
        | onRoute | card type       |

  @orv2-1119-2
  Scenario: CV Client cancels payment attempt
    Given the CV client chooses not pay for the permit
     When they cancel at the payment processor
     Then they are redirected to the "Pay for Permit" page in onRouteBC

  @orv2-1119-3   
  Scenario: CV Client chnages payment method at payment processor
     Given the CV client chooses to use a different payment method
      When they choose from the list
         | VISA             |
         | VISA Debit       |
         | Mastercard       |
         | Debit Mastercard |
         | AMEX             |
      Then their choosen method is indicated

  @orv2-1119-4  
  Scenario: CV Client attempts to pay with an invalid credit card
    Given the CV Client uses an invalid credit card
     When they attempt to complete payment
     Then they see card declined notification
      And they are redirected to the payment processor credit card entry page

  @orv2-1119-5   
  Scenario: CV Client attempts to pay with valid credit card
    Given the CV client chooses uses a valid credit card
     When they attempt to complete payment
      And the payment is processed as approved
     Then they are redirected to the onRouteBC "Success" page
      And the permit pdf is generated 
      And the permit payment receipt pdf is generated

  @orv2-1119-6   
  Scenario: CV Client attempts to pay card type mismatch
    Given the CV client chooses uses a valid credit card
      And chooses an incorrect card type
     When they attempt to complete payment
     Then they see invalid card type notification

  @orv2-1119-7  
  Scenario: CV Client attempts to pay with valid credit card long processing
    Given the CV client chooses uses a valid credit card
     When they attempt to complete payment
      And the payment verification processing takes 45 or longer seconds
      And the payment is processed as approved
     Then they are redirected to the onRouteBC "Success" page
      And the permit pdf is generated 
      And the permit payment receipt pdf is generated

  @orv2-1119-8  
  Scenario: CV Client attempts to pay with an invalid credit card long processing
    Given the CV client chooses uses a valid credit card
     When they attempt to complete payment
      And the payment verification processing takes 45 or longer seconds
      And the payment is processed as declined
     Then they see card declined notification
      And they are redirected to the payment processor credit card entry page

What do we do with other processing issues (there are too many scenarios to cover them all here):
55 - currently returns to onroute with notification
158 - currently returns to onroute with notification
54 - currently returns to onroute with notification
