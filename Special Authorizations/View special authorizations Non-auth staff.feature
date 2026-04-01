Feature: Non-auth staff view special authorizations

Non-auth Staff = PC, Train, CTPO, FIN, EO

@orv2-2654-1 @orv2-3835-12
Rule: Non-auth staff can view a CV Clients no fee permits designation status

  Scenario: no fee active
    Given ABC Co. has the no fee flag active
     When Non-auth staff chooses to view ABC Co. special authorizations 
     Then they see the no fee status as active
      And they see the chosen no fee cv client type

  Scenario: no fee not active
    Given XYZ Co. does not the no fee flag active
     When Non-auth staff chooses to view special authorizations 
     Then they see the no fee status as not active
      And they see the no fee permit client type list

@orv2-2654-2 @orv2-3835-13
Rule: Non-auth staff can view a CV Client LCV designation status

  Scenario: LCV active
    Given ABC Co. has the LCV flag active
     When Non-auth staff chooses to view ABC Co. special authorizations 
     Then they see the LCV status as active
      And they see "Carrier meets the requirements to operate LCVs in BC."

  Scenario: LCV not active
    Given XYZ Co. does not the LCV flag active
     When Non-auth staff chooses to view special authorizations 
     Then they see the LCV status as not active
      And they see "Carrier meets the requirements to operate LCVs in BC."    

@orv2-2654-3 @orv2-3835-14
Rule: Non-auth staff can see a list of a CV Clients active LOA(s)

  Scenario: active LOA(s)
     When Non-auth staff view LOA(s)
     Then they see the following information in the list:
      | information     | description                                     |
      | LOA Number      | onRouteBC generated unique ID                   |
      | Start Date      | inputted by staff when adding or editing an LOA |
      | Expiry Date     | inputted by staff when adding or editing an LOA |
      | Download Letter | link to download the uploaded LOA    

  Scenario: default list sort
    Given there are active LOA(s)
     When Non-auth staff view LOA(s)
     Then the list is sorted by start date newest at the top in descending order      

@orv2-2654-4 @orv2-3835-15
Rule: Non-auth staff can see the status of a CV Clients LOA(s)

  Scenario: no active or expired LOA(s)
     When non-auth staff choose to view LOA(s)
     Then they see "Letter of Authorization (LOA) Carrier does not have any LOA(s)."

  Scenario: active LOA(s) and expired
     When non-auth staff choose to view LOA(s)
     Then they see a list of LOA(s)
      And they see the option to view expired LOA(S)
      And they see instruction text "Download the letter to see the specific travel terms of the LOA."

  Scenario: active LOA(s) no expired
     When staff choose to view LOA(s)
     Then they see a list of LOA(s)
      And they see instruction text "Download the letter to see the specific travel terms of the LOA."

  Scenario: no active but expired LOA(s)
     When non-auth staff choose to view LOA(s)
     Then they see the option to view expired LOA(S)

@orv2-2654-5 @orv2-3835-16
Rule Non-auth staff can download expired LOA(s)

  Scenario: expired LOA(s) exist
     When users choose to view an LOA letter
     Then the LOA is shown in a new browser tab
