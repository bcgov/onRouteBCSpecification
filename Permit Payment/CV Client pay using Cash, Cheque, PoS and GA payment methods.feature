Feature: CV Client pay using Cash, Cheque, PoS and GA payment methods

CV Client = CA, PA

@orv2-2192-1
Rule: CV Client can only pay for permit using cash, cheque or debit in person

@orv2-2192-2
Rule: CV Client see pay in person instruction text at shopping cart

  Scenario: go to cart
     When a cv client chooses to view the cart
     Then they see the following pay in person instruction:
       Pay In-person (Cash/Cheque/Debit) 
       Pay in person at the Provincial Permit Centre
       Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca
       Pay in person at a Service BC Office (GA)
       Service BC Office (GA) Locations

@orv2-2192-3
Rule: CV Client can optionally link to the Service BC offices location list

  Scenario: view service bc locations list
    Given a cv client is at the cart
     When they choose to view the service bc locations list
     Then they are directed to https://www2.gov.bc.ca/gov/content/governments/organizational-structure/ministries-organizations/ministries/citizens-services/servicebc#locations


