Feature: CV Client pay for permit with credit card

@orv2-1119-3 
Rule: A CV Client can pay for a permit with VISA, Master Card or American Express

  Scenario: Choose payment method at payment processor
     Given the CV client chooses to use a different payment method
      When they choose from the list
         | VISA             |
         | VISA Debit       |
         | Mastercard       |
         | Debit Mastercard |
         | AMEX             |
      Then their choosen method is indicated

@orv2-1119-1
Rule: Payment processor displays payment details from onRouteBC

  Scenario: Valid credit card
    Given the CV client chooses to pay for a permit
     When they are directed to the payment processor
     Then they see payment details:
        | source  | payment details |
        | onRoute | invoice #       |
        | onRoute | amount          |

@orv2-1119-2
Rule: A CV Client can cancel a payment attempt

  Scenario: Cancels payment attempt
    Given the CV client chooses not pay for the permit
     When they cancel at the payment processor
     Then they are directed to the "Pay for Permit" page in onRouteBC

@orv2-1119-4 
Rule: A CV Client can attempt to pay again on a failed transaction

  Scenario: Invalid credit card
    Given the CV Client uses an invalid credit card
     When they attempt to complete payment
     Then they are directed to the "Pay for Permit" page in onRouteBC
      And they see a transaction failed message

@orv2-1119-5   
Rule: Valid transaction completes permit application purchase

  Scenario: Successful credit card purchase
    Given the CV client uses a valid credit card
     When they attempt to complete payment
      And the payment is processed as approved
     Then they are redirected to the onRouteBC "Success" page
      And the permit pdf is generated 
      And the permit payment receipt pdf is generated
  
@orv2-1119-6   
Rule: A CV Client must use a credit card number that is valid for the credit card type

  Scenario: Card type mismatch
    Given the CV client chooses uses a valid credit card
      And chooses an incorrect card type
     When they attempt to complete payment
     Then they see invalid card type notification

@orv2-1119-7  
Rule: onRouteBC will wait XX time for a payment transaction to be completed by the payment processor

  Scenario: Valid credit card long processing
    Given the CV client chooses uses a valid credit card
     When they attempt to complete payment
      And the payment verification processing takes 45 or longer seconds
      And the payment is processed as approved
     Then they are redirected to the onRouteBC "Success" page
      And the permit pdf is generated 
      And the permit payment receipt pdf is generated

  Scenario: Invalid credit card long processing
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
