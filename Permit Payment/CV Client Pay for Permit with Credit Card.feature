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
      Then their chosen method is indicated

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

  Scenario: redirect to cart fails
    Given the cv client cancels at payment processor
     When they cancel
      And the item cannot be returned to the shopping cart
     Then they see the unexpected error page
      And the item is in the applications in progress
      And the item is waiting for payment

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
     Then they are directed to the "Success" page
      And they see options to:
        | apply for a new permit     |
        | view the generated permit  |
        | view the generated receipt |
      And the permit is issued
      # see Issue Permit
  
@orv2-1119-6   
Rule: A CV Client must use a credit card number that is valid for the credit card type

  Scenario: Card type mismatch
    Given the CV client chooses uses a valid credit card
      And chooses an incorrect card type
     When they attempt to complete payment
     Then they see invalid card type notification

@orv2-1119-7  
Rule: onRouteBC will wait 30min for a payment transaction to be completed by the payment processor

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

@orv2-1119-8
Rule: Payment can be made by a CV Client for an application that is unsuccessful on the first try.

  Scenario: No response from payment processor
    Given the CV Client has submitted payment details
     When the payment processor does not respond
     Then the application remains in "Applications in Progress"
# see applying for permits and manage permit applications in progress, a CV Client will open a permit application and step through the workflow to the payment page to attempt another payment

What do we do with other processing issues (there are too many scenarios to cover them all here):
55 - currently returns to onroute with notification
158 - currently returns to onroute with notification
54 - currently returns to onroute with notification
