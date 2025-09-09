Feature: Wheel Spacing and Spread Diagram (WSSD)
The wheel spacing and spread diagram (WSSD) is a visual representation of the axle units and their spacing on a vehicle. It is used to illustrate compliance with regulations regarding axle loads and spacing.

O       O     O             O  O  O
|--SPC--|-SPD-|-----SPC-----|-SPD-|
1          2                   3  

User = CA, PA, PC, SA, TRAIN, CTPO

@orv2-4412-1
Rule: show vehicle configuration picture if it exists and wheels only if not but only if the entire vehicle configuration exists

  Scenario: vehicle configuration picture exists
     Given the user has added a power unit (PU)
       And the user has added a jeep
       And the user has added a trailer with a tridem axle unit
       And the user has inputted the axle spacings and spreads
     When the user views the WSSD
     Then they see the vehicle configuration picture...

  Scenario: vehicle configuration picture does not exist but wheels do
     Given the user has added a power unit (PU)
       And the user has added a jeep
       And the user has added a trailer with a tridem axle unit
       And the user has inputted the axle spacings and spreads
     When the user views the WSSD
     Then they see:
     O           O        O                 O    O   O
     |--Spacing--|-Spread-|-----Spacing-----|-Spread-|
     1                2                          3   

@orv2-4412-2
Rule: show diagram based on vehicle sub-type

  Scenario: tractor trailers
     Given the user has added a tractor trailer
       And the user has added a jeep
       And the user has added a trailer with a tridem axle unit
       And the user has inputted the axle spacings and spreads
     When the user views the WSSD
     Then they see...

@orv2-4412-3
Rule: show full "Spacing" and "Spread" words when possible

  Scenario: full words
     Given the user has added a power unit (PU)
       And the user has added a jeep
       And the user has added a trailer with a tridem axle unit
       And the user has inputted the axle spacings and spreads
       And there is adequate room to display full words
     When the user views the WSSD
     Then they see:
     O           O        O                 O    O   O
     |--Spacing--|-Spread-|-----Spacing-----|-Spread-|
     1                2                          3   

@orv2-4412-4
Rule: if diagrams extends beyond the width of the page user can optionally horizontal scroll diagram

@orv2-4412-5
Rule: the axle unit number is drawn per axle unit 

  Scenario: 3 axle units
    Given the user has added a power unit (PU)
      And the user has added a jeep
     When the user views the WSSD
     Then they see:
     OOO
     |||
     123

@orv2-4412-6
Rule: a power unit (PU) has 2 axle units drawn by default

  Scenario: power unit (PU) default
    Given the user has added a power unit (PU)
     When the user views the WSSD
     Then they see:
     O       O
     |--Spc--|
     1       2

@orv2-4412-7
Rule: trailers have a 1 axle unit drawn by default

  Scenario: trailer default
    Given a power unit (PU) has been added 
      And the user has added a trailer
     When the user views the WSSD
     Then they see:
       O       O         O
       |--Spc--|---Spc---|
       1       2         3  

@orv2-4412-8
Rule: draw individual axle units after number of axle units is inputted and user tabs to another field

  Scenario: doesn't tab
     Given the user has inputted a number of axles 3 for a crane
     When the user does not tab to another field
     Then they see:
       OO
       ||
       12

  Scenario: tabs
     Given the user has inputted a number of axles 3 for a crane
      And the user tabs to another field
     Then they see:
       OOO
       |||
       123

@orv2-4412-9
Rule: draw individual axle unit types based on the user inputted number of axles

  Scenario: single
     When a user inputs numbers of axles 1 for a single axle unit
     Then they see single wheel, vertical Line and axle unit number:
     O
     | 
     1

  Scenario: tandem
     When a user inputs number of axles 2 for a tandem axle unit
     Then they see tandem wheels, vertical line(s), the spread dimension line and axle unit number:
     O     O
     |-Spd-|
        1

  Scenario: tridem
     When a user inputs number of axles 3 for a tridem axle unit
     Then they see tridem wheels, vertical line(s), the spread dimension line and axle unit number:
     O  O  O
     |-Spd-|
        1

  Scenario: add number of axles for pu only
     When a user inputs the number of axles 2 for the PU axle unit 2
      And tabs to another field
     Then they see:
     OO     O
     ||-Spd-|
     1   2   

  Scenario: add inter axle spacing between the PU and jeep only
     When a user inputs the interaxle spacing for jeep
      And tabs to another field
     Then they see:
     OO     O
     ||-Spc-|
     12     3

@orv2-4412-10
Rule: draw interaxle spacing based on vehicle sub-type

  Scenario: tractor trailers
     Given the user has added a tractor trailer
       And the user has added a jeep
       And the user has added a trailer with a tridem axle unit
       And the user has inputted the axle spacings and spreads
     When the user views the WSSD
     Then they see...
     
# Deprecated:

 Rule: draw variable spacing interaxle spacing dimension lines after user inputs interaxle spacing and tabs to another field

   Scenario: doesn't tab
     Given the user has inputted the interaxle spacing for the PU
      When the user does not tab to another field
      Then they see:
      OO
      ||
      12

   Scenario: tabs
     Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 0.01-3.5m
      When the user tabs to another field
      Then they see:
      O   O
      |Spc|
      1   2

 Rule: draw variable spacing interaxle spacing dimension line based on the user inputted interaxle spacing 
   
   Scenario: (no) spacing
      Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 0m
      When the user tabs to another field
      Then they see:
      OO
      ||
      12
       And the pixel spacing is 4px between outside wheel diameter

   Scenario: (extra-small) spacing
      Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 0.01-3.5m
      When the user tabs to another field
      Then they see:
      O   O
      |Spc|
      1   2
       And the pixel spacing is 44px between axle unit centres

   Scenario: (small) spacing
      Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 3.51-4.20m
      When the user tabs to another field
      Then they see:
      O     O
      |-Spc-|
      1     2
       And the pixel spacing is 84px between axle unit centres

   Scenario: (medium) spacing
      Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 4.21-6.99m
      When the user tabs to another field
      Then they see:
      O       O
      |--Spc--|
      1       2
       And the pixel spacing is 124px between axle unit centres

   Scenario: (large) spacing
      Given the user has inputted the interaxle spacing for the PU
       And the interaxle spacing for the PU is 7+m
      When the user tabs to another field
      Then they see:
      O         O
      |---Spc---|
      1         2
      And the pixel spacing is 208px between axle unit centres

   Scenario: add inter axle spacing between the PU and jeep only
      When a user inputs the interaxle spacing between the PU and jeep
       And the interaxle spacing for the PU is 0.01-3.5m
       And the user tabs to another field
      Then they see:
      OO   O
      ||Spc|
      12   3





