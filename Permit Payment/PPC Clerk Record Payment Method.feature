Feature: PPC Clerk record payment method
   As a PPC Clerk I need to be able to record a payment on behalf of CV Clients for transactions that I process so that I can issue their permit and it can be acurately accounted for by payment method.

 @orv2-948-1
  Scenario: Record in person or refund transaction credit card type
    Given a PPC Clerk has completed a successful payment transaction
     When they choose a card type from the list
        | VISA       |
        | Mastercard |
        | AMEX       |
     Then the choosen card type is indicated

 @orv2-948-2
  Scenario: Record phone transaction (IcePay) credit card type
    Given a PPC Clerk has completed a successful payment transaction
     When they choose a card type from the list
        | VISA       |
        | Mastercard |
        | AMEX       |
     Then the choosen card type is indicated

 @orv2-948-3
  Scenario: Record transaction id
    Given a PPC Clerk has completed a successful payment transaction
      And inputted the transaction id provided by the payment processor
     When they choose to complete payment
     Then they are redirected to the onRouteBC "Success" page
      And the permit pdf is generated 
      And the permit payment receipt pdf is generated
