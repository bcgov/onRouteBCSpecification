Feature: CV Client view rejected application

CV Client = CA, PA

@orv2-2474
Rule: CV Client cannot see the IDIR username stamp when viewing the reason(s) for rejection

  Scenario: rejected once
    Given A1-72303011-028 is rejected
     When a CV Client chooses to view A1-72303011-028
     Then they see the reason(s) for rejection history <reason(s)> and <date / time> stamp
      But they do not see the IDIR username 

      Examples:
        | reason(s)                                                                                 | date / time                    |
        | Going down, party time. My friends are gonna be there too, yeah. I'm on the highway to hell | Jun. 13, 2024, 8colon23 am PDT |

  Scenario: rejected 2 times
    Given A1-72303011-028 has been rejected 2 times
     When a CV Client chooses to view A1-72303011-028
     Then they see the reason(s) for rejection history <reason(s)> and <date / time> stamp
      But they do not see the IDIR username 

      Examples:
        | reason(s)                                                                                                            | date / time                     |
        | Going down, party time. My friends are gonna be there too, yeah. I'm on the highway to hell                       | Jun. 13, 2024, 8colon23 am PDT  |
        | Life is a highway, I wanna ride it all night long. If you're goin' my way, Well, I wanna drive it all night long. | Jun. 13, 2024, 02colon09 pm PDT |
