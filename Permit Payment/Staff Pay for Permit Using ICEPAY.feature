Feature Staff Pay for Permit Using ICEPAY
   As a PPC SA or PC I can pay for a permit application on behalf of a CV Client so that I can complete the issuance of a valid permit.

@orv2-1584
Rule: Staff can pay for a permit using only ICEPAY

@orv2-1584
Rule: Staff can input a credit card type

@orv2-1584
Rule: Staff can input a transaction ID manually

  Scenario: transaction ID is mandatory
    Given Staff have not inputted a transaction ID
     When they attempt to finish
     Then they see "This is a required field"
      And "Transaction ID" is indicated
      And they cannot finish

