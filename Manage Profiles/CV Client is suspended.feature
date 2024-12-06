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

  Scenario: Manual URL access (bookmarked or cached URL used to access onRouteBC)
    Given a CV Client is not logged into onRouteBC
     When they attempt to access onRouteBC via a bookmarked or cached application URL
      And they submit their valid credentials 
     Then they see "User Unauthorized"

  Scenario: logged in choose permits
    Given cv client is logged in
     When they choose to view permits
     Then they see "User Unauthorized"
      And they see "Company Suspended"

