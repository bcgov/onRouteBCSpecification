@orv2-5899 https://moti-imb.atlassian.net/browse/ORV2-5899
Feature: As a user I would like to see what overload amount onRouteBC will use to calculate the permit fee, so that I can more easily understand what the basis of the overload is.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Background: The overload calculations details (OCD) table is shown to the user on the permit application, review and confirm, and permit template pages. It shows the overload amount that onRouteBC will use to calculate the permit fee. The OCD table is shown in addition to any violations that are present (e.g., bridge violation). The OCD table is only shown, if there are overloads present.

| Data Elements    | Description                                                                                                                                                                                                                                                                                                       |
| Axle Units(s)   | The axle unit(s) that the overload amount is calculated for. This can be a single axle unit, a group of axle units, or all axle units in the ASW table (for Licensed GCVW overloads).                                                                                                                             |
| LGCVW (kg)      | The Licensed GCVW for the vehicle combination. This is only shown if the overload amount is calculated based on Licensed GCVW vs Actual GCVW.                                                                                                                                                                     |
| Actual (kg)     | The actual weight of the axle unit(s) (Axle Unit Weight (kg) individually or summed as part of a group) that the overload amount is calculated for. This is only shown if the overload amount is calculated based on a single axle unit or a group of axle units.                                                                                                                   |
| Legal Max. (kg) | The legal maximum weight for the axle unit(s) that the overload amount is calculated for (Overweight Dimension Set, 7.16g, 7.17). This is only shown if the overload amount is calculated based on a single axle unit or a group of axle units.                                                                                                           |
| Total GCVW (kg) | The total GCVW for the vehicle combination. This is only shown if the overload amount is calculated based on Licensed GCVW vs Actual GCVW.                                                                                                                                                                        |
| Overload (kg)   | The overload amount that onRouteBC will use to calculate the permit fee. This is calculated as the difference between the Actual weight and the Legal Max. weight for a single axle unit or a group of axle units, or as the difference between the Total GCVW and the Licensed GCVW for Licensed GCVW overloads. |


@orv2-5899-1
Rule: A user can see the overload calculation details (OCD) table on the permit application, review and confirm, and permit template.

 # See permit template design for OCD table layout and content.

@orv2-5899-2
Rule: The OCD table is shown in addition to any violations that are present (e.g., bridge violation).

@orv2-5899-3
Rule: The OCD table is only shown, if there are overloads present.

@orv2-5899-4
Rule: The OCD table is defaulted to expanded, but can be collapsed by the user on both the permit application and review and confirm pages.

 # Note: when collapsed white space is not reserved for the OCD table, so that the user can see more of the permit application or review and confirm page.

@orv2-5899-5
Rule: The OCD table shows only the overload amount details that onRouteBC will use to calculate the permit fee. 

 # See: ASW use greater overweight value.feature for how the overload amount is chosen.

@orv2-5899-6
Rule: Calculated overload amounts not chosen for the permit fee calculation are not shown in the OCD table. For example, if the overload amount is calculated based on LGVW and Total GCVW, then the Actual and Legal Max columns are hidden in the OCD table.

 Scenario: LGVW and GVW chosen for overload calculation
   Given the number of axle units is 3
     And the user has input the following weights for each axle unit:
      | Axle Unit | Axle Unit Weight (kg) |
      | 1         | 6,000                 |
      | 2         | 23,000                |
      | 3         | 23,000                |
     And the users power unit has a LGVW of 35,000 kg
    When overload amount is calculated based on LGVW and Total GCVW
    Then the Actual and Legal Max columns are hidden in the OCD table
     And they see the following columns and rows:
      | Axle Units(s) | LGVW (kg) | Total GCVW (kg) | Overload (kg) |
      | 1 - 3         | 35,000    | 52,000          | 17,000        |
     And they see Total (kg) 17,000

  Scenario: Single axle unit chosen for overload calculation, Actual and Legal Max columns are shown in the OCD table
    Given the number of axle units is 3
      And the user has input the following weights for each axle unit:
       | Axle Unit | Axle Unit Weight (kg) |
       | 1         | 6,000                 |
       | 2         | 23,000                |
       | 3         | 23,000                |
     When overload amount is calculated based on single axle unit
     Then they see the following columns and rows:
      | Axle Units(s) | Actual (kg) | Legal Max. (kg) | Overload (kg) |
      | 3             | 23,000      | 17,000          | 6,000         |
     And they see Total (kg) 6,000

  Scenario: Axle group and axle units chosen for overload calculation, Actual and Legal Max columns are shown in the OCD table
    Given the number of axle units is 4
      And the user has input the following weights for each axle unit:
       | Axle Unit | Axle Unit Weight (kg) |
       | 1         | 7,560                 |
       | 2         | 28,000                |
       | 3         | 26,000                |
       | 4         | 9,100                 |
     When overload amount is calculated based on axle group and axle units
     Then they see the following columns and rows:
      | Axle Units(s) | Actual (kg) | Legal Max. (kg) | Overload (kg) |
      | 1             | 7,560       | 7,300           | 250           |
      | 2             | 28,000      | 24,000          | 4,000         |
      | 3 - 4         | 35,100      | 31,000          | 4,100         |
     And they see Total (kg) 8,350

@orv2-5899-7
Rule: Axle groups are shown as a range of axle units in the OCD table. For example, if axle units 3 and 4 are grouped together because they are chosen as a valid overload, then the Axle Units(s) column shows "3 - 4".

  Scenario: Axle group chosen for overload calculation, Axle Units(s) column shows range of axle units
     When overload amount is calculated based on axle group 3 - 4 
      And there are no other overloads present
     Then they see the following columns and rows:
      | Axle Units(s) | Actual (kg) | Legal Max. (kg) | Overload (kg) |
      | 3 - 4         | 35,100      | 31,000          | 4,100         |
     And they see Total (kg) 4,100

@orv2-5899-8
Rule: a Licensed GCVW overload is shown in the OCD table as a single row with the Axle Units(s) column showing all axles in the ASW table as a range (e.g., "1 - 4")

  Scenario: Licensed GCVW chosen for overload calculation, 
    Given the number of axle units is 4
     When overload amount is calculated based on Licensed GCVW vs Actual GCVW
     Then they see the following columns and rows:
      | Axle Units(s) | LGCVW (kg) | Total GCVW (kg) | Overload (kg) |
      | 1 - 4         | 70,000     | 70,660          | 660           |
     And they see Total (kg) 660

@orv2-5899-9
Rule: Numbers greater than 999 are shown with commas in the OCD table. For example, 1000 is shown as 1,000 and 10000 is shown as 10,000.

@orv2-5899-11
Rule: The OCD table is updated when the user changes any of the ASW table inputs and recalculates the overload amount.



# Notes
- Show how we calculate the overload
- Collapsible OCD?
	- Default to expanded
- Show on permit application, review and confirm, permit template
- Info box will always show
- Would show in addition to violations
	- e.g. Bridge violation
- More then 3 digit numbers will have commas
### Table OCD
- Show only those overload values that trigger overload calculation which means we could hide columns or rows
	- e.g., LGVW and Total GCVW, hide Actual and Legal Max columns
	- e.g., axle unit rows
- Show Final Calculated Overload (kg)
- Axles column can be axle units or axle groups or licensed vs actual gcvw (all axles)
	- e.g., 1, 1-2 (when the row is a part of the overload calculation) etc.
