Feature: Staff global navigation (sticky side bar)

Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA

@orv2-1378-1
Rule: Navigation options are always visible to staff

  Scenario: At home page
    Given staff are signed in
     When they are at the staff home page Welcome to onRouteBC!
     Then they see global navigation options

@orv2-1378-2
Rule: Always in the same relative screen position

  Scenario: Scrolling the page
    Given staff are on any page
      And the page requires scrolling to view all information desired
     When they scroll the page down or up
     Then the global navigation options remain visible in the same position

@orv2-1378-3 @orv2-3835
Rule: Navigate to the staff home page based on their group permission

  Scenario: Navigate to home page
    Given staff are on any page
     When they choose to navigate to the staff home page
     Then they are directed to the staff home page

  Scenario: EO
     When EO choose to navigate home
     Then they see "Welcome to onRouteBC"
      And they do not see the staff queue

@orv2-1378-4 @orv2-3835
Rule: only authorized staff can navigate to the reports page

  Scenario: authorized
    Given staff are on any page
     When they choose to navigate to the reports page
     Then they are directed to the reports page

  Scenario: not authorized
    Given EO are on any page
     When they choose to navigate to the reports page
     Then they do not see the optional to navigate to the reports page

@orv2-1378-5
Rule: Hover on navigation option displays help text and indicates the selection

  Scenario: Hover over option on global navigation displays help text
    Given staff are on any page
     When they hover over a <navigation option> 
     Then they see <help text>

     Examples:
       | navigation option       | help text                       |
       | home                    | home                            |
       | reports                 | reports                         |
       | bridge calculation tool | Bridge Formula Calculation Tool |

@orv2-1378-6
Rule:  Indicates the page actively on

  Scenario: Indicate navigation option location
    Given staff are on any page
     When they choose to navigate to a global navigation option
     Then they are directed to the chosen option
      And the chosen option is indicated 

@orv2-1378-7
Rule: On page not available via global navigation

  Scenario: No option chosen
    Given staff are on any page not available via global navigation
     When they view the global navigation options
     Then all options are unindicated

@orv2-1378-8
Rule: Navigating using the global navigation bar when acting as a company will reset the context to no company

@orv2-2916-26 @orv2-3835
Rule: only authorized staff can navigate to the bridge calculation tool

  Scenario: authorized
    Given PC, SA, TRAIN, CTPO, EO, HQA are on any page
     When they choose to navigate to the bridge formula calculation tool
     Then they are directed to the bridge calculation tool

  Scenario: not authorized
    Given FIN are on any page
     When they choose to navigate to the bridge formula calculation tool
     Then they do not see the option to navigate to the bridge calculation tool

@orv2-2916-27
Rule: EO only see the home and bridge formula calculation tool option on the global navigation bar