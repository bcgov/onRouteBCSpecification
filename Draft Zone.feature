User = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA
CV Client = CA, PA
Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA
Auth Staff = PC, SA, TRAIN, CTPO
Non Auth Staff = FIN, EO, HQA

@orv2-3835

Rule: Maximum 15 characters allowed in Transaction ID

Enter 16 characters
they see "Maximum 15 characters"

In staff shopping cart:

   Scenario: date extension
     Given permit A 
      When 
      Then 
 
   Scenario: km added
     Given 
      When 
      Then 
 
   Scenario: weight increased
     Given 
      When 
      Then 
 
  Scenario: dangerous goods
    Given 
     When 
     Then 

  Scenario: fail 2.3 and 4.5 5 axle units
[
      {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 6100
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.88,
        "axleUnitWeight": 21000,
        "interaxleSpacing": 5
      },
      {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 8000,
        "interaxleSpacing": 1.9
      },
      {
        "numberOfAxles": 3,
        "axleSpread": 3.28,
        "axleUnitWeight": 29000,
        "interaxleSpacing": 10
      },
      {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 8000,
        "interaxleSpacing": 3.6
      }
    ]

  Scenario: fail 1.4, 1.5, 2.4, 2.5, 3.4, 3.5 and 4.5 5 axle units
[
      {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 6000
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.5,
        "axleUnitWeight": 14000,
        "interaxleSpacing": 1
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.5,
        "axleUnitWeight": 19000,
        "interaxleSpacing": 3
      },
      {
        "numberOfAxles": 3,
        "axleSpread": 1.5,
        "axleUnitWeight": 24000,
        "interaxleSpacing": 5
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1,
        "axleUnitWeight": 16000,
        "interaxleSpacing": 1.5
      }
    ]


  Scenario: fail all wheelbase combinations 7 axle units
[
      {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 8000
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.5,
        "axleUnitWeight": 18000,
        "interaxleSpacing": 1
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.5,
        "axleUnitWeight": 19000,
        "interaxleSpacing": 3
      },
      {
        "numberOfAxles": 3,
        "axleSpread": 1.5,
        "axleUnitWeight": 24000,
        "interaxleSpacing": 5
      },
      {
        "numberOfAxles": 2,
        "axleSpread": 1.5,
        "axleUnitWeight": 16000,
        "interaxleSpacing": 5
      }
            {
        "numberOfAxles": 2,
        "axleSpread": 1,
        "axleUnitWeight": 20000,
        "interaxleSpacing": 1.5
      }
            {
        "numberOfAxles": 1,
        "axleSpread": null,
        "axleUnitWeight": 20000,
        "interaxleSpacing": 3
      }
    ]


Feature: Basic BCeID CV Client Create a New onRouteBC Profile

Feature: Basic BCeID CV Client Claim a onRouteBC Profile

Feature: Basic BCeID CV Client Invited User Log Into onRouteBC

User = CA, PA

# Rule: credential X must match invited username in onRouteBC

Rule: a user can choose to create a new onRouteBC Profile

Rule: a user can choose to claim an onRouteBC profile

Rule: a user must update mandatory contact details

Rule: 

  Scenario: 
    Given 
     When 
     Then 

