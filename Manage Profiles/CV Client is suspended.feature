Feature: CV Client is suspended

CV Client = CA, PA, Agent

@orv2-1881-1
Rule: A suspended CV Client does not have access to the onRouteBC profile

  Scenario: CV Client logs into onRouteBC
    Given a CV Client has successfully logged into onRouteBC
     When submit their valid credentials 
     Then they are directed to the "Company Suspended" page
      And they have no additional navigation options in onRouteBC
      And they see:
       |For assistance please contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca |

