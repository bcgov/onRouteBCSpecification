Feature: Global Notification
As authorized staff I want to be able to submit custom text based content for display withing a specific time range to onRouteBC users when they first log into onRoute.

Staff = HQA
Users = All 

@orv2-3280-1
Rule: Update global notification content 

# what is possible for the content?

@orv2-3280-2
Rule: Display global notification when user logs in
 # on the website this would remain visible
 
  Scenario: new log in
    Given the user not currently logged in to onRouteBC
     When they log in
     Then they see the global notification

  Scenario: currently logged in
    Given the user currently logged in to onRouteBC
     When they open onRouteBC
     Then they see do not see the global notification
|
@orv2-3280-5
Rule: Users can optionally close the global notification

  Scenario: 1st log in
    Given user has not logged into onRouteBC
     When they log into onRouteBC
      And the global notification exists
     Then they see the global notification

  Scenario: 2nd log in
    Given user has previously logged into onRouteBC
      And closed the global notification 
     When they log into onRouteBC again
      And the global notification exists
     Then they see the global notification
|
# @orv2-3280-3 - Planned for future update
# Rule: Set start date/time and end date/time to display the global notification to users

  Scenario: start date/time
    Given staff have set a start date time of  Apr. 15, 2025, 8:23 am PDT 
     When a user logs into onRoute on or after Apr. 15, 2025, 8:23 am PDT
      But before the end date/time
     Then they see the global notification 

  Scenario: end date/time
    Given staff have set a end date time of  Apr. 19, 2025, 2:30 pm PDT 
     When a user logs into onRoute on or after Apr. 19, 2025, 2:30 pm PDT
     Then they do not see the global notification 

@orv2-3280-4
Rule: Users can optionally close the displayed global notification

# this should not be possible on the website