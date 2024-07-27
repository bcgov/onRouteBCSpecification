Feature: Staff Change Credit Account

Staff = FIN

@orv2-2579-1
Rule:  Staff can change the credit limit of an active credit account

  Scenario: exiting credit account
     When staff choose to change the credit limit
     Then they see the option to choose a new credit limit

@orv2-2579-2
Rule: Staff can see the currently assigned credit limit when choosing a new credit limit

@orv2-2579-3
Rule: Staff must choose from a list of allowable credit limits

  Scenario: no credit limit chosen
     When staff choose to confirm
     Then they see "This is a required field."
      And they cannot confirm

@orv2-2579-4
Rule: Staff are shown their chosen credit limit

  Scenario: see chosen limit
     When staff choose a credit limit of $500
     Then they see $500 as their chosen credit limit

@orv2-2579-5
Rule: Staff can confirm the credit limit update

  Scenario: $500 current balance
    Given the cv client has a $500 current balance
      And a $1000 credit limit
     When staff change the credit limit to $2000
     Then the available credit is $1500

@orv2-2579-6
Rule: Staff can cancel the action to change the credit limit
