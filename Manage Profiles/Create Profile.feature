@e2e1
Feature: Create New onRouteBC Profile
    As a CV Client Business BCeID user I want to sign in to onRouteBC using my BCeID credentials so that I can complete my company and user information details and create my onRouteBC Profile.

@orv2-369-1 
Scenario: First CV Client Business BCeID user sign into onRouteBC
    Given they have valid BCeID credentials
    And the CV Client onRouteBC Profile does not exist
    When they successfully sign in using their BCeID credentials
    Then they are directed to the "Welcome to onRouteBC" page
    And they see thier BCeID "Company Legal Name"

@orv2-369-2
Scenario: First CV Client Business BCeID user sign into onRouteBC create new profile
    Given they are at the "Welcome to onRouteBC" Page
    When they select "Create a new onRouteBC Profile"
    Then they are directed to the "Company Information" page in the wizard

@orv2-369-3
Scenario: First CV Client Business BCeID user "Company Information" in wizard
    Given they are at the "Company Information" in wizard
    When they input all required fields
    Then they can continue to the "My Information" page
    And they see an indication "Company Information" is complete on "My Information" page in the wizard
    
@orv2-369-4
Scenario: First CV Client Business BCeID user complete "My Information" in wizard
    Given they are at the "My Information" in wizard
    When they input all required fields
    Then their "My Information" details are saved
    And they are assigned the "Admin" role for the CV Client onRouteBC Profile 
    And they are directed to a success page
    And they get a unique onRouteBC Client Number

@orv2-369-5
Scenario: New CV Client Business BCeID user first time sign into onRouteBC
    Given the CV Client onRouteBC Profile exists
    When they successfully sign in using their BCeID credentials
    Then they are directed to the "My Information" page in the wizard

@orv2-369-6 @orv2-363-8
Scenario: New CV Client Business BCeID user first time sign into onRouteBC username does not match that entered by CV Client admin
    Given the CV Client onRouteBC Profile exists
    When they enter valid BCeID credentials
    Then they are directed to the "Contact Administrator" page in the wizard
    And they see "Contact your company onRouteBC administrator for assistance."

@orv2-369-7
Scenario: New CV Client Business BCeID user first time sign into onRouteBC complete user "My Information"
    Given they are at the "My Information" page in the wizard
    When they input all required fields in "My Information" 
    And they can complete the wizard
    Then their "My Information" details are saved
    And they are assigned the "Admin" role for the CV Client onRoute Profile 
    And they are directed to a "Success" page

@orv2-369-8 @orv-672-3
Scenario: CV Client Business BCeID sign into onRouteBC
    Given the CV Client onRouteBC Profile exists
    When they sign in successfully using their BCeID credentials 
    Then they are directed to the "Permits" page "Applications in Progress" tab

@orv2-369-9
Scenario: CV Client Business BCeID navigates away from first time sign in to onRouteBC
    Given the CV Client Admin or User is at "Company Information" or "My Information"
    And they have not completed the onRouteBC account creation
    When they navigate away from the page
    Then the onRouteBC account is not created

@orv2-369-10
Scenario: CV Client Business BCeID user added to a company profile first time sign in
    Given the CV Client Business BCeID user has been added to a company profile
    When they sign in successfully using their BCeID credentials
    Then they are directed to an accept invitation page
    
@orv2-369-11
Scenario: CV Client Business BCeID user added to a company profile first time sign in decline add to onRouteBC profile
    Given the CV Client Business BCeID user is at the invitation welcome page
    When they decline the invitation
    Then they are directed to the Welcome to onRouteBC page
    And they are removed from the "Pending User" list of the company that added them
    And their pending record is attributed as "declined"

@orv2-369-12
Scenario: CV Client Business BCeID user added to a company profile first time sign in accept add to onRouteBC profile
    Given the CV Client Business BCeID user is at the invitation welcome page
    When they accept the invitation
    Then they are directed to the "My Information" page in the wizard
    And they are removed from the "Pending User" list of the company that added them
    And they are designated as an "Active User" 

@orv2-369-13
Scenario: CV Client Business BCeID attempts to sign into onRouteBC and BCeID is not working
    Given the CV Client Admin or User has valid BCeID credentials 
    When they attempt to sign in using their BCeID credentials
    Then they are directed to a BCeID error page

