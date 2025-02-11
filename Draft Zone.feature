User = CA, PA, SA, PC, CTPO, Trainee

Rule: Maximum 15 characters allowed in Transaction ID

Enter 16 characters
they see "Maximum 15 characters"

In staff shooping cart:

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

