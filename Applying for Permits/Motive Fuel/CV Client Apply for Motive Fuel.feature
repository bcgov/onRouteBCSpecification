


Rule: Users must input an origin, destination and exit point chosen from the resolved geocoder list

  Scenario: no origin, destination and exit point is inputted
     When a user chooses to continue to review and confirm
     Then they cannnot continue
      And they see "You must enter a valid address."
      And the mandatory field is indicated

  Scenario: user inputted text
    Given a user has inputted text in origin, destination or exit point
      And has not chosen a resolved address from the geocoder list 
     When they chose to continue
     Then they cannnot continue
      And they see "You must enter a valid address."
      And the mandatory field is indicated

Rule: The origin, destination and exit point is resolved and the chosen resolved address replaces text inputted by the user 

  Scenario: 940 blanshard
     When a user has inputted 940 Blanshard
     Then they see the following list:
       | BC Places                      |
       | 940 Blanshard St, Victoria, BC |
       | 940 Blanshard Dr, Richmond, BC |
       | Blanshard St, Saanich, BC      |
       | Blanshard Rd, Bouchie Lake, BC |
       | Blanshard Rd, Malahat, BC      |
       | Blanshard Rd, Vernon, BC       |
       | Blanshard St, Maple Ridge, BC  |