@orv2-369-14
Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
    Given the CV Client Admin or User has invalid BCeID credentials 
    When they attempt to sign in to onRouteBC
    Then they are directed to a BCeID error page

Feature: Send onRouteBC profile creation confirmation email
As as CV Client I want to receive a confirmation email after successfully completing the required steps and creating my onRouteBC profile so that I can have a reference of this activity.

@orv2-477-1
Scenario: Send email when onRoute profile wizard is completed
    Given the user has completed the onRouteBC profile wizard
    When they are directed to the "success" page
    Then they receive a confirmation email to their company email and primary contact email address

@orv2-477-2
Scenario: View onRouteBC profile creation confirmation email
    Given the user has received the "confirmation email"
    When they view its contents
    Then they see <confirmation details>

    Examples: 
      | confirmation details           | 
      | Company Legal Name             | 
      | onRouteBC Profile Number       | 
      | Link to onRouteBC Webapp       | 
      | PPC Support Contact Phone      | 
      | PPC Support Contact Email      | 
      | Terms and Conditions Statement |   

Feature: Claim TPS Profile
As a CV Client admin I want to claim my TPS profile so that I can verify that I am the legitimate authority of my TPS profile.

Background: CV Client is signing into onRouteBC for the first time

@orv2-481-1
Scenario: Choose create profile option
    Given the CV Client admin is at the "Welcome to onRouteBC" page
    When they select "Claim an existing TPS Profile"
    Then they are directed to the "Enter TPS Client ID" page in the wizard
    And they see "Enter TPS Client ID" wizard step indication
    And they see "Where can I find my TPS Client ID and permit details?" information box
    And they see "Don't have a TPS Profile?" "Create onRouteBC Profile" link
 (image will need to be updated with new permit template)

@orv2-481-2
Scenario: CV Client enters invalid TPS client ID
    Given they are at the "Enter TPS Client ID" page in the wizard
    When they enter a "TPS Client ID" that does not match the company "TPS Client ID"
    Then they see "Invalid number"
    And indication of an incorrect match
    And they cannot procced to the next step

@orv2-481-3
Scenario: CV Client enters a valid TPS client ID
    Given they are at the "Enter TPS Client ID" page
    When they enter a "TPS Client ID" that matches the company "TPS Client ID"
    Then they see indication of a correct match
    And they can proceed to the next step

@orv2-481-4
Scenario: CV Client continues to "Verify TPS Client ID"
    Given they are at the "Enter TPS Client ID" page
    And they have entered the correct TPS Client ID
    When they select "Next"
    Then they are directed to the "Verify TPS Client ID" page in the wizard
    And they see "Enter TPS Client ID" success indication
    And they see "Verify TPS Client ID" wizard step indication 
    And they see the accepted TPS Client ID 
    And they see permit number information box

@orv2-481-5
Scenario: CV Client return to "Enter TPS Client ID"
    Given they are at the "Verify TPS Client ID" page
    When they select "Previous" 
    Then they are directed to the "Enter TPS Client ID" page

@orv2-481-6
Scenario: CV Client enter valid Inspection Station Credit Account number
    Given they are at the "Verify TPS Client ID" page
    When they enter an valid "Inspection Station Credit Account"
    Then they see indication of an correct match
    And they can continue to the next step

@orv2-481-7
Scenario: CV Client enter invalid Inspection Station Credit Account number
    Given they are at the "Verify TPS Client ID" page
    When they enter an invalid "Inspection Station Credit Account"
    Then they see "Invalid number"
    And indication of an incorrect match

@orv2-481-8
Scenario: CV Client enter valid Permit number
    Given they are at the "Verify TPS Client ID" page
    When they enter an valid "Permit Number"
    Then they see indication of an correct match
    And they can continue to the next step

@orv2-481-9
Scenario: CV Client enter invalid Permit number
    Given they are at the "Verify TPS Client ID" page
    When they enter an invalid "Permit Number"
    Then they see "Invalid number"
    And indication of an incorrect match

@orv2-481-10
Scenario: CV Client continue to "Company Information"
    Given they have successfully complete "Claim an existing TPS Account"
    When they select "Next"
    Then they are directed to the "Company Information" page in the wizard