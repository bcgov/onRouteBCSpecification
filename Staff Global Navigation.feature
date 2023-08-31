Feature: Staff global navigation (sticky side bar)

Rule: Navigation options are always visible to PPC Admin, PPC Clerk

@orv2-1378-1
  Scenario: At home page
    Given PPC Admin or PPC Clerk are signed in
     When they are at the staff home page Welcome to onRouteBC!
     Then they see global navigation options

Rule: Always in the same relative screen position

@orv2-1378-2
  Scenario: Scrolling the page
    Given PPC Admin or PPC Clerk are on any page
      And the page requires scrolling to view all information desired
     When they scroll the page down or up
     Then the global navigation options remain visible in the same position

Rule: Navigate to the staff home page Welcome to onRouteBC!

@orv2-1378-3
  Scenario: Navigate to home page
    Given PPC Admin or PPC Clerk are on any page
     When they choose to navigate to the staff home page Welcome to onRouteBC!
     Then they are directed to the staff home page Welcome to onRouteBC!

Rule: Navigate to the reports page

@orv2-1378-4
  Scenario: Navigate to the reports page
    Given PPC Admin or PPC Clerk are on any page
     When they choose to navigate to the reports page
     Then they are directed to the reports page

Rule: Hover on navigation option displays help text and indicates the selection

@orv2-1378-5
  Scenario: Hover over option on global navigation displays help text
    Given PPC Admin or PPC Clerk are on any page
     When they hover over a <navigation option> 
     Then they see <help text>

     Examples:
       | navigation option | help text |
       | home              | home      |
       | reports           | reports   |

Rule:  Indicates the page actively on

@orv2-1378-6
  Scenario: Indicate navigation option location
    Given PPC Admin or PPC Clerk are on any page
     When they choose to navigate to a global navigation option
     Then they are directed to the chosen option
      And the chosen option is indicated 

Rule: On page not available via global navigation

@orv2-1378-7
  Scenario: No option chosen
    Given PPC Admin or PPC Clerk are on any page not available via global navigation
     When they view the global navigation options
     Then all options are unindicated